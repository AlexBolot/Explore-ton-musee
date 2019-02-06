import 'package:explore_ton_musee/services/nfc_game_service.dart';
import 'package:explore_ton_musee/services/qr_game_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

Widget testableOf(
  Widget child, {
  Map<String, WidgetBuilder> otherRoutes = const {},
  List<NavigatorObserver> navigatorObservers,
}) {
  return MaterialApp(
    home: child,
    routes: otherRoutes,
    navigatorObservers: navigatorObservers ?? [],
  );
}

Image getDisplayedImage(WidgetTester tester) => tester.widget(find.byType(Image));

FloatingActionButton getFAB(WidgetTester tester, IconData icon) {
  return tester.element(find.byIcon(icon)).ancestorWidgetOfExactType(FloatingActionButton);
}

printSuccess(String testGroupName, String testName){
  print('Success : $testGroupName : $testName');
}

class NFCGameServiceMock extends Mock implements NFCGameService {}

class QRGameServiceMock extends Mock implements QRGameService {}

class MockNavigatorObserver extends Mock implements NavigatorObserver {}
