import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sbterp/apis/api_endpoints.dart';
import 'dart:io';
import 'package:sbterp/business_logic/model/cashboxset_m.dart';

class AccountRep {

  Future<CashBoxsetM?> findboxbyname(String boxname) async {
    try {
      var url = Uri.parse("http://erpapi.teletech-egypt.com/api/cashboxsets/$boxname");

      var response =
      await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as Map<String, dynamic>;
        return CashBoxsetM.formJson(res);
      }

      return null;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }

}
