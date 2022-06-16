import 'package:flutter/material.dart';
import 'package:meteo/Pages/Home_page.dart';

import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:splashscreen/splashscreen.dart';

class SplashScreenPage extends StatelessWidget {
  const SplashScreenPage({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      seconds: 6,
      navigateAfterSeconds: const HomePage(),
      backgroundColor: const Color.fromARGB(255, 0, 0, 0),
      title: const Text(
        'Meteo',
        style: TextStyle(color: Colors.white),
        textScaleFactor: 2,
      ),
      image: Image.network('https://i.imgur.com/TyCSG9A.png'),
      loadingText: const Text("Loading", style: TextStyle(color: Colors.white)),
      photoSize: 110.0,
      loaderColor: Color.fromARGB(255, 17, 191, 177),
    );
  }
}
