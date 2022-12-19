import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:up_004_shopapp/providers/provider_product.dart';
import 'package:up_004_shopapp/screens/screen_product_detail.dart';
import 'package:up_004_shopapp/screens/screen_products_overview.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (ctx) =>  Products(), // using crate cause builder error
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ENGAGE',
        theme: ThemeData(
          fontFamily: 'Lato',
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
            displaySmall: TextStyle(
              fontFamily: 'Lato',
              fontStyle: FontStyle.italic,
            ),
            displayMedium: TextStyle(
              fontFamily: 'Lato',
              fontStyle: FontStyle.italic,
            ),
            displayLarge: TextStyle(
              fontFamily: 'Lato',
              fontStyle: FontStyle.italic,
            ),
            headlineSmall: TextStyle(
              fontFamily: 'Lato',
              fontStyle: FontStyle.italic,
            ),
            headlineMedium: TextStyle(
              fontFamily: 'Lato',
              fontStyle: FontStyle.italic,
            ),
            headlineLarge: TextStyle(
              fontFamily: 'Lato',
              fontStyle: FontStyle.italic,
            ),
            titleSmall: TextStyle(
              fontFamily: 'Lato',
              fontStyle: FontStyle.italic,
            ),
            titleMedium: TextStyle(
              fontFamily: 'Lato',
              fontStyle: FontStyle.italic,
            ),
            titleLarge: TextStyle(
              fontFamily: 'Lato',
              fontStyle: FontStyle.italic,
              fontWeight: FontWeight.w900,
            ),
            bodySmall: TextStyle(
              fontFamily: 'Lato',
            ),
            bodyMedium: TextStyle(fontFamily: 'Lato'),
            bodyLarge: TextStyle(fontFamily: 'Lato'),
            labelSmall: TextStyle(fontFamily: 'Lato'),
            labelMedium: TextStyle(fontFamily: 'Lato'),
            labelLarge: TextStyle(fontFamily: 'Lato'),
          ),
          appBarTheme: const AppBarTheme(
            centerTitle: true,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.vertical(
                bottom: Radius.circular(30),
              ),
            ),
            systemOverlayStyle: SystemUiOverlayStyle.light,
          ),
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductsOverviewScreen.routeName: (ctx) => ProductsOverviewScreen(),
          ProductDetailScreen.routeName: (ctx) => ProductDetailScreen(),
        },
      ),
    );
  }
}
