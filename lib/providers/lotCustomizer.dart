class LotCustomizer{
  String name;
  int money;

  LotCustomizer(this.name, this.money);

  factory LotCustomizer.fromJson(dynamic json){
    return LotCustomizer(json['name'] as String, json['money'] as int);
  }

  @override
  String toString(){
    return '{ ${this.name}, ${this.money}}';
  }
}