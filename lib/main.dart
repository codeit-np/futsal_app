import 'package:flutter/material.dart';
import 'package:futsal_app/pages/challange.dart';
import 'package:futsal_app/pages/dashboard.dart';
import 'package:futsal_app/pages/events.dart';
import 'package:futsal_app/pages/login.dart';
import 'package:futsal_app/pages/offer.dart';
import 'package:futsal_app/pages/register.dart';
import 'package:futsal_app/pages/splash.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Big Foot',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routes: {
        '/': (context) => SplashScreen(),
        'login': (context) => LoginScreen(),
        'register': (context) => RegisterScreen(),
        'dashboard': (context) => DashboardScreen(),
        'event': (context) => EventScreen(),
        'offer': (context) => OfferScreen(),
        'teams': (context) => ChallangeScreen(),
      },
    );
  }
}
