import 'package:explore_ton_musee/main.dart';
import 'package:explore_ton_musee/views/visitor/explore/nfc_game.dart';
import 'package:explore_ton_musee/widgets/menu_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class NFCStarter extends StatefulWidget {
  static const String routeName = "/NFCStarter";

  final String title;

  const NFCStarter({this.title = 'NFCStarter page'});

  @override
  _NFCStarterState createState() => _NFCStarterState();
}

class _NFCStarterState extends State<NFCStarter> {
  @override
  void initState() {
    super.initState();

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
  }

  @override
  Widget build(BuildContext context) {
    var horizontalSeparator = Container(height: 4.0);

    double elevation = 2;
    double height = 100;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        child: MenuItem.listView([
          MenuItem.horizontal(
            elevation: elevation,
            height: height,
            color: MenuItem.purple,
            icon: Icons.nfc,
            title: '1. Activer le NFC',
            content: 'Il doit être actif sur votre téléphone pour jouer',
            contentAlign: TextAlign.start,
          ),
          horizontalSeparator,
          MenuItem.horizontal(
            elevation: elevation,
            height: height,
            color: MenuItem.orange,
            icon: Icons.assignment,
            title: "2. Lire l'indice",
            content: 'Il vous permettra de trouver le prochain indice',
            contentAlign: TextAlign.start,
          ),
          horizontalSeparator,
          MenuItem.horizontal(
            elevation: elevation,
            height: height,
            color: MenuItem.turquoise,
            icon: Icons.tap_and_play,
            title: "3. Scanner la borne",
            content: "L'indice vous a mené à une borne, qui vous donne l'indice suivant",
            contentAlign: TextAlign.start,
          ),
          horizontalSeparator,
          MenuItem.horizontal(
            elevation: elevation,
            height: height,
            color: MenuItem.blue,
            icon: Icons.timeline,
            title: '4. Continuez',
            content: "Cherchez d'autres indices jusqu'au trésor",
            contentAlign: TextAlign.start,
          ),
          horizontalSeparator,
          Container(
            height: 50,
            margin: EdgeInsets.symmetric(vertical: 8, horizontal: 100),
            child: RaisedButton(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              color: Theme.of(context).primaryColor,
              textColor: contrastOf(Theme.of(context).primaryColor),
              child: Text(
                "C'est parti !",
                style: TextStyle(fontSize: 16),
              ),
              onPressed: () => Navigator.of(context).pushNamed(NFCGame.routeName),
            ),
          )
        ]),
      ),
    );
  }

  @override
  void dispose() {
    SystemChrome.setPreferredOrientations([]);
    super.dispose();
  }
}
