import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbterp/apis/api_endpoints.dart';
import 'dart:io';
import 'package:sbterp/business_logic/model/sodet_m.dart';
import 'package:sbterp/business_logic/model/sorefdets_m.dart';

class SoRefdetsRepo {
  Future<Object> CreateInvoice(SoRefdetsM sodetM) async {
    try {
      var url = Uri.parse(Apis.baseUrl + Apis.sorefdets);

      var response = await http.post(url,
          body: sodetM.toJson(), headers: {'Accept': 'application/json'});
      print("adding items:  ${response.statusCode}");
      if (response.statusCode == 200) {
        return response.statusCode;
      }
      return 404;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }
  Future<List<SoRefdetsM>?> GetSodet() async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.sorefdets}");
      var response =
      await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as List;
        var d = res.map((e)=>SoRefdetsM.formJson(e)).toList();
        //print(d.length);
        return d;
      }
      return null;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }


}
