import 'package:explore_ton_musee/main.dart';
import 'package:explore_ton_musee/model/nfc_hint.dart';
import 'package:flutter_nfc_reader/flutter_nfc_reader.dart';
import 'package:flutter/services.dart';

class NFCGameService {
  int _index = 0;

  List<NFCHint> _hints = [
    NFCHint(code: '123', hintText: "Vous devez trouver l'indice numéro 2 !"),
    NFCHint(code: '456', hintText: "Vous devez trouver l'indice numéro 3 !"),
    //NFCHint(nfcCode: '789', hintText: "Vous devez trouver l'indice numéro 4 !"),
  ];

  NFCHint get next => hasNext ? _hints[_index++] : null;

  bool get hasNext => _index < _hints.length;

  void init({List<NFCHint> hints, int startAt}) {
    if (startAt != null) _index = startAt;
    if (hints != null) _hints = hints;
  }

  Future<NfcData> startNFC() async {
    NfcData response;

    try {
      log('NFC : ready');
      response = await FlutterNfcReader.read;
      log('NFC : Tag found');
    } on PlatformException {
      log('NFC: Scan stopped exception');
    }

    return response;
  }

  Future stopNFC() async {
    try {
      await FlutterNfcReader.stop;
      log('NFC : Stopped reading');
    } on PlatformException {
      log('NFC: Stop scan exception');
    }
  }
}
