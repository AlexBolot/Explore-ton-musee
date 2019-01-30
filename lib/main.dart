import 'package:explore_ton_musee/pages/visitor/about_us.dart';
import 'package:explore_ton_musee/pages/visitor/home_page.dart';
import 'package:explore_ton_musee/pages/splash_screen.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashScreen(),
        HomePage.routeName: (context) => HomePage(),
        AboutUs.routeName: (context) => AboutUs(title: 'Home Page of the App'),
        SplashScreen.routeName: (context) => SplashScreen(),
      },
    );
  }
}

double screenWidth;
double screenHeight;

Color textColorMatching(Color background) {
  var brightness = ThemeData.estimateBrightnessForColor(background);
  return brightness == Brightness.light ? Colors.black : Colors.white;
}
