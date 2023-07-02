import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sbterp/apis/api_endpoints.dart';
import 'dart:io';
import 'package:sbterp/business_logic/model/customer_m.dart';
import 'package:sbterp/business_logic/model/supsetups_m.dart';

class SupSetupsRepository {
  Future<Object> CreateSupplier(SubSetupsM supplierM) async {
    try {
      var url = Uri.parse(Apis.baseUrl + Apis.supsetups);

      var response = await http.post(url,
          body: supplierM.toJson(), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
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
      var url = Uri.parse("${Apis.baseUrl}${Apis.supsetups}/$id");
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
  Future<Object> EditGroup(int id,SubSetupsM supplierM) async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.supsetups}/$id");
      var response = await http.put(url,body: supplierM.toJson(), headers: {'Accept': 'application/json'});
      if (response.statusCode == 20) {
        return response.statusCode;
      }
      return 404;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }

  Future<List<SubSetupsM>?> GetSuppliers() async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.supsetups}/");

      var response = await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as List;
        var d = res.map((e)=>SubSetupsM.formJson(e)).toList();
        return d;
      }
      return null;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }
}
