class NFCHint {
  String nfcCode;
  String hintText;

  NFCHint({this.nfcCode, this.hintText});

  NFCHint.fromMap(Map data) {
    this.nfcCode = data['nfcCode'];
    this.hintText = data['hintText'];
  }

  Map toMap() {
    return {
      'nfcCode': this.nfcCode,
      'hintText': this.hintText,
    };
  }

  @override
  String toString() {
    return 'NFCHint{nfcCode: $nfcCode, hintText: $hintText}';
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is NFCHint && runtimeType == other.runtimeType && nfcCode == other.nfcCode && hintText == other.hintText;

  @override
  int get hashCode => nfcCode.hashCode ^ hintText.hashCode;
}
