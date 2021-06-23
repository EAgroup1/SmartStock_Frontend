import 'package:rlbasic/models/chatmodel.dart';
import 'package:rlbasic/models/userChat.dart';

import 'user.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class GlobalData {
  static GlobalData? instance;
//USUARIO
  late String id;
  late String token;
  late String userName;
  late String email;
  late String role;
  late UserChat friend;
//CHAT
  late ChatModel model;
  late String resetLink;
  late String location;
  late String businessLocation;

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

//DELIVERY
  late String iddelivery;
  late String originLocation;
  late String destinationLocation;
  late String deliveryDate;
  late bool isPicked;
  late bool isDelivered;
  late bool isReady;
  late bool isAssigned;
  late String description;
  late LatLng coordenadas;



  static GlobalData? getInstance() {
    if (instance == null) {
      instance = GlobalData();
    }
    return instance;
  }

  GlobalData? setInstance() {
    instance = null;
  }

//USERS
  String getId() => this.id;
  String getToken() => this.token;
  String getUserName() => this.userName;
  String getEMail() => this.email;
  String getRole() => this.role;
  UserChat getFriend() => this.friend;
//CHAT
  ChatModel getChatModel() => this.model;
  String getResetLink() => this.resetLink;

  String getLocation() => this.location;
  String getBusinessLocation() => this.businessLocation;
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

  //DELIVERY
  String getIdDelivery() => this.iddelivery;
  String getOriginLocation() => this.originLocation;
  String getDestinationLocation() => this.destinationLocation;
  String getDeliveryDate() => this.deliveryDate;
  bool getIsPicked() => this.isPicked;
  bool getIsDelivered() => this.isDelivered;
  bool getIsReady() => this.isReady;
  bool getIsAssigned() => this.isAssigned;
  String getDescription() => this.description;

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

  setLocation(String location) {
    this.location = location;
  }

  setFriend(UserChat friend){
    this.friend = friend;
  }

//CHAT
  setChatModel(ChatModel model){
    this.model = model;
  }

//LOTS
  setResetLink(String resetLink) {
    this.resetLink = resetLink;
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
