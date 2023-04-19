import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/splash.dart';
import 'login_screen.dart';

class SplashscreenWidget extends StatelessWidget {
  const SplashscreenWidget({Key? key}) : super(key: key); // Mengganti super.key menjadi Key key

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider.value( // Menggunakan ChangeNotifierProvider.value
      value: SplashscreenModel(), // Membuat instance SplashscreenModel yang sama di seluruh aplikasi
      child: Consumer<SplashscreenModel>(
        builder: (context, model, _) {
          model.toggleShowTagline();
          return AnimatedSplashScreen(
            splash: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  model.appName,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 48.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 20,),
                Visibility(
                  visible: model.showTagline,
                  
                  child:FutureBuilder<String>(
                    future: Future.delayed(const Duration(seconds: 1 ), () {
                      return model.tagline;
                    }),
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return Container(); // Widget sementara jika masih dalam proses loading
                      } else {
                        return Text(
                          snapshot.data!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 18.0,
                          ),
                        );
                      }
                    },
                ),
                )
              ],
            ),
            splashIconSize: 3000,
            nextScreen: LoginScreen(),
            splashTransition: SplashTransition.scaleTransition,
            backgroundColor: Colors.blue,
            duration: 3000, // Durasi splash screen
          );
        },
      ),
    );
  }
}
