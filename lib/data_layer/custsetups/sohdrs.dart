import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbterp/apis/api_endpoints.dart';
import 'dart:io';
import 'package:sbterp/business_logic/model/sohdr_m.dart';

class AccountReptra {
  Future<Object> CreateInvoice(SohdrM sohdrM) async {
    try {
      var url = Uri.parse(Apis.baseUrl + Apis.sohdr);

      var response = await http.post(url,
          body: sohdrM.toJson(), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        return response.statusCode;
      }
      return 404;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }
  Future<SohdrM?> losttSearchBySerial() async{
    try{
      var url=Uri.parse("${Apis.baseUrl}${Apis.sohdr}");

      var response=await http.get(url,
          headers:{ 'Accept':'application/json'
          });
      if(response.statusCode==200)
      {
        var res=  jsonDecode(response.body) as Map<String,dynamic>;
        return SohdrM.formJson(res);

      }

      return null;


    }
    catch (err){
      print(err.toString());
      throw Exception(err);

    }}

  Future<List<SohdrM>?> GetSohdrs() async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.sohdr}");

      var response =
      await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as List;
        var d = res.map((e)=>SohdrM.formJson(e)).toList();
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
