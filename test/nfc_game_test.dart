import 'package:explore_ton_musee/model/nfc_hint.dart';
import 'package:explore_ton_musee/services/service_provider.dart';
import 'package:explore_ton_musee/views/visitor/explore/nfc_finished.dart';
import 'package:explore_ton_musee/views/visitor/explore/nfc_game.dart';
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
      when(myService.hasNext).thenAnswer((_) {
        print('hasNext : ${hints.isNotEmpty}');
        return hints.isNotEmpty;
      });
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
          NFCGame(),
          otherRoutes: {NFCFinished.routeName: (context) => NFCFinished()},
          navigatorObservers: [mockObserver],
        ),
      );

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

      // Expected : current screen contains SearchGame widget
      expect(find.byType(NFCFinished), findsOneWidget);

      printSuccess(testGroupName, 'Normal behaviour');
    });
  });
}
