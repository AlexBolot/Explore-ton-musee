import 'package:flutter/material.dart';

class CarouselItem extends StatefulWidget {
  final Widget prefix;
  final String label;

  const CarouselItem({this.label, this.prefix});

  @override
  _CarouselItemState createState() => _CarouselItemState();
}

class _CarouselItemState extends State<CarouselItem> {
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        mainAxisSize: MainAxisSize.max,
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          Padding(padding: const EdgeInsets.all(16.0), child: widget.prefix),
          Text(widget.label, style: TextStyle(fontSize: 20)),
        ],
      ),
    );
  }
}
