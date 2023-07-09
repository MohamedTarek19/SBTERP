import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbterp/apis/api_endpoints.dart';
import 'package:sbterp/business_logic/model/podets_m.dart';
import 'package:sbterp/business_logic/model/porefdets_m.dart';
import 'dart:io';
import 'package:sbterp/business_logic/model/sodet_m.dart';
import 'package:sbterp/business_logic/model/sorefdets_m.dart';

class PodetsRepo {
  Future<Object> CreateInvoice(PodetsM podetM) async {

    try {
      var url = Uri.parse(Apis.baseUrl + Apis.podets);

      var response = await http.post(url,
          body: podetM.toJson(), headers: {'Accept': 'application/json'});
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
  Future<List<PodetsM>?> GetPodet() async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.podets}");
      var response =
      await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as List;
        var d = res.map((e)=>PodetsM.formJson(e)).toList();
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
