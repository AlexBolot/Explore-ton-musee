class NFCHint {
  String code;
  String hintText;

  NFCHint({this.code, this.hintText});

  NFCHint.fromMap(Map data) {
    this.code = data['nfcCode'];
    this.hintText = data['hintText'];
  }

  Map toMap() {
    return {
      'nfcCode': this.code,
      'hintText': this.hintText,
    };
  }

  @override
  String toString() {
    return 'NFCHint{nfcCode: $code, hintText: $hintText}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NFCHint && runtimeType == other.runtimeType && code == other.code && hintText == other.hintText;

  @override
  int get hashCode => code.hashCode ^ hintText.hashCode;
}
