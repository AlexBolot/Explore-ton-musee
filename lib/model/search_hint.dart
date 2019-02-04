class SearchHint {
  String imagePath;
  String code;

  SearchHint({this.imagePath, this.code});

  SearchHint.fromMap(Map data) {
    this.imagePath = data['imagePath'];
    this.code = data['imageCode'];
  }

  Map toMap() {
    return {
      'imagePath': this.imagePath,
      'imageCode': this.code,
    };
  }

  @override
  String toString() {
    return 'SearchGameItem{imagePath: $imagePath, imageCode: $code}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchHint &&
          runtimeType == other.runtimeType &&
          imagePath == other.imagePath &&
          code == other.code;

  @override
  int get hashCode => imagePath.hashCode ^ code.hashCode;
}
