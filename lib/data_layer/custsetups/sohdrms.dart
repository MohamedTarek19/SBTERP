import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbterp/apis/api_endpoints.dart';
import 'dart:io';
import 'package:sbterp/business_logic/model/sohdrm_m.dart';

class AccountReptra {

  Future<SohdrmM?> findmaxinv(int code) async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.sohdr}/$code");

      var response =
      await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as Map<String, dynamic>;
        return SohdrmM.formJson(res);
      }

      return null;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }



}
