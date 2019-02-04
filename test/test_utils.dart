import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

Widget testableOf(Widget child, {Map<String, WidgetBuilder> otherRoutes = const {}}) {
  return MaterialApp(
    home: child,
    routes: otherRoutes,
  );
}

Image getDisplayedImage(WidgetTester tester) => tester.widget(find.byType(Image));

FloatingActionButton getFAB(WidgetTester tester, IconData icon) {
  return tester.element(find.byIcon(icon)).ancestorWidgetOfExactType(FloatingActionButton);
}
