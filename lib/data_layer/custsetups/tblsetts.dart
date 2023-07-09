import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbterp/apis/api_endpoints.dart';
import 'dart:io';
import 'package:sbterp/business_logic/model/stortype_m.dart';
import 'package:sbterp/business_logic/model/tblsetts_m.dart';

import '../../business_logic/model/account_m.dart';

class TblSetTsRepo {
  Future<List<TblSetTsM>?> GetAllTbls() async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.tblsetts}/");
      var response =
      await http.get(url, headers: {'Accept': 'application/json'});
      print("tbls response = ${response.statusCode}");
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as List;
        var d = res.map((e)=>TblSetTsM.formJson(e)).toList();
        d.forEach((element) {
          print(element.stock);
        });
        return d;
      }
      return null;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }

  Future<Object> AddTBL(TblSetTsM tbl) async {
    try {
      var url = Uri.parse(Apis.baseUrl + Apis.tblsetts);
      var response = await http.post(url,
          body: tbl.toJson(), headers: {'Accept': 'application/json'});
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
