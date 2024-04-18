import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/widgets.dart';

class PhotoNotification extends StatefulWidget {
  const PhotoNotification({super.key});

  @override
  State<PhotoNotification> createState() => _PhotoNotificationState();
}

class _PhotoNotificationState extends State<PhotoNotification> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          'Notification',
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Colors.white),
        ),
      ),
      body: Container(
        padding: const EdgeInsets.all(8),
        color: Colors.black,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: ListView.builder(
                  itemCount: 20,
                  itemBuilder: (context, index) {
                    return const ListTile(
                      leading: CircleAvatar(
                        backgroundColor: Colors.grey,
                        child: Icon(
                          Icons.person,
                          color: Colors.white,
                        ),
                      ),
                      title: Text(
                        'Notifications are here',
                        style: TextStyle(color: Colors.white),
                      ),
                    );
                  }),
            )
          ],
        ),
      ),
    );
  }
}
