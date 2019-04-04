import 'package:explore_ton_musee/widgets/menu_item.dart';
import 'package:flutter/material.dart';

class PathStarter extends StatefulWidget {
  static const String routeName = "/PathStarter";

  final String title;

  const PathStarter({this.title = 'PathStarter page'});

  @override
  _PathStarterState createState() => _PathStarterState();
}

class _PathStarterState extends State<PathStarter> {
  @override
  Widget build(BuildContext context) {
    double size = 110;

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        child: MenuItem.listView([
          MenuItem.horizontal(
            height: size,
            icon: Icons.timer_off,
            title: 'Pour les pressés',
            content: 'Parcours simple et rapide pour ceux qui ont peu de temps !',
            contentAlign: TextAlign.left,
            color: MenuItem.turquoise,
            onPressed: (){},
          ),
          MenuItem.horizontal(
            height: size,
            icon: Icons.access_time,
            title: 'Pour les tranquilles',
            content: "Parcours détaillé pour ceux qui prennent le temps de tout voir !",
            contentAlign: TextAlign.left,
            color: MenuItem.blue,
          ),
          MenuItem.horizontal(
            height: size,
            icon: Icons.supervisor_account,
            title: 'Avec des enfants',
            content: "Parcours plus ludique possible",
            contentAlign: TextAlign.left,
            color: MenuItem.orange,
          ),
          MenuItem.horizontal(
            height: size,
            icon: Icons.language,
            title: 'Translated',
            content: "If you don't speak french",
            contentAlign: TextAlign.left,
            color: MenuItem.blue,
          ),
        ]),
      ),
    );
  }
}
