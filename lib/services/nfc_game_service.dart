import 'package:explore_ton_musee/model/nfc_hint.dart';

class NFCGameService {
  static int _index = 0;

  static List<NFCHint> _items = [
    NFCHint(nfcCode: '123', hintText: "Vous devez trouver l'indice numéro 2 !"),
    NFCHint(nfcCode: '456', hintText: "Vous devez trouver l'indice numéro 3 !"),
    //NFCHint(nfcCode: '789', hintText: "Vous devez trouver l'indice numéro 4 !"),
  ];

  NFCHint get next => hasNext ? _items[_index++] : null;

  bool get hasNext => _index < _items.length;

  void init() => _index = 0;
}
