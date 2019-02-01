import 'package:flutter/material.dart';

class SearchFinished extends StatefulWidget {
  static const String routeName = "/SearchFinished";

  final String title;

  const SearchFinished({this.title = 'SearchFinished page'});

  @override
  _SearchFinishedState createState() => _SearchFinishedState();
}

class _SearchFinishedState extends State<SearchFinished> {
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
