import 'package:explore_ton_musee/model/nfc_hint.dart';
import 'package:explore_ton_musee/services/service_provider.dart';
import 'package:explore_ton_musee/views/visitor/explore/explore.dart';
import 'package:explore_ton_musee/views/visitor/explore/nfc_finished.dart';
import 'package:explore_ton_musee/views/visitor/explore/nfc_game.dart';
import 'package:explore_ton_musee/views/visitor/explore/nfc_starter.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'test_utils.dart';

final String testGroupName = 'NFC';

main() {
  group(testGroupName, () {
    NFCGameServiceMock myService;

    List<NFCHint> hints = [
      NFCHint(hintText: 'hint text 1', code: '123'),
      NFCHint(hintText: 'hint text 2', code: '456'),
      NFCHint(hintText: 'hint text 3', code: '678'),
    ];

    List<String> beacons = ['##123', '##456', '##678'];

    setUpAll(() {
      myService = NFCGameServiceMock();

      when(myService.startNFC()).thenAnswer((_) {
        return Future.delayed(Duration(seconds: 10), () {
          return NfcData(content: beacons.isNotEmpty ? beacons.removeAt(0) : '');
        });
      });
      when(myService.stopNFC()).thenAnswer((_) => Future.value());
      when(myService.hasNext).thenAnswer((_) => hints.isNotEmpty);
      when(myService.next).thenAnswer((_) => hints.removeAt(0));

      ServiceProvider.init(nfcService: myService);
    });

    setUp(() {
      beacons = ['##123', '##456', '##678'];
      hints = [
        NFCHint(hintText: 'hint text 1', code: '123'),
        NFCHint(hintText: 'hint text 2', code: '456'),
        NFCHint(hintText: 'hint text 3', code: '678'),
      ];
    });

    // ----------------------------------------------------------------------------------------- //
    // ------------------------------ NFC Game : Normal behaviour ------------------------------ //
    // ----------------------------------------------------------------------------------------- //

    testWidgets('NFC Game : Normal behaviour', (WidgetTester tester) async {
      MockNavigatorObserver mockObserver = MockNavigatorObserver();

      await tester.pumpWidget(
        testableOf(
          Explore(),
          otherRoutes: {
            // We need all those routes during the NFC Game process
            NFCStarter.routeName: (context) => NFCStarter(),
            NFCGame.routeName: (context) => NFCGame(),
            NFCFinished.routeName: (context) => NFCFinished(),
          },
          navigatorObservers: [mockObserver],
        ),
      );

      // Navigate to NFC Starter
      await tester.tap(find.descendant(
        of: find.byKey(Key(NFCStarter.routeName)),
        matching: find.byType(InkWell),
      ));

      await tester.pumpAndSettle();

      // Navigate to NFC Game
      await tester.tap(find.byType(RaisedButton));

      await tester.pumpAndSettle();

      // Waiting for the 'beacon' to be detected
      await tester.pump(Duration(seconds: 15));

      // Only first hint showed up
      expect(find.text('1'), findsOneWidget);
      expect(find.text('2'), findsNothing);

      // Waiting for the 'beacon' to be detected
      await tester.pump(Duration(seconds: 15));

      // The second hint showed up
      expect(find.text('2'), findsOneWidget);

      // Waiting for the 'beacon' to be detected
      await tester.pump(Duration(seconds: 15));

      await tester.pumpAndSettle();

      // Expected : navigation from a page to another happened
      verify(mockObserver.didPush(any, any));

      // Expected : current screen contains NFCFinished widget
      expect(find.byType(NFCFinished), findsOneWidget);

      //await tester.tap(find.byType(IconButton));

      //await tester.pumpAndSettle(Duration(seconds: 5));

      //verify(mockObserver.didPop(any, any));

      // Expected : current screen contains Explore widget
      //expect(find.byType(NFCFinished), findsOneWidget);

      printSuccess(testGroupName, 'Normal behaviour');
    });
  });
}
