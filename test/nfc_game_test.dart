import 'package:explore_ton_musee/model/nfc_hint.dart';
import 'package:explore_ton_musee/services/nfc_game_service.dart';
import 'package:explore_ton_musee/services/service_provider.dart';
import 'package:explore_ton_musee/views/visitor/explore/nfc_finished.dart';
import 'package:explore_ton_musee/views/visitor/explore/nfc_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'test_utils.dart';

class NFCGameServiceMock extends Mock implements NFCGameService {}

NFCGameServiceMock myService;
int index = 0;

List<NFCHint> hints = [
  NFCHint(hintText: 'hint text 1', code: '123'),
  NFCHint(hintText: 'hint text 2', code: '456'),
  NFCHint(hintText: 'hint text 3', code: '678'),
];

List<String> beacons = ['##123', '##456'];

List<bool> aa = [true];

main() {
  setUpAll(() {
    myService = NFCGameServiceMock();

    when(myService.startNFC()).thenAnswer((_) {
      return myService.hasNext
          ? Future.delayed(Duration(seconds: 10), () => NfcData(content: beacons[index - 1]))
          : Future.value();
    });
    when(myService.stopNFC()).thenAnswer((_) => Future.value());
    when(myService.hasNext).thenAnswer((_) => index < hints.length);
    when(myService.next).thenAnswer((_) {
      return hints[index++];
    });

    ServiceProvider.init(nfcService: myService);
  });

  setUp(() => index = 0);

  // ----------------------------------------------------------------------------------------- //
  // ------------------------------ QR Game : Normal behaviour ------------------------------- //
  // ----------------------------------------------------------------------------------------- //

  testWidgets('NFC Game : Normal behaviour', (WidgetTester tester) async {
    await tester.pumpWidget(testableOf(NFCGame(), otherRoutes: {'/NFCFinished': (context) => NFCFinished()}));

    // Waiting for the 'beacon' to be detected
    await tester.pump(Duration(seconds: 10));

    // Only first hint showed up
    expect(find.text('1'), findsOneWidget);
    expect(find.text('2'), findsNothing);

    // Waiting for the 'beacon' to be detected
    await tester.pump(Duration(seconds: 10));

    // The second hint showed up
    expect(find.text('2'), findsOneWidget);
  });
}
