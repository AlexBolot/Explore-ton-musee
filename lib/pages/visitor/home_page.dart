import 'package:explore_ton_musee/main.dart';
import 'package:explore_ton_musee/pages/visitor/about_us.dart';
import 'package:explore_ton_musee/pages/visitor/explore/explore.dart';
import 'package:explore_ton_musee/widgets/menu_item.dart';
import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  static const String routeName = '/HomePage';

  final String title;

  const HomePage({this.title = 'Accueil du Musée'});

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    var horizontalSeparator = Container(height: 8.0);
    var availableWidth = MediaQuery.of(context).size.width - (2 * 16) - 8;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        child: MenuItem.listView([
          //----------------//
          MenuItem(
            color: MenuItem.green,
            ratio: 2.0,
            icon: Icons.account_balance,
            title: 'À propos de nous',
            content: 'Informations importantes sur le musée',
            onPressed: () => Navigator.of(context).pushNamed(AboutUs.routeName),
          ),
          horizontalSeparator,
          //----------------//
          MenuItem.row([
            MenuItem(
              width: percentSize(40, availableWidth),
              color: MenuItem.blue,
              icon: Icons.explore,
              title: 'Explorer',
              content: 'Visiter en autonomie',
              onPressed: () => Navigator.of(context).pushNamed(Explore.routeName),
            ),
            MenuItem(
              width: percentSize(60, availableWidth),
              color: MenuItem.orange,
              icon: Icons.group_add,
              title: 'Rejoindre un groupe',
              content: 'Participer à une visite guidée',
            ),
          ]),
          horizontalSeparator,
          //----------------//
          MenuItem(
            ratio: 2.0,
            color: MenuItem.purple,
            icon: Icons.assistant,
            title: 'Exposition Temporaire',
            content: '22 - 29 Mars : Exposition sur Dutch Van der Linde',
          ),
          horizontalSeparator,
          //----------------//
          MenuItem.row([
            MenuItem(
              width: percentSize(50, availableWidth),
              color: MenuItem.turquoise,
              icon: Icons.help,
              title: 'Aide',
              content: "Renseignements sur l'application",
            ),
            MenuItem(
              width: percentSize(50, availableWidth),
              color: MenuItem.blue,
              icon: Icons.place,
              title: 'Plan du musée',
              content: 'Pour vous y retrouver !',
            ),
          ]),
          horizontalSeparator,
          //----------------//
        ]),
      ),
    );
  }
}
