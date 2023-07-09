import 'package:cloud_firestore/cloud_firestore.dart';

class NotificationModel {
  String? notificationId;
  String? userId;
  String? body;
  String? title;
  DateTime? startTime;

  NotificationModel(
      {this.notificationId,
      this.body,
      this.title,
      this.startTime,
      });

  NotificationModel.fromSnapshot(DocumentSnapshot data) {
    notificationId = data.id;
    body = data["body"];
   
    startTime = data["startTime"].toDate();
    title = data["title"];
  }
  Map<String, dynamic> toSnapshot() {
    return {
      
      "startTime": Timestamp.fromDate(startTime!),
      "body": body,
      
      "title": title
    };
  }
}
