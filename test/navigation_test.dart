import 'package:explore_ton_musee/views/splash_screen.dart';
import 'package:explore_ton_musee/views/visitor/about_us.dart';
import 'package:explore_ton_musee/views/visitor/explore/explore.dart';
import 'package:explore_ton_musee/views/visitor/explore/nfc_game.dart';
import 'package:explore_ton_musee/views/visitor/explore/nfc_starter.dart';
import 'package:explore_ton_musee/views/visitor/explore/search_game.dart';
import 'package:explore_ton_musee/views/visitor/home_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'test_utils.dart';

final String testGroupName = 'Navigation';

main() {
  group(testGroupName, () {
    MockNavigatorObserver mockObserver = MockNavigatorObserver();

    setUp(() => mockObserver = MockNavigatorObserver());

    // ------------------------------ Splash -> HomePage ------------------------------- //

    testWidgets('Splash ->  HomePage', (WidgetTester tester) async {
      await tester.pumpWidget(testableOf(
        SplashScreen(),
        navigatorObservers: [mockObserver],
        otherRoutes: {
          '/HomePage': (context) => HomePage(),
        },
      ));

      // Give time for transition to pass (if delay over 3 seconds, fails as timeOut)
      await tester.pump(Duration(seconds: 3));

      // Expected : navigation from a page to another happened
      verify(mockObserver.didPush(any, any));

      // Expected : current screen contains HomePage widget
      expect(find.byType(HomePage), findsOneWidget);

      printSuccess(testGroupName, 'Splash ->  HomePage');
    });

    // ------------------------------ HomePage -> AboutUs ------------------------------- //

    testWidgets('HomePage -> AboutUs', (WidgetTester tester) async {
      await tester.pumpWidget(testableOf(
        HomePage(),
        navigatorObservers: [mockObserver],
        otherRoutes: {
          AboutUs.routeName: (context) => AboutUs(),
        },
      ));

      await tester.tap(find.descendant(
        of: find.byKey(Key(AboutUs.routeName)),
        matching: find.byType(InkWell),
      ));

      await tester.pumpAndSettle();

      // Expected : navigation from a page to another happened
      verify(mockObserver.didPush(any, any));

      // Expected : current screen contains AboutUs widget
      expect(find.byType(AboutUs), findsOneWidget);

      printSuccess(testGroupName, 'HomePage -> AboutUs');
    });

    // ------------------------------ HomePage -> Explore ------------------------------- //

    testWidgets('HomePage -> Explore', (WidgetTester tester) async {
      await tester.pumpWidget(testableOf(
        HomePage(),
        navigatorObservers: [mockObserver],
        otherRoutes: {
          Explore.routeName: (context) => Explore(),
        },
      ));

      await tester.tap(find.descendant(
        of: find.byKey(Key(Explore.routeName)),
        matching: find.byType(InkWell),
      ));

      await tester.pumpAndSettle();

      // Expected : navigation from a page to another happened
      verify(mockObserver.didPush(any, any));

      // Expected : current screen contains Explore widget
      expect(find.byType(Explore), findsOneWidget);

      printSuccess(testGroupName, 'HomePage -> Explore');
    });

    // ------------------------------ Explore -> NFC Starter ------------------------------- //

    testWidgets('Explore -> NFC Starter', (WidgetTester tester) async {
      await tester.pumpWidget(testableOf(
        Explore(),
        navigatorObservers: [mockObserver],
        otherRoutes: {
          NFCStarter.routeName: (context) => NFCStarter(),
        },
      ));

      await tester.tap(find.descendant(
        of: find.byKey(Key(NFCStarter.routeName)),
        matching: find.byType(InkWell),
      ));

      await tester.pumpAndSettle();

      // Expected : navigation from a page to another happened
      verify(mockObserver.didPush(any, any));

      // Expected : current screen contains NFCStarter widget
      expect(find.byType(NFCStarter), findsOneWidget);

      printSuccess(testGroupName, 'Explore -> NFC Starter');
    });

    // ------------------------------ Explore -> QRCode Game ------------------------------- //

    testWidgets('Explore -> QRCode Game', (WidgetTester tester) async {
      await tester.pumpWidget(testableOf(
        Explore(),
        navigatorObservers: [mockObserver],
        otherRoutes: {
          SearchGame.routeName: (context) => SearchGame(),
        },
      ));

      await tester.tap(find.descendant(
        of: find.byKey(Key(SearchGame.routeName)),
        matching: find.byType(InkWell),
      ));

      await tester.pumpAndSettle();

      // Expected : navigation from a page to another happened
      verify(mockObserver.didPush(any, any));

      // Expected : current screen contains SearchGame widget
      expect(find.byType(SearchGame), findsOneWidget);

      printSuccess(testGroupName, 'Explore -> QRCode Game');
    });

    // ------------------------------ NFC Starter -> NFC Game ------------------------------- //

    testWidgets('NFC Starter -> NFC Game', (WidgetTester tester) async {
      await tester.pumpWidget(testableOf(
        NFCStarter(),
        navigatorObservers: [mockObserver],
        otherRoutes: {
          NFCGame.routeName: (context) => NFCGame(),
        },
      ));

      await tester.tap(find.byType(RaisedButton));

      await tester.pumpAndSettle();

      // Expected : navigation from a page to another happened
      verify(mockObserver.didPush(any, any));

      // Expected : current screen contains SearchGame widget
      expect(find.byType(NFCGame), findsOneWidget);

      printSuccess(testGroupName, 'NFC Starter -> NFC Game');
    });
  });
}
