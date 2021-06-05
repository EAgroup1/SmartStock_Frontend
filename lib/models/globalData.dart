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
  late String weight;
  late String minimumQty;
  late String qty;
  late String price;
  late bool isFragile;
  late String info;
  late bool stored;

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
  String getWeight() => this.weight;
  String getQuantity() => this.qty;
  String getMinQuantity() => this.minimumQty;
  String getPrice() => this.price;
  bool getisFragile() => this.isFragile;
  String getInfo() => this.info;
  bool getStored() => this.stored;

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

  setWeight(String weight) {
    this.weight = weight;
  }

  setQuantity(String qty) {
    this.qty = qty;
  }

  setMinQuantity(String minimumQty) {
    this.minimumQty = minimumQty;
  }

  setPrice(String price) {
    this.price = price;
  }

  setisFragile(bool isFragile) {
    this.isFragile = isFragile;
  }

  setInfo(String info) {
    this.info = info;
  }

  setStored(bool stored) {
    this.stored = stored;
  }
}
