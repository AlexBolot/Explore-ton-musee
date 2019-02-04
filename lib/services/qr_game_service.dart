import 'package:barcode_scan/barcode_scan.dart';
import 'package:explore_ton_musee/model/search_hint.dart';

class QRGameService {
  int _index = 0;
  List<SearchHint> _hints = [
    SearchHint(code: '123', imagePath: 'assets/hint1.jpg'),
    SearchHint(code: '456', imagePath: 'assets/hint2.jpg'),
    SearchHint(code: '789', imagePath: 'assets/hint3.jpg'),
  ];

  SearchHint get next => hasNext ? _hints[_index++] : null;

  bool get hasNext => _index < _hints.length;

  Future<String> scanCode() async {
    return await BarcodeScanner.scan() ?? '';
  }

  void init({List<SearchHint> hints, int startAt}) {
    if (startAt != null) _index = startAt;
    if (hints != null) _hints = hints;
  }
}
