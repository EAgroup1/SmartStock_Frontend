class DeliveryCustomizer{
  int month;
  int orders;

  DeliveryCustomizer(this.month, this.orders);

  factory DeliveryCustomizer.fromJson(dynamic json){
    return DeliveryCustomizer(json['month'] as int, json['orders'] as int);
  }

  @override
  String toString(){
    return '{ ${this.month}, ${this.orders}}';
  }
}