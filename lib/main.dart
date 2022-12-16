import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'ENGAGE',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.deepOrange, // as above
          primaryColorDark: Colors.deepOrangeAccent, // as above
          accentColor: Colors.black87, // as above
          cardColor: const Color(
              0xFFFF4D00), // default based on theme brightness, can be set manually
          backgroundColor: Colors.transparent, // as above
          errorColor: const Color(
              0xFFFF0000), // default (Colors.red[700]), can be set manually
          brightness: Brightness
              .dark, // default (Brightness.light), can be set manually
        ),
      ),
    );
  }
}
