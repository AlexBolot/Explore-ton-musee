import 'package:explore_ton_musee/services/path_service.dart';
import 'package:explore_ton_musee/views/visitor/explore/path_activity.dart';
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

    Widget fast = PathActivity(title: 'Visite Rapide', pathName: PathName.Fast);
    Widget slow = PathActivity(title: 'Visite Tranquille', pathName: PathName.Slow);
    Widget children = PathActivity(title: 'Visite Ludique', pathName: PathName.Children);
    Widget english = PathActivity(title: 'English Tour', pathName: PathName.English);

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
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => fast)),
          ),
          MenuItem.horizontal(
            height: size,
            icon: Icons.access_time,
            title: 'Pour les tranquilles',
            content: "Parcours détaillé pour ceux qui prennent le temps de tout voir !",
            contentAlign: TextAlign.left,
            color: MenuItem.blue,
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => slow)),
          ),
          MenuItem.horizontal(
            height: size,
            icon: Icons.supervisor_account,
            title: 'Avec des enfants',
            content: "Parcours plus ludique possible",
            contentAlign: TextAlign.left,
            color: MenuItem.orange,
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => children)),
          ),
          MenuItem.horizontal(
            height: size,
            icon: Icons.language,
            title: 'Translated',
            content: "If you speak english",
            contentAlign: TextAlign.left,
            color: MenuItem.blue,
            onPressed: () => Navigator.of(context).push(MaterialPageRoute(builder: (context) => english)),
          ),
        ]),
      ),
    );
  }
}
