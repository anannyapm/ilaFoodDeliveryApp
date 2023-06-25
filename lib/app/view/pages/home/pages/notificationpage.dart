import 'package:flutter/material.dart';

class NotificationPage extends StatelessWidget {
  final List<String> notifications = [
    'Notification 1',
    'Notification 2',
    'Notification 3',
    'Notification 4',
    'Notification 5',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Notifications'),
      ),
      body: ListView.builder(
        itemCount: notifications.length,
        itemBuilder: (context, index) {
          final notification = notifications[index];
          return ListTile(
            contentPadding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
            leading: Icon(
              Icons.notifications,
              color: Colors.blue,
            ),
            title: Text(
              notification,
              style: TextStyle(
                fontWeight: FontWeight.bold,
              ),
            ),
            subtitle: Text(
              'Lorem ipsum dolor sit amet, consectetur adipiscing elit.',
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            trailing: Icon(
              Icons.arrow_forward_ios,
              color: Colors.grey,
            ),
          );
        },
      ),
    );
  }
}
