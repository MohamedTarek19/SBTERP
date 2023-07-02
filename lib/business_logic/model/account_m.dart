import 'package:sbterp/data_layer/accounts/account.dart';

class UserM {
  String? username;
  int? id;
  String? cashbox;
  String? userpass;
  String? jop;
  String? storid;
  UserM(
      {this.username,
      this.cashbox,
      this.jop,
        this.storid,
      this.id,
      this.userpass});
  factory UserM.formJson(Map<String, dynamic> json) {
    return UserM(
        username: json["username"] as String,
        cashbox: json["cashbox"] as String,
        jop: json["jop"] as String?,
        storid: json["storid"] as String?,
        id: json["id"]  ,
        userpass: json["userpass"] as String);
  }
  Map toJson() {
    return {
      "username": username as String,
      "cashbox": cashbox as String,
      "jop": jop as String,
      "storid": storid as String,
      "id":"0",
      "userpass": userpass as String
    };
  }
}
