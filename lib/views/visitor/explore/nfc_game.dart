import 'package:explore_ton_musee/main.dart';
import 'package:explore_ton_musee/model/nfc_hint.dart';
import 'package:explore_ton_musee/services/nfc_game_service.dart';
import 'package:explore_ton_musee/services/service_provider.dart';
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
  NFCGameService gameService = ServiceProvider.nfcGameService;
  NFCHint nfcHint;
  List<Widget> displayedHints = [];

  @override
  void initState() {
    super.initState();

    renewHint();

    gameService.startNFC().then(tagFound);
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
          ]..addAll(displayedHints),
        ),
      ),
    );
  }

  @override
  void dispose() {
    gameService.stopNFC();
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

      if (foundCode == nfcHint.code) {
        print('-code matches-');
        setState(() {
          addHintItem(nfcHint.hintText);
          renewHint();
        });
      } else {
        print('expected : ${nfcHint.code}');
        print('found : $foundCode');
      }

      await gameService.stopNFC();
      await gameService.startNFC().then(tagFound);

      print('-ready to read-');
    }
  }

  void addHintItem(String content) {
    int hintsAmount = displayedHints.length;

    displayedHints.add(
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
