import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:flutter/services.dart';

class NFCGame extends StatefulWidget {
  static const String routeName = "/NFCGame";

  final String title;

  const NFCGame({this.title = 'NFCGame page'});

  @override
  _NFCGameState createState() => _NFCGameState();
}

class _NFCGameState extends State<NFCGame> {
  String data = 'No data yet...';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        child: Column(
          children: <Widget>[
            Text(data),
            RaisedButton(
              onPressed: startNFC,
              child: Text('ON'),
            ),
            RaisedButton(
              onPressed: stopNFC,
              child: Text('OFF'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> startNFC() async {
    String response;

    try {
      response = await FlutterNfcReader.read;
    } on PlatformException {
      response = 'reading...';
    }
    setState(() {
      data = response;
    });
  }

  Future<void> stopNFC() async {
    try {
      await FlutterNfcReader.stop;
    } on PlatformException {
      print('AAAAHHHHH');
    }
    setState(() {});
  }
}
