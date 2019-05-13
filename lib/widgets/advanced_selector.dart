import 'dart:math';

import 'package:flutter/material.dart';
import 'package:vector_math/vector_math_64.dart' as tr;

class AdvancedSelector extends StatefulWidget {
  final List<Widget> options;

  AdvancedSelector({this.options});

  @override
  _AdvancedSelectorState createState() => _AdvancedSelectorState();
}

class _AdvancedSelectorState extends State<AdvancedSelector> with SingleTickerProviderStateMixin {
  bool open = false;

  AnimationController _animationController;
  Animation<Color> _animateColor;
  Animation<double> _animateIcon;
  Animation<double> _translateButton;
  double _fabHeight = 56;
  double _fabHeightMini = 48;

  List<Widget> rawItems = [];

  @override
  initState() {
    _animationController = AnimationController(vsync: this, duration: Duration(milliseconds: 500));
    _animationController.addListener(() => setState(() {}));

    _animateIcon = Tween<double>(begin: 0, end: 1).animate(_animationController);

    _animateColor = ColorTween(
      begin: Colors.blue,
      end: Colors.grey,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0, 1, curve: Curves.linear),
    ));

    super.initState();
  }

  @override
  dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    rawItems = [
      Icon(Icons.add),
      Icon(Icons.add),
      Icon(Icons.add),
      Icon(Icons.add),
      Icon(Icons.add),
    ]..addAll([
        Icon(Icons.add),
        Icon(Icons.add),
        Icon(Icons.add),
        Icon(Icons.add),
        Icon(Icons.add),
      ]);

    _translateButton = Tween<double>(
      begin: 0,
      end: 50,
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Interval(0, 1, curve: Curves.easeInOut),
    ));

    return Scaffold(
      appBar: AppBar(),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        child: Center(
          child: Stack(
            children: blob()..add(toggle()),
          ),
        ),
      ),
    );
  }

  Widget toggle() {
    return FloatingActionButton(
      backgroundColor: Colors.transparent,
      onPressed: animate,
      child: AnimatedIcon(icon: AnimatedIcons.menu_close, progress: _animateIcon),
    );
  }

  animate() {
    if (!open)
      _animationController.forward();
    else
      _animationController.reverse();

    open = !open;
  }

  List<Widget> blob() {
    return rawItems.length < 9 ? buildFewItems() : buildManyItems();
  }

  List<Widget> buildManyItems() {
    List<Widget> res = [];

    int amount = rawItems.length;
    double angle = max(32, 360 / amount);

    print(angle);

    for (int i = 0; i < amount; i++) {
      double localAngle = angle * i;

      var onPressed;
      if (_translateButton.status == AnimationStatus.forward || _translateButton.status == AnimationStatus.completed)
        onPressed = () {};

      double bonus = i.toDouble() % 8;

      double xOffset = cos(tr.radians(localAngle)) * _translateButton.value * bonus;
      double yOffset = sin(tr.radians(localAngle)) * _translateButton.value * bonus;

      Offset offset = Offset(xOffset, yOffset);

      res.add(
        Transform.translate(
          offset: offset,
          child: Container(
            child: FloatingActionButton(
              elevation: 4.0,
              mini: true,
              backgroundColor: Colors.grey,
              onPressed: onPressed,
              child: rawItems[i],
            ),
          ),
        ),
      );
    }

    return res;
  }

  List<Widget> buildFewItems() {
    List<Widget> res = [];

    int amount = rawItems.length;
    double angle = 360 / amount;

    for (int i = 0; i < amount; i++) {
      double localAngle = angle * i;

      var onPressed;
      if (_translateButton.status == AnimationStatus.forward || _translateButton.status == AnimationStatus.completed)
        onPressed = () {};

      double xOffset = cos(tr.radians(localAngle)) * _translateButton.value;
      double yOffset = sin(tr.radians(localAngle)) * _translateButton.value;

      res.add(
        Transform.translate(
          offset: Offset(xOffset, yOffset),
          child: Container(
            child: FloatingActionButton(
              mini: true,
              backgroundColor: Colors.grey,
              onPressed: onPressed,
              child: rawItems[i],
            ),
          ),
        ),
      );
    }

    return res;
  }
}
