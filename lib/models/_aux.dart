class Aux {
  String _id;
  String token;
  Aux.fromJson(jsonMap)
      : this._id = jsonMap['_id'],
        this.token = jsonMap['token'];
}
