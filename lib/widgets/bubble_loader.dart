import 'dart:math';

import 'package:flutter/material.dart';

class BubbleLoader extends StatefulWidget {
  AnimationController controller;

  void dispose() {
    if (controller?.isAnimating ?? false) {
      controller?.dispose();
    }
  }

  @override
  _BubbleLoaderState createState() => _BubbleLoaderState();
}

class _BubbleLoaderState extends State<BubbleLoader> with SingleTickerProviderStateMixin {
  Animation<double> rotation;
  double radius = 30;

  @override
  void initState() {
    super.initState();

    widget.controller = AnimationController(
      lowerBound: 0.0,
      upperBound: 1.0,
      duration: const Duration(seconds: 2),
      vsync: this,
    );

    rotation = Tween(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: widget.controller,
        curve: Interval(0.0, 1.0, curve: Curves.linear),
      ),
    );

    widget.controller.addListener(() => setState(() {}));

    widget.controller.repeat();
  }

  @override
  Widget build(BuildContext context) {
    return RotationTransition(
      turns: rotation,
      child: Stack(
        children: buildList(radius, Theme.of(context).primaryColor),
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    widget.dispose();
  }
}

class Dot extends StatelessWidget {
  final double radius;
  final Color color;

  const Dot({this.radius, this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: this.radius,
      height: this.radius,
      decoration: BoxDecoration(
        color: this.color,
        shape: BoxShape.circle,
      ),
    );
  }
}

List<Widget> buildList(double radius, Color color) {
  List<Widget> widgets = [];

  double amount = 12;

  for (double i = 0; i < amount - 1; i++) {
    widgets.add(Transform.translate(
      offset: Offset(
        radius * cos(2 * i * pi / amount),
        radius * sin(2 * i * pi / amount),
      ),
      child: Dot(
        radius: log((10 * i) + 10) * 1.5,
        color: color,
      ),
    ));
  }

  return widgets;
}
