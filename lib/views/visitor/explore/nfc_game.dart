import 'package:explore_ton_musee/main.dart';
import 'package:explore_ton_musee/model/nfc_hint.dart';
import 'package:explore_ton_musee/services/nfc_game_service.dart';
import 'package:explore_ton_musee/views/visitor/explore/explore.dart';
import 'package:explore_ton_musee/views/visitor/explore/nfc_finished.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';

class NFCGame extends StatefulWidget {
  static const String routeName = "/NFCGame";

  final String title;

  const NFCGame({this.title = 'NFCGame page'});

  @override
  _NFCGameState createState() => _NFCGameState();
}

class _NFCGameState extends State<NFCGame> {
  NFCGameService gameService = NFCGameService();
  NFCHint nfcHint;
  List<Widget> hintItems = [];

  @override
  void initState() {
    super.initState();

    gameService.init();

    //Called twice
    renewHint();

    addHintItem(nfcHint.hintText);

    renewHint();

    startNFC(callback: tagFound);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        width: double.infinity,
        child: ListView(
          children: [
            Container(
              height: 90,
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Image.asset('assets/blob.gif'),
              ),
            ),
          ]..addAll(hintItems),
        ),
      ),
    );
  }

  @override
  void dispose() {
    stopNFC();
    super.dispose();
  }

  void renewHint() {
    if (gameService.hasNext) {
      nfcHint = gameService.next;
    } else{
      print('NFC Game is finished !');
      Navigator.of(context).pushNamedAndRemoveUntil(NFCFinished.routeName, ModalRoute.withName(Explore.routeName));
    }
  }

  void tagFound(NfcData data) async {
    print('-tag found-');

    if (data?.content == null) return;

    if (data.content.contains("##")) {
      String foundCode = data.content.split("##")[1];

      if (foundCode == nfcHint.nfcCode) {
        print('-code matches-');
        setState(() {
          addHintItem(nfcHint.hintText);
          renewHint();
        });
      } else {
        print('expected : ${nfcHint.nfcCode}');
        print('found : $foundCode');
      }

      await stopNFC();
      await startNFC(callback: tagFound);

      print('-ready to read-');
    }
  }

  void addHintItem(String content) {
    int hintsAmount = hintItems.length;

    hintItems.add(
      Card(
        elevation: 4.0,
        margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: EdgeInsets.symmetric(horizontal: 16),
                child: Text('${hintsAmount + 1}', style: TextStyle(fontSize: 20), textAlign: TextAlign.center),
              ),
              Expanded(
                child: Container(
                  padding: EdgeInsets.only(right: 16),
                  child: Text(
                    '${nfcHint.hintText}',
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    textAlign: TextAlign.left,
                    style: TextStyle(height: 1.2),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
