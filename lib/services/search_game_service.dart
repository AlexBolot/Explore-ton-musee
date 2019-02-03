import 'package:explore_ton_musee/model/search_hint.dart';

class SearchGameService {
  static int _index = 0;

  static List<SearchHint> _items = [
    SearchHint(imageCode: '123', imagePath: 'assets/hint1.jpg'),
    SearchHint(imageCode: '456', imagePath: 'assets/hint2.jpg'),
    SearchHint(imageCode: '789', imagePath: 'assets/hint3.jpg'),
  ];

  SearchHint get next => hasNext ? _items[_index++] : null;

  bool get hasNext => _index < _items.length;
}
