import 'dart:html';

class Lot {
  String name;
  late String dimensions;
  late String weight;
  String quantity;
  String price;
  late String isFragile;

  Lot({required this.name, required this.quantity, required this.price});

  static Lot fromJson(Map json) {
    return Lot(
        name: json['name'], quantity: json['quantity'], price: json['price']);
  }

  @override
  String toString() {
      // TODO: implement toString
      return 'Instance of Lot : $name' ;
    }
}
