import 'package:explore_ton_musee/model/search_hint.dart';
import 'package:explore_ton_musee/services/service_provider.dart';
import 'package:explore_ton_musee/views/visitor/explore/search/search_game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';

import 'test_utils.dart';

final String testGroupName = 'QR Game';

main() {
  group(testGroupName, () {
    QRGameServiceMock myService;
    int index = 0;
    List<SearchHint> hints = [
      SearchHint(imagePath: 'path/to/asset1', code: '123'),
      SearchHint(imagePath: 'path/to/asset2', code: '456'),
    ];

    setUpAll(() {
      myService = QRGameServiceMock();

      when(myService.scanCode()).thenAnswer((_) => Future.value(hints[index - 1].code));
      when(myService.hasNext).thenReturn(index < hints.length);
      when(myService.next).thenAnswer((_) => hints[index++]);

      ServiceProvider.init(qrService: myService);
    });

    setUp(() => index = 0);

    // ----------------------------------------------------------------------------------------- //
    // ------------------------------ QR Game : Normal behaviour ------------------------------- //
    // ----------------------------------------------------------------------------------------- //

    testWidgets('Normal behaviour', (WidgetTester tester) async {
      await tester.pumpWidget(testableOf(SearchGame()));

      // 1. Expected : There is a displayed image
      // 2. Expected : It's the first of the hints list
      // 3. Expected : The 'forward' button is grey
      expect(find.byType(Image), findsOneWidget);
      expect(getDisplayedImage(tester).image, equals(Image.asset(hints[0].imagePath).image));
      expect(getFAB(tester, Icons.arrow_forward).backgroundColor, equals(Colors.grey));

      // Trigger 'scan'
      await tester.tap(find.byIcon(Icons.photo_camera));
      await tester.pump();

      // Expected : 'forward' button is green
      expect(getFAB(tester, Icons.arrow_forward).backgroundColor, equals(Colors.green[700]));

      // Trigger 'forward'
      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pump();

      // Expected : the displayed image changed, and is the second of the hints list
      expect(getDisplayedImage(tester).image, equals(Image.asset(hints[1].imagePath).image));

      printSuccess(testGroupName, 'Normal behaviour');
    });

    // ----------------------------------------------------------------------------------------- //
    // ----------------------------------- QR Game : No scan ----------------------------------- //
    // ----------------------------------------------------------------------------------------- //

    testWidgets('No scan', (WidgetTester tester) async {
      await tester.pumpWidget(testableOf(SearchGame()));

      // 1. Expected : There is a displayed image
      // 2. Expected : It's the first of the hints list
      // 3. Expected : The 'forward' button is grey
      expect(find.byType(Image), findsOneWidget);
      expect(getDisplayedImage(tester).image, equals(Image.asset(hints[0].imagePath).image));
      expect(getFAB(tester, Icons.arrow_forward).backgroundColor, equals(Colors.grey));

      // !! We don't trigger 'scan' !!

      // Expected : 'forward' button is still grey
      expect(getFAB(tester, Icons.arrow_forward).backgroundColor, equals(Colors.grey));

      // Trigger 'forward'
      await tester.tap(find.byIcon(Icons.arrow_forward));
      await tester.pump();

      // Expected : the displayed image changed, and is still the first of the hints list
      expect(getDisplayedImage(tester).image, equals(Image.asset(hints[0].imagePath).image));

      printSuccess(testGroupName, 'No scan');
    });

    // ----------------------------------------------------------------------------------------- //
    // --------------------------------- QR Game : Renew timer --------------------------------- //
    // ----------------------------------------------------------------------------------------- //

    testWidgets('Renew timer', (WidgetTester tester) async {
      await tester.pumpWidget(testableOf(SearchGame()));

      // 1. Expected : There is a displayed image
      // 2. Expected : It's the first of the hints list
      // 3. Expected : The 'renew' button is grey
      expect(find.byType(Image), findsOneWidget);
      expect(getDisplayedImage(tester).image, equals(Image.asset(hints[0].imagePath).image));
      expect(getFAB(tester, Icons.autorenew).backgroundColor, equals(Colors.grey));

      // We wait until the button becomes available
      await tester.pump(Duration(seconds: 60 + 1));

      // Expected : 'renew' button is still grey
      expect(getFAB(tester, Icons.autorenew).backgroundColor, equals(Colors.amber[900]));

      // Trigger 'forward'
      await tester.tap(find.byIcon(Icons.autorenew));
      await tester.pump();

      // Expected : the displayed image changed, and is still the first of the hints list
      expect(getDisplayedImage(tester).image, equals(Image.asset(hints[1].imagePath).image));

      // The 'renew' button is back to grey
      expect(getFAB(tester, Icons.autorenew).backgroundColor, equals(Colors.grey));

      printSuccess(testGroupName, 'Renew timer');
    });
  });
}
