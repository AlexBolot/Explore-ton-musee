import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  static const String routeName = "/AboutUs";

  final String title;

  const AboutUs({this.title = 'AboutUs page'});

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        child: Center(
          child: Text(widget.title),
        ),
      ),
    );
  }
}
