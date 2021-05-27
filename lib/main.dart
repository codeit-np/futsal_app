import 'package:flutter/material.dart';
import 'package:futsal_app/pages/Booking.dart';
import 'package:futsal_app/pages/challange.dart';
import 'package:futsal_app/pages/dashboard.dart';
import 'package:futsal_app/pages/events.dart';
import 'package:futsal_app/pages/login.dart';
import 'package:futsal_app/pages/offer.dart';
import 'package:futsal_app/pages/profile.dart';
import 'package:futsal_app/pages/register.dart';
import 'package:futsal_app/pages/splash.dart';
import 'package:futsal_app/pages/teamdetails.dart';
import 'package:futsal_app/provider/provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (context) => PlayerProvider()),
    ],
    child: MyApp(),
  ));
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
        'profile': (context) => ProfileScreen(),
        'teamprofile': (context) => TeamProfile(),
        'booking': (context) => BookingScreen(),
      },
    );
  }
}
