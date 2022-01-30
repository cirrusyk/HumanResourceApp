extension ListHelper on List {
  int count(Object object) => where((item) => object == item).toList().length;
}
