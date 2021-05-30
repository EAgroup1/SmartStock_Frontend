import 'dart:html';

class GlobalData {
  static GlobalData? instance;
//USUARIO
  late String id;
  late String token;
  late String userName;
  late String email;
  late String role;

//LOTE
  late String name;
  late String idlot;
  late String dimensions;
  late int weight;
  late int minimumQty;
  late int qty;
  late int price;
  late bool isFragile;

  static GlobalData? getInstance() {
    if (instance == null) {
      instance = GlobalData();
    }
    return instance;
  }

//USERS
  String getId() => this.id;
  String getToken() => this.token;
  String getUserName() => this.userName;
  String getEMail() => this.email;
  String getRole() => this.role;

//LOTS
  String getName() => this.name;
  String getIdlot() => this.idlot;
  String getDimensions() => this.dimensions;
  int getWeight() => this.weight;
  int getQuantity() => this.qty;
  int getMinQuantity() => this.minimumQty;
  int getPrice() => this.price;
  bool getisFragile() => this.isFragile;

//USER
  setId(String id) {
    this.id = id;
  }

  setToken(String token) {
    this.token = token;
  }

  setUserName(String userName) {
    this.userName = userName;
  }

  setEMail(String email) {
    this.email = email;
  }

  setRole(String role) {
    this.role = role;
  }

  //LOTS
  setName(String name) {
    this.name = name;
  }

  setIdlot(String idlot) {
    this.idlot = idlot;
  }

  setDimensions(String dimensions) {
    this.dimensions = dimensions;
  }

  setWeight(int weight) {
    this.weight = weight;
  }

 setQuantity(int qty) {
    this.qty = qty;
  } 

  setMinQuantity(int minimumQty) {
    this.minimumQty = minimumQty;
  }

  setPrice(int price) {
    this.price = price;
  }

  setisFragile(bool isFragile) {
    this.isFragile = isFragile;
  }
}
