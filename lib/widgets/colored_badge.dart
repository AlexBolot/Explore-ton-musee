import 'package:explore_ton_musee/main.dart';
import 'package:flutter/material.dart';

class ColoredBadge extends StatefulWidget {
  final String text;
  final Color color;
  final double diameter;

  const ColoredBadge({this.text, this.color = Colors.grey, this.diameter = 30});

  @override
  _ColoredBadgeState createState() => _ColoredBadgeState();
}

class _ColoredBadgeState extends State<ColoredBadge> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.diameter,
      width: widget.diameter,
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(100), color: widget.color),
      child: Center(
        child: Text(
          widget.text,
          style: TextStyle(color: contrastOf(widget.color)),
        ),
      ),
    );
  }
}
