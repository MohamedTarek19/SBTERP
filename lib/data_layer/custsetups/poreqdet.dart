import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbterp/apis/api_endpoints.dart';
import 'dart:io';
import 'package:sbterp/business_logic/model/poreqdet_m.dart';

class AccountReptra {
  Future<Object> CreateInvoice(PoreqdetM poreqdetM) async {
    try {
      var url = Uri.parse(Apis.baseUrl + Apis.poreqdet);

      var response = await http.post(url,
          body: poreqdetM.toJson(), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        return response.statusCode;
      }
      return 404;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }


}
