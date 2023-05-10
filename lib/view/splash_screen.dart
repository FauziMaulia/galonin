import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/splash.dart';
import 'login_screen.dart';

class SplashscreenWidget extends StatefulWidget {
  const SplashscreenWidget({Key? key}) : super(key: key);

  @override
  // ignore: library_private_types_in_public_api
  _SplashscreenWidgetState createState() => _SplashscreenWidgetState();
}

class _SplashscreenWidgetState extends State<SplashscreenWidget> {
  late final SplashscreenModel model;
  

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value(
      value: SplashscreenModel(),
      child: Consumer<SplashscreenModel>(
        builder: (context, model, _) {
          return AnimatedSplashScreen(
            splash: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 40,),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      model.appName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 48.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20,),
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      model.tagline,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 24.0,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            splashIconSize: 300,
            nextScreen: LoginScreen(),
            splashTransition: SplashTransition.scaleTransition,
            backgroundColor: Colors.blue,
            duration: 3000,
          );
        },
      ),
    );
  }
}