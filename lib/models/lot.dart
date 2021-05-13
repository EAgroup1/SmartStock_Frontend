import 'dart:html';

class Lot {
  String name;
  String dimensions;
  int weight;
  int qty;
  int price;
  bool isFragile;
  late String info;
  int minimumQty;

  Lot({required this.name, required this.dimensions, required this.weight,
      required this.qty, required this.price, required this.isFragile, required this.info,
      required this.minimumQty});

  static Lot fromJson(Map json) {
    return Lot(
        name: json['name'], dimensions: json['dimensions'], weight: json['weight'], 
        qty: json['qty'], price: json['price'], isFragile: json['isFragile'], 
        info: json['info'], minimumQty: json['minimumQty']);
  }

  @override
  String toString() {
      // TODO: implement toString
      return 'Instance of Lot : $name' ;
    }
}
