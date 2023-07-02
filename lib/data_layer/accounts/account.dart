import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbterp/apis/api_endpoints.dart';
import 'dart:io';
import 'package:sbterp/business_logic/model/account_m.dart';

class AccountRep {
  Future<Object> CreateAccount(UserM userM) async {
    try {
      var url = Uri.parse(Apis.baseUrl + Apis.users);

      var response = await http.post(url,
          body: userM.toJson(), headers: {'Accept': 'application/json'});
      if (response.statusCode == 20) {
        return response.statusCode;
      }
      return 404;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }

  Future<UserM?> login(String username) async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.users}/$username");

      var response =
          await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as Map<String, dynamic>;
        return UserM.formJson(res);
      }

      return null;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }
}
