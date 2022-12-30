// ignore_for_file: depend_on_referenced_packages

import 'package:flutter/material.dart';
import 'package:animated_text_kit/animated_text_kit.dart';

class WelcomeSplashScreen extends StatelessWidget {
  const WelcomeSplashScreen({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            radius: 3,
            colors: [
              Theme.of(context).colorScheme.primary,
              Theme.of(context).colorScheme.secondary,
              Theme.of(context).colorScheme.primary,
            ],
          ),
        ),
        child: Center(
          child: DefaultTextStyle(
            style: Theme.of(context).textTheme.displayLarge.copyWith(
                  fontSize: 50,
                ),
            child: AnimatedTextKit(
              animatedTexts: [
                TyperAnimatedText(
                  'ENGAGE',
                  speed: const Duration(milliseconds: 20),
                ),
              ],
            ),
          ),
        ),

      ),
    );
  }
}
