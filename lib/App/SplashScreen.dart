import 'package:flutter/material.dart';
import 'package:modernlogintute/main.dart';
import 'package:modernlogintute/pages/login_page.dart';

import '../Cloud Messaging/Fcm.dart';

class LiveScreen extends StatefulWidget {
  const LiveScreen({super.key});

  @override
  State<LiveScreen> createState() => _LiveScreenState();
}

class _LiveScreenState extends State<LiveScreen> {
  NotificationServices notificationServices = NotificationServices();
  @override
  void initState() {
    super.initState();
    livescreen();

    // notificationServices.showNotification(message)
    notificationServices.firebaseInit();
    notificationServices.getRfreshToken();
    notificationServices.getDeviceToken().then((value) {
      print("Device Token");
      print(value);
    });
  }

  livescreen() async {
    await Future.delayed(Duration(seconds: 3), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => MainPage()));
    });
  }

  Widget build(BuildContext context) {
    return Container(
      child: Center(child: Image.asset("asset/image/food_logo.webp")),
    );
  }
}
