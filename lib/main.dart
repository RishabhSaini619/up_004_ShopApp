import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,

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
        textTheme: const TextTheme(
          displaySmall: TextStyle(),
          displayMedium: TextStyle(),
          displayLarge: TextStyle(),
          headlineSmall: TextStyle(),
          headlineMedium: TextStyle(),
          headlineLarge: TextStyle(),
          titleSmall: TextStyle(),
          titleMedium: TextStyle(),
          titleLarge: TextStyle(),
          bodySmall: TextStyle(),
          bodyMedium: TextStyle(),
          bodyLarge: TextStyle(),
          labelSmall: TextStyle(),
          labelMedium: TextStyle(),
          labelLarge: TextStyle(),
        ),
        appBarTheme: const AppBarTheme(
          centerTitle: true,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.vertical(
              bottom: Radius.circular(30),
            ),
          ), systemOverlayStyle: SystemUiOverlayStyle.light,
        ),
      ),
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "ENGAGE",
          style: Theme.of(context).textTheme.titleLarge,
        ),
      ),
      body: Center(
        child: Text(
          'Let\'s build app',
          style: Theme.of(context).textTheme.bodyMedium,
        ),
      ),
    );
  }
}
