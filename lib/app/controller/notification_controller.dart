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

  Future<void> getAllNotifications() async {
    DateTime currentDate = DateTime.now();

  // Set the start and end timestamps for today
  DateTime startOfToday = DateTime(currentDate.year, currentDate.month, currentDate.day-1);
  Timestamp startTimestamp = Timestamp.fromDate(startOfToday);
    isLoading.value = true;
    QuerySnapshot querySnapshot = await notificationCollectionRef.where('startTime',isGreaterThanOrEqualTo:startTimestamp )
        .orderBy('startTime', descending: true)
        .get();
    notifications.value = querySnapshot.docs
        .map((querysnap) => NotificationModel.fromSnapshot(querysnap))
        .toList();
    isLoading.value = false;
  }

 
}
