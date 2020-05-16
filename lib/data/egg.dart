class Egg {
  final String name;
  final String value;
  final int cookingTime;

  const Egg({this.name, this.value, this.cookingTime});

  @override
  String toString() {
    return "Egg [name=$name, value=$value, cookingTime=$cookingTime]";
  }
}