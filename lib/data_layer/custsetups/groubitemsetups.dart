import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbterp/apis/api_endpoints.dart';
import 'package:sbterp/business_logic/model/groubitemsetups_m.dart';
import 'dart:io';
import 'package:sbterp/business_logic/model/stortype_m.dart';

import '../../business_logic/model/account_m.dart';

class GroupItemSetupsRepository {

  Future<List<GroupItemSetupsM>?> GetAllGroups() async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.groubitemsetups}/");

      var response =
      await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as List;
        var d = res.map((e)=>GroupItemSetupsM.formJson(e)).toList();
        return d;
      }
      return null;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }
  Future<GroupItemSetupsM?> GetGroupset(String name) async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.groubitemsetups}/$name");

      var response =
      await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as Map<String,dynamic>;
        return GroupItemSetupsM.formJson(res);
      }
      return null;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }

  Future<Object> AddGroup(GroupItemSetupsM groupM) async {
    try {
      var url = Uri.parse(Apis.baseUrl + Apis.groubitemsetups);
      var response = await http.post(url,
          body: groupM.toJson(), headers: {'Accept': 'application/json'});
      if (response.statusCode == 20) {
        return response.statusCode;
      }
      return 404;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }

  Future<Object> deleteGroup(int id) async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.groubitemsetups}/$id");
      var response = await http.delete(url, headers: {'Accept': 'application/json'});
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
