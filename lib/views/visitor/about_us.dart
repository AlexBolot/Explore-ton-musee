import 'package:explore_ton_musee/widgets/menu_item.dart';
import 'package:flutter/material.dart';

class AboutUs extends StatefulWidget {
  static const String routeName = "/AboutUs";

  final String title;

  const AboutUs({this.title = 'À Propos du musée'});

  @override
  _AboutUsState createState() => _AboutUsState();
}

class _AboutUsState extends State<AboutUs> {
  @override
  Widget build(BuildContext context) {
    var horizontalSeparator = Container(height: 8.0);

    return Scaffold(
      appBar: AppBar(title: Text(widget.title)),
      body: Container(
        child: MenuItem.listView([
          MenuItem.horizontal(
            height: 200,
            color: MenuItem.blue,
            icon: Icons.book,
            contentAlign: TextAlign.left,
            title: 'Créé en 1984 par Marc Dupreu',
            content: 'Son but était de proposer rassembler des collections pour les faire partager à tous',
          ),
          horizontalSeparator,
          MenuItem.horizontal(
            height: 150,
            color: MenuItem.orange,
            icon: Icons.explore,
            title: 'Partenariats',
            content: 'Musée de Lisbonne\nMusée de Pragues\nMusée de New York',
            contentFormatted: true,
          ),
          horizontalSeparator,
        ]),
      ),
    );
  }
}
