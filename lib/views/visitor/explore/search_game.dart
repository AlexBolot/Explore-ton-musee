import 'package:explore_ton_musee/main.dart';
import 'package:explore_ton_musee/model/search_hint.dart';
import 'package:explore_ton_musee/services/qr_game_service.dart';
import 'package:explore_ton_musee/services/service_provider.dart';
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
  QRGameService gameService = ServiceProvider.qrGameService;
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

    renewHint();
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
                      GestureDetector(
                        onTap: canRefresh ? renewHint : () {},
                        child: Stack(
                          alignment: Alignment(0, 0),
                          children: <Widget>[
                            FloatingActionButton(
                              elevation: canRefresh ? 6 : 0,
                              mini: true,
                              backgroundColor: canRefresh ? Colors.amber[900] : Colors.grey,
                              heroTag: 'renew',
                              tooltip: 'renew',
                              onPressed: canRefresh ? renewHint : () {},
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
                      ),
                      FloatingActionButton(
                        heroTag: 'scan',
                        tooltip: 'scan',
                        onPressed: scanCode,
                        child: Icon(Icons.photo_camera, size: 32),
                      ),
                      FloatingActionButton(
                        elevation: success ? 6 : 0,
                        mini: true,
                        backgroundColor: success ? Colors.green[700] : Colors.grey,
                        heroTag: 'forward',
                        tooltip: 'forward',
                        child: Icon(Icons.arrow_forward),
                        onPressed: success ? renewHint : () {},
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
    String result = await ServiceProvider.qrGameService.scanCode();

    bool isValid = result == searchHint.code;

    if (!isValid) {
      showSnackBar(
        scaffoldState: Scaffold.of(innerContext),
        message: 'Mauvaise image... réessaie !',
      );
    }

    setState(() => success = isValid);
  }

  renewHint() {
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
    gameService.init(startAt: 0);
    SystemChrome.setPreferredOrientations([]);
    timer?.cancel();
    super.dispose();
  }
}
