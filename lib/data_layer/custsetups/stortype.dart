import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbterp/apis/api_endpoints.dart';
import 'dart:io';
import 'package:sbterp/business_logic/model/stortype_m.dart';

import '../../business_logic/model/account_m.dart';

class AccountReptra {

  Future<StortypeM?> findstorbyname(String storname) async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.stortype}/$storname");
      var response =
      await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as Map<String, dynamic>;
        return StortypeM.formJson(res);
      }

      return null;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }

  Future<List<StortypeM>?> GetAllStores() async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.stortype}/");

      var response =
      await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as List;
        var d = res.map((e)=>StortypeM.formJson(e)).toList();
        return d;
      }
      return null;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }

  Future<Object> AddStore(StortypeM storM) async {
    try {
      var url = Uri.parse(Apis.baseUrl + Apis.stortype);
      var response = await http.post(url,
          body: storM.toJson(), headers: {'Accept': 'application/json'});
      if (response.statusCode == 20) {
        return response.statusCode;
      }
      return 404;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }


}
