import 'package:explore_ton_musee/main.dart';
import 'package:explore_ton_musee/pages/visitor/home_page.dart';
import 'package:explore_ton_musee/widgets/bubble_loader.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  static const String routeName = "/SplashScreen";

  final String title;

  const SplashScreen({this.title = ''});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin {
  BubbleLoader loader = BubbleLoader();

  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(milliseconds: 0)).then((value) {
      loader.dispose();
      Navigator.of(context).pushReplacementNamed(HomePage.routeName);
    });
  }

  @override
  Widget build(BuildContext context) {
    screenHeight = MediaQuery.of(context).size.height;
    screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      body: SafeArea(
        child: Container(
          width: double.infinity,
          child: Stack(
            alignment: Alignment(0, -1),
            children: <Widget>[
              Container(
                width: screenWidth,
                height: screenHeight / 3,
                child: Card(
                  elevation: 4.0,
                  color: Theme.of(context).primaryColor,
                  child: Center(
                    child: Text(
                      'Explore ton musée !',
                      style: TextStyle(
                        fontSize: 30,
                        color: textColorMatching(Theme.of(context).primaryColor),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: screenHeight / 3),
                width: screenWidth,
                height: 2 * screenHeight / 3,
                child: Center(child: Container(child: loader)),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
