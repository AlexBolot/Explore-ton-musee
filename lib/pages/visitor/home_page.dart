import 'package:explore_ton_musee/main.dart';
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
  double availableWidth;

  @override
  Widget build(BuildContext context) {
    var horizontalSeparator = Container(height: 8.0);
    availableWidth = screenWidth - (2 * 16) - 8;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        child: ListView(
          padding: EdgeInsets.all(16.0),
          children: <Widget>[
            MenuItem(
              color: Colors.green,
              ratio: 2.0,
              icon: Icons.account_balance,
              title: 'A propos de nous',
              content: 'Informations importantes sur le musée',
            ),
            horizontalSeparator,
            group([
              MenuItem(
                width: percentSize(40),
                color: Colors.lightBlue,
                icon: Icons.explore,
                title: 'Explorer',
                content: 'Visiter en autonomie',
              ),
              MenuItem(
                width: percentSize(60),
                color: Colors.orange,
                icon: Icons.group_add,
                title: 'Rejoindre un groupe',
                content: 'Participer à une visite guidée',
              ),
            ]),
            horizontalSeparator,
            MenuItem(
              ratio: 2.0,
              color: Colors.deepPurpleAccent.withOpacity(0.8),
              icon: Icons.assistant,
              title: 'Exposition Temporaire',
              content: '22 - 29 Mars : Exposition sur Dutch Van der Linde',
            ),
            horizontalSeparator,
            group([
              MenuItem(
                width: percentSize(50),
                color: Colors.teal,
                icon: Icons.help,
                title: 'Aide',
                content: "Renseignements sur l'application",
              ),
              MenuItem(
                width: percentSize(50),
                color: Colors.lightBlue,
                icon: Icons.place,
                title: 'Plan du musée',
                content: 'Pour vous y retrouver !',
              ),
            ]),
          ],
        ),
      ),
    );
  }

  double percentSize(double percent) => availableWidth * percent / 100;

  Row group(List<Widget> children) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      mainAxisSize: MainAxisSize.max,
      children: children,
    );
  }
}
