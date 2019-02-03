import 'package:explore_ton_musee/main.dart';
import 'package:explore_ton_musee/views/visitor/explore/nfc_starter.dart';
import 'package:explore_ton_musee/views/visitor/explore/search_game.dart';
import 'package:explore_ton_musee/widgets/menu_item.dart';
import 'package:flutter/material.dart';

class Explore extends StatefulWidget {
  static const String routeName = "/Explore";

  final String title;

  const Explore({this.title = 'Explore page'});

  @override
  _ExploreState createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  @override
  Widget build(BuildContext context) {
    AppBar appBar = AppBar(title: Text(widget.title));

    var horizontalSeparator = Container(height: 8.0);
    var availableWidth = MediaQuery.of(context).size.width - (2 * 16) - 8;

    return Scaffold(
      appBar: appBar,
      body: Container(
        child: MenuItem.listView([
          MenuItem.row([
            MenuItem.vertical(
              height: 180,
              width: percentSize(50, availableWidth),
              icon: Icons.nfc,
              color: MenuItem.purple,
              title: 'Chasse au Trésor',
              content: 'Parcours à indices',
              onPressed: () => Navigator.of(context).pushNamed(NFCStarter.routeName),
            ),
            MenuItem.vertical(
              height: 180,
              width: percentSize(50, availableWidth),
              icon: Icons.search,
              color: MenuItem.turquoise,
              title: 'Jeu de Recherche',
              content: "Retrouver un objet à partir d'un extrait",
              onPressed: () => Navigator.of(context).pushNamed(SearchGame.routeName),
            ),
          ]),
          horizontalSeparator,
          MenuItem.row([
            MenuItem.vertical(
              height: 180,
              width: percentSize(50, availableWidth),
              icon: Icons.timeline,
              color: MenuItem.orange,
              title: 'Parcours de visite',
              content: 'Choisir un parcours recommandé',
            ),
            horizontalSeparator,
            MenuItem.vertical(
              height: 180,
              width: percentSize(50, availableWidth),
              icon: Icons.fingerprint,
              color: MenuItem.blue,
              title: 'Enquête',
              content: 'Résoudre une énigme',
            ),
          ]),
        ]),
      ),
    );
  }
}
