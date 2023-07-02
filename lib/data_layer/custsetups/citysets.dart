import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbterp/apis/api_endpoints.dart';
import 'package:sbterp/business_logic/model/citysets_m.dart';
import 'package:sbterp/business_logic/model/groubitemsetups_m.dart';
import 'dart:io';
import 'package:sbterp/business_logic/model/stortype_m.dart';

import '../../business_logic/model/account_m.dart';

class CitySetsRepository {

  Future<List<CitySetsM>?> GetAllCities() async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.citysets}/");

      var response =
      await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as List;
        var d = res.map((e)=>CitySetsM.formJson(e)).toList();
        return d;
      }
      return null;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }

}
