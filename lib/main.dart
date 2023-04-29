import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:modernlogintute/App/home_page1.dart';

import 'package:modernlogintute/App/provider.dart/my_provider.dart';
import 'package:modernlogintute/Auth/auth.dart';
import 'package:modernlogintute/Cloud%20Messaging/Fcm.dart';

import 'package:provider/provider.dart';
import 'App/SplashScreen.dart';
import 'App/home.dart';

import 'components/search_system.dart';
import 'pages/login_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print(fcmToken);
  // intialize here
  FirebaseMessaging.onBackgroundMessage(_firebaseMessageBackgound);
  runApp(const MyApp());
}

// to get background notification for android
@pragma('vm:entry-point')
Future<void> _firebaseMessageBackgound(RemoteMessage message) async {
  Firebase.initializeApp();
  print(message.notification!.title.toString());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => MyProvider()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(brightness: Brightness.light),
          home: LiveScreen(),
        ));
  }
}

class MainPage extends StatelessWidget {
  const MainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Sliver();
          } else {
            return LoginPage();
          }
        },
      ),
    );
  }
}
