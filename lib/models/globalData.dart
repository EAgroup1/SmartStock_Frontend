import 'user.dart';

class GlobalData {
  static GlobalData? instance;

  late String id;
  late String token;
  late String userName;
  late String email;
  late String role;
  late User friend;

  static GlobalData? getInstance() {
    if (instance == null) {
      instance = GlobalData();
    }
    return instance;
  }

  String getId() => this.id;
  String getToken() => this.token;
  String getUserName() => this.userName;
  String getEMail() => this.email;
  String getRole() => this.role;
  User getFriend() => this.friend;

  setId(String id) {
    this.id = id;
  }

  setToken(String token) {
    this.token = token;
  }

  setUserName(String userName) {
    this.userName = userName;
  }

  setEMail(String email){
    this.email = email;
  }

  setRole(String role){
    this.role = role;
  }

  setFriend(User friend){
    this.friend = friend;
  }

}
