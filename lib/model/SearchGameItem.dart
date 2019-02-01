class SearchHint {
  String imagePath;
  String imageCode;

  SearchHint({this.imagePath, this.imageCode});

  SearchHint.fromMap(Map data) {
    this.imagePath = data['imagePath'];
    this.imageCode = data['imageCode'];
  }

  Map toMap() {
    return {
      'imagePath': this.imagePath,
      'imageCode': this.imageCode,
    };
  }

  @override
  String toString() {
    return 'SearchGameItem{imagePath: ${imagePath}, imageCode: ${imageCode}}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is SearchHint &&
          runtimeType == other.runtimeType &&
          imagePath == other.imagePath &&
          imageCode == other.imageCode;

  @override
  int get hashCode => imagePath.hashCode ^ imageCode.hashCode;
}
