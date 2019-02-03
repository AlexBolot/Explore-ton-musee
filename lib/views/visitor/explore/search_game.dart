import 'package:barcode_scan/barcode_scan.dart';
import 'package:explore_ton_musee/main.dart';
import 'package:explore_ton_musee/model/search_hint.dart';
import 'package:explore_ton_musee/services/search_game_service.dart';
import 'package:explore_ton_musee/views/visitor/explore/search_finished.dart';
import 'package:flutter/material.dart';
import 'dart:async';

import 'package:flutter/services.dart';

class SearchGame extends StatefulWidget {
  static const String routeName = "/SearchGame";

  final String title;

  const SearchGame({this.title = 'SearchGame page'});

  @override
  _SearchGameState createState() => _SearchGameState();
}

class _SearchGameState extends State<SearchGame> {

  SearchGameService gameService = SearchGameService();
  SearchHint searchHint;

  bool success = false;
  bool canRefresh = false;

  double progress = 0;
  double maxValue = 60;

  Timer timer;

  BuildContext innerContext;

  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    
    generateNewGame();
  }

  @override
  Widget build(BuildContext context) {
    var screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Builder(
        builder: (innerContext) {
          this.innerContext = innerContext;
          return Container(
            width: double.infinity,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                        color: success ? Colors.green[800] : Colors.grey,
                        blurRadius: 10,
                        spreadRadius: 5,
                      )
                    ],
                  ),
                  child: Image.asset(
                    searchHint?.imagePath ?? '',
                    width: percentSize(80, screenWidth),
                    fit: BoxFit.contain,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 64),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      Stack(
                        alignment: Alignment(0, 0),
                        children: <Widget>[
                          FloatingActionButton(
                            mini: true,
                            backgroundColor: canRefresh ? Colors.amber[900] : Colors.grey,
                            heroTag: null,
                            onPressed: () {},
                            child: Icon(Icons.autorenew),
                          ),
                          Container(
                            height: 36,
                            child: CircularProgressIndicator(
                              valueColor: AlwaysStoppedAnimation<Color>(Colors.amber[900]),
                              strokeWidth: 4,
                              value: progress,
                            ),
                          ),
                        ],
                      ),
                      FloatingActionButton(
                        heroTag: null,
                        onPressed: scanCode,
                        child: Icon(Icons.photo_camera, size: 32),
                      ),
                      FloatingActionButton(
                        mini: true,
                        backgroundColor: success ? Colors.green[700] : Colors.grey,
                        heroTag: null,
                        child: Icon(Icons.arrow_forward),
                        onPressed: generateNewGame,
                      ),
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  scanCode() async {
    String result = await BarcodeScanner.scan() ?? '';

    bool isValid = result == searchHint.imageCode;

    if (!isValid) {
      showSnackBar(
        scaffoldState: Scaffold.of(innerContext),
        message: 'Mauvaise image... réessaie !',
      );
    }

    setState(() => success = isValid);
  }

  generateNewGame() {
    timer?.cancel();
    timer = Timer.periodic(Duration(milliseconds: 10), (timer) {
      setState(() {
        if (progress < 1)
          progress += 1 / (maxValue * 100);
        else {
          timer.cancel();
          canRefresh = true;
          showSnackBar(
            scaffoldState: Scaffold.of(innerContext),
            message: 'Vous pouvez changer de photo',
          );
        }
      });
    });
    
    if (gameService.hasNext) {
      setState(() {
        searchHint = gameService.next;
        success = false;
        canRefresh = false;
        progress = 0;
      });
    } else {
      Navigator.of(context).pushReplacementNamed(SearchFinished.routeName);
    }
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([]);
    timer?.cancel();
    super.dispose();
  }
}
