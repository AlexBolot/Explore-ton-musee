import 'package:explore_ton_musee/views/visitor/explore/nfc_game.dart';
import 'package:explore_ton_musee/widgets/menu_item.dart';
import 'package:flutter/material.dart';

class NFCStarter extends StatefulWidget {
  static const String routeName = "/NFCStarter";

  final String title;

  const NFCStarter({this.title = 'NFCStarter page'});

  @override
  _NFCStarterState createState() => _NFCStarterState();
}

class _NFCStarterState extends State<NFCStarter> {
  @override
  Widget build(BuildContext context) {
    var horizontalSeparator = Container(height: 8.0);

    double height = 110;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.check),
        tooltip: "C'est parti !",
        onPressed: () {
          Navigator.of(context).pushNamed(NFCGame.routeName);
        },
      ),
      body: Container(
        child: MenuItem.listView([
          MenuItem.horizontal(
            height: height,
            color: MenuItem.purple,
            icon: Icons.nfc,
            title: '1. Activer le NFC',
            content: 'Il doit être actif sur votre téléphone pour jouer',
            contentAlign: TextAlign.start,
          ),
          horizontalSeparator,
          MenuItem.horizontal(
            height: height,
            color: MenuItem.orange,
            icon: Icons.assignment,
            title: "2. Lire l'indice",
            content: 'Il vous permettra de trouver le prochain indice',
            contentAlign: TextAlign.start,
          ),
          horizontalSeparator,
          MenuItem.horizontal(
            height: height,
            color: MenuItem.turquoise,
            icon: Icons.tap_and_play,
            title: "3. Scanner la borne",
            content: "L'indice vous a mené à une borne, qui vous donne l'indice suivant",
            contentAlign: TextAlign.start,
          ),
          horizontalSeparator,
          MenuItem.horizontal(
            height: height,
            color: MenuItem.blue,
            icon: Icons.timeline,
            title: '4. Continuez',
            content: "Cherchez d'autres indices jusqu'au trésor",
            contentAlign: TextAlign.start,
          ),
        ]),
      ),
    );
  }
}
