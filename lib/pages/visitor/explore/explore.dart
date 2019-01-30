import 'package:explore_ton_musee/main.dart';
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
            ),
            MenuItem.vertical(
              height: 180,
              width: percentSize(50, availableWidth),
              icon: Icons.extension,
              color: MenuItem.turquoise,
              title: 'Jeu de Puzzle',
              content: "Retrouver un objet à partir d'un extrait",
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
          horizontalSeparator,
          MenuItem.horizontal(
            width: double.infinity,
            height: 100,
            icon: Icons.star,
            color: MenuItem.yellow,
            title: 'Donnez-nous votre avis',
          ),
        ]),
      ),
    );
  }
}
