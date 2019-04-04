import 'package:flutter/material.dart';

class NFCFinished extends StatefulWidget {
  static const String routeName = "/NFCFinished";

  final String title;

  const NFCFinished({this.title = 'NFCFinished page'});

  @override
  _NFCFinishedState createState() => _NFCFinishedState();
}

class _NFCFinishedState extends State<NFCFinished> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        leading: IconButton(
          tooltip: 'Back', // Used for testing purpose
          icon: Icon(Icons.arrow_back),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Container(
        child: Center(
          child: Card(
            margin: EdgeInsets.all(16),
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: <Widget>[
                  Text('Bravo vous avez gagné !', style: TextStyle(fontSize: 25), textAlign: TextAlign.center),
                  Container(margin: EdgeInsets.symmetric(vertical: 8), height: 1, color: Colors.black),
                  Text(
                    "Vous avez réussi à compléter le jeu de piste à travers le musée !\n\n"
                        "Nous vous laissons choisir l'une de ces récompenses :\n\n"
                        "- 10% de réduction sur notre boutique\n"
                        "- Entrée gratuite lors de votre prochaine visite",
                    textAlign: TextAlign.justify,
                    style: TextStyle(fontSize: 16, height: 1.2),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
