import 'dart:convert';
import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:ila/app/utils/constants/controllers.dart';
import 'package:ila/app/view/pages/home/pages/notificationpage.dart';

import '../model/notification_model.dart';
import '../services/firebase_services.dart';

@pragma('vm:entry-point')
Future<void> handleBackgroundMessage(RemoteMessage message) async {
  log("Title ${message.notification?.title}");
  log("Body ${message.notification?.body}");
  log("Payload ${message.data}");
}

class NotificationController extends GetxController {
  static NotificationController instance = Get.find();

  @override
  void onInit() {
    notificationCollectionRef = firebaseFirestore.collection("notifications");

    super.onInit();
  }

  RxList<NotificationModel> notifications = RxList<NotificationModel>([]);

  final _androidChannel = const AndroidNotificationChannel(
      'ila_notification_channel', 'ila_notifications',
      description: 'This channel is used for important notifications from ila',
      importance: Importance.defaultImportance);

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin();

  void addtoNotificationDB(RemoteMessage message) {
    String body = message.notification?.body ?? '';
    String title = message.notification?.title ?? '';
    DateTime startTime = message.sentTime ?? DateTime.now();

    NotificationModel notificationModel =
        NotificationModel(body: body, title: title, startTime: startTime,userId: userController.userModel.userId);

    notificationCollectionRef
        .add(notificationModel.toSnapshot())
        .then((value) => log('Notification added to Firestore'))
        .catchError((error) => log('Failed to add notification: $error'));
  }

  void handleMessage(RemoteMessage? message) {
    if (message == null) {
      return;
    } else {
      addtoNotificationDB(message);
      getAllNotifications();
      Get.to(() => const NotificationPage());
    }
  }

  Future<void> initLocalNotifications() async {
    const android = AndroidInitializationSettings('@mipmap/ic_launcher');
    const settings = InitializationSettings(android: android);
    await _localNotifications.initialize(settings,
        onDidReceiveNotificationResponse: (response) {
      String payload = response.payload!;
      final message = RemoteMessage.fromMap(jsonDecode(payload));
      handleMessage(message);
    });

    final platform = _localNotifications.resolvePlatformSpecificImplementation<
        AndroidFlutterLocalNotificationsPlugin>();
    await platform?.createNotificationChannel(_androidChannel);
  }

  Future initPushNotifications() async {
    await FirebaseMessaging.instance
        .setForegroundNotificationPresentationOptions(
            alert: true, badge: true, sound: true);
    FirebaseMessaging.instance.getInitialMessage().then(handleMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleMessage);
    FirebaseMessaging.onBackgroundMessage(handleBackgroundMessage);
    FirebaseMessaging.onMessage.listen((message) {
      final notification = message.notification;
      if (notification == null) {
        return;
      } else {
        _localNotifications.show(
            notification.hashCode,
            notification.title,
            notification.body,
            NotificationDetails(
                android: AndroidNotificationDetails(
                    _androidChannel.id, _androidChannel.name,
                    channelDescription: _androidChannel.description,
                    icon: '@mipmap/ic_launcher')),
            payload: jsonEncode(message.toMap()));
      }
    });
  }

  Future<void> initNotifications() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    log('User granted permission: ${settings.authorizationStatus}'); //return value indicating if permisiion given oor not

    initPushNotifications();
    initLocalNotifications();
  }

  Future<void> getAllNotifications() async {
    QuerySnapshot querySnapshot = await notificationCollectionRef
      .where('userId', isEqualTo: userController.userModel.userId)
      .get();
    notifications.value = querySnapshot.docs
        .map((querysnap) => NotificationModel.fromSnapshot(querysnap))
        .toList();
        
  }
}
