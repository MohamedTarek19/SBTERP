import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbterp/apis/api_endpoints.dart';
import 'dart:io';
import 'package:sbterp/business_logic/model/poreqhdr_m.dart';

class AccountReptra {
  Future<Object> CreateInvoice(PoreqhdrM poreqhdrM) async {
    try {
      var url = Uri.parse(Apis.baseUrl + Apis.poreqhdr);

      var response = await http.post(url,
          body: poreqhdrM.toJson(), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        return response.statusCode;
      }
      return 404;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }
  Future<PoreqhdrM?> findmaxinv(int code) async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.poreqhdr}/$code");

      var response =
      await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as Map<String, dynamic>;
        return PoreqhdrM.formJson(res);
      }

      return null;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }



}
