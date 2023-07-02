import 'dart:convert';

import 'package:sbterp/business_logic/model/empsetup_m.dart';

import '../../apis/api_endpoints.dart';
import 'package:http/http.dart' as http;


class EmpRep{

  Future<List<EmpsetupM>?> getJobTitles(String jopName) async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.empsetup}/$jopName");
      var response =
          await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as List;
        var d = res.map((e) => EmpsetupM.formJson(e)).toList();
        print(d.first.emp_name);
        return d;
      }

      return null;
    } catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }
  Future<List<EmpsetupM>?> getEmps() async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.empsetup}");
      var response =
      await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as List;
        var d = res.map((e) => EmpsetupM.formJson(e)).toList();
        print(d.first.emp_name);
        return d;
      }
      return null;
    } catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }

}


