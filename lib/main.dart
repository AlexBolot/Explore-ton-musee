import 'package:explore_ton_musee/views/visitor/about_us.dart';
import 'package:explore_ton_musee/views/visitor/explore/explore.dart';
import 'package:explore_ton_musee/views/visitor/explore/nfc_finished.dart';
import 'package:explore_ton_musee/views/visitor/explore/nfc_game.dart';
import 'package:explore_ton_musee/views/visitor/explore/nfc_starter.dart';
import 'package:explore_ton_musee/views/visitor/explore/search_finished.dart';
import 'package:explore_ton_musee/views/visitor/explore/search_game.dart';
import 'package:explore_ton_musee/views/visitor/home_page.dart';
import 'package:explore_ton_musee/views/splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/': (context) => SplashScreen(),
        SplashScreen.routeName: (context) => SplashScreen(),
        HomePage.routeName: (context) => HomePage(),
        AboutUs.routeName: (context) => AboutUs(),
        Explore.routeName: (context) => Explore(),
        NFCStarter.routeName:(context)=> NFCStarter(),
        NFCGame.routeName: (context) => NFCGame(),
        NFCFinished.routeName : (context) => NFCFinished(),
        SearchGame.routeName: (context) => SearchGame(),
        SearchFinished.routeName: (context) => SearchFinished(),
      },
    );
  }
}

Color contrastOf(Color background) {
  var brightness = ThemeData.estimateBrightnessForColor(background);
  return brightness == Brightness.light ? Colors.black : Colors.white;
}

double percentSize(double percent, double of) => percent * of / 100;

void showSnackBar({@required ScaffoldState scaffoldState, String message, Duration duration}) {
  message ??= 'Snackbar message';
  duration ??= Duration(days: 999);

  scaffoldState.showSnackBar(
    SnackBar(
      duration: duration,
      action: SnackBarAction(
        label: 'OK',
        onPressed: () => scaffoldState.removeCurrentSnackBar(reason: SnackBarClosedReason.remove),
      ),
      content: Text(message),
    ),
  );
}

Future<void> startNFC({void callback(NfcData data)}) async {
  NfcData response;

  try {
    print('NFC : ready');
    response = await FlutterNfcReader.read;
    print('NFC : Tag found');
  } on PlatformException {
    print('NFC: Scan stopped exception');
  }

  if (callback != null) callback(response);
}

Future<void> stopNFC({bool restart = false, void callback(NfcData data)}) async {
  NfcData response;

  try {
    response = await FlutterNfcReader.stop;
    print('NFC : Stopped reading');
  } on PlatformException {
    print('NFC: Stop scan exception');
    response = NfcData(
      id: '',
      content: '',
      error: 'NFC scan stop exception',
      statusMapper: '',
    );
    response.status = NFCStatus.error;
  }

  if (callback != null) callback(response);
}