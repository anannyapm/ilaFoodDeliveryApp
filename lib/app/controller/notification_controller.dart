import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:get/get.dart';
import 'package:ila/app/view/pages/home/pages/notificationpage.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';

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
    getAllNotifications();

    super.onInit();
  }

  RxList<NotificationModel> notifications = RxList<NotificationModel>([]);
  RxBool isLoading = false.obs;

  Future<void> initializeOneSignal() async {
    OneSignal.shared.setNotificationWillShowInForegroundHandler(
        (OSNotificationReceivedEvent event) async {
      // Will be called whenever a notification is received in foreground
      // Display Notification, pass null param for not displaying the notification
      event.complete(event.notification);

      /* await addtoNotificationDB(event.notification.body ?? "",
          event.notification.title ?? "", DateTime.now()); */
      getAllNotifications();
    });

    OneSignal.shared
        .setNotificationOpenedHandler((OSNotificationOpenedResult result) {
      Get.to(() => const NotificationPage());

      // Will be called whenever a notification is opened/button pressed.
    });

    OneSignal.shared.setPermissionObserver((OSPermissionStateChanges changes) {
      // Will be called whenever the permission changes
      // (ie. user taps Allow on the permission prompt in iOS)
    });

    OneSignal.shared
        .setSubscriptionObserver((OSSubscriptionStateChanges changes) {
      // Will be called whenever the subscription changes
      // (ie. user gets registered with OneSignal and gets a user ID)
    });

    OneSignal.shared.setEmailSubscriptionObserver(
        (OSEmailSubscriptionStateChanges emailChanges) {
      // Will be called whenever then user's email subscription changes
      // (ie. OneSignal.setEmail(email) is called and the user gets registered
    });
  }

  /* final _androidChannel = const AndroidNotificationChannel(
      'ila_notification_channel', 'ila_notifications',
      description: 'This channel is used for important notifications from ila',
      importance: Importance.defaultImportance);

  final FlutterLocalNotificationsPlugin _localNotifications =
      FlutterLocalNotificationsPlugin(); */

  Future<void> addtoNotificationDB(
      String body, String title, DateTime startTime) async {
    
    NotificationModel notificationModel = NotificationModel(
      body: body,
      title: title,
      startTime: startTime,
    );

    notificationCollectionRef
        .add(notificationModel.toSnapshot())
        .then((value) => log('Notification added to Firestore'))
        .catchError((error) => log('Failed to add notification: $error'));
  }

  /* void handleMessage(RemoteMessage? message) {
    log("here");
    if (message == null) {
      return;
    } else {
      // addtoNotificationDB(message);
      getAllNotifications();
      // message = null;
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
 */
  Future<void> getAllNotifications() async {
    isLoading.value = true;
    QuerySnapshot querySnapshot = await notificationCollectionRef
        .orderBy('startTime', descending: true)
        .get();
    notifications.value = querySnapshot.docs
        .map((querysnap) => NotificationModel.fromSnapshot(querysnap))
        .toList();
    isLoading.value = false;
  }

  Future<void> _deleteAllNotification() async {
    final notificationSnapshot = await notificationCollectionRef.get();
    final batch = firebaseFirestore.batch();

    for (var doc in notificationSnapshot.docs) {
      batch.delete(doc.reference);
    }

    

    await batch.commit();
  }
  void deleteNotification() async {
      await _deleteAllNotification();
      await getAllNotifications();
      Get.back();
    }
}
