class DataItem {
  DataItem(this.value) {
    typeString = value.runtimeType.toString().toLowerCase();
  }

  final dynamic value;
  String typeString;

  @override
  String toString() => value.toString();
}
