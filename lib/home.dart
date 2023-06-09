import 'dart:convert';

import 'package:fire_notification/notification_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    notificationServices.requestNotificationPermission();
    notificationServices.firebaseInit(context);
    notificationServices.setupInteractMessage(context);
    // notificationServices.showNotification();
    notificationServices
        .getDeviceToken()
        .then((value) => debugPrint(value.toString()));
    notificationServices.isTokenRefresh();

    // notificationServices.initLocalNotification(context, message)
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Notification screen'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: () {
            String url = 'https://fcm.googleapis.com/fcm/send';
            notificationServices.getDeviceToken().then((value) async {
              var data = {
                'to': value.toString(),
                // 'evmUewArTduyugQSjbtiA9:APA91bF-UoDDiUK2b-vEM_GywcNGOUxhiVL22vcPtvebpMl_x2_sPj7ZIPsRffkHwBhPBiTcXF-qPi8OqQ7cg6UlFZk8akue5f23qhJIggmj5Oi9v0Yg4mWKUHSoqSKQQIJF6BqU0-fB',
                'priority': 'high',
                'notification': {
                  'title': 'Shivanshu',
                  'body': 'Flutter Notification',
                },
                'data': {'type': 'pal', 'id': '1234567890'}
              };
              await http.post(
                Uri.parse(url),
                body: jsonEncode(data),
                headers: {
                  'content-type': 'application/json;charset=UTF-8',
                  'Authorization':
                      'key=AAAAabwKzW4:APA91bHkm1eS7D6s9aCDnDiSeTv600b1riaCj06AhB4Y87DZlg0dOGFWFZic0--tVS4Im2SLPXsKyPIyw9oCiyu1UhxPRoTZs0xXIH1b7SdxJZ_tcC2kVyo-XDPnU4u_Cnq5JG_H5V6X'
                },
              );
            });
          },
          child: const Text('Send Notification'),
        ),
      ),
    );
  }
}
