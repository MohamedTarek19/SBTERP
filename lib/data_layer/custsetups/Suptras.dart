import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbterp/apis/api_endpoints.dart';
import 'dart:io';
import 'package:sbterp/business_logic/model/custtra_m.dart';
import 'package:sbterp/business_logic/model/suptras_m.dart';

class SuppReptra {
  Future<Object> CreateSuppliertra(SuptrasM SupptraM) async {
    try {
      var url = Uri.parse(Apis.baseUrl + Apis.suptras);

      var response = await http.post(url,
          body: SupptraM.toJson(), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        return response.statusCode;
      }
      return 404;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }

  Future<SuptrasM?> losttSearchBySerial(int code) async{
    try{
      var url=Uri.parse("https://mobapi.teletech-egypt.com/api/suptras/$code");

      var response=await http.get(url,
          headers:{ 'Accept':'application/json'
          });
      if(response.statusCode==200)
      {

        var res=  jsonDecode(response.body) as Map<String,dynamic>;
        return SuptrasM.formJson(res);
      }

      return null;


    }
    catch (err){
      print(err.toString());
      throw Exception(err);

    }}
  Future<Object> lostReport(SuptrasM supptra) async{
    print("dsdsdsd");
    try{
      var url=Uri.parse(Apis.baseUrl+Apis.suptras);

      var response=await http.post(url,body: supptra.toJson(),
          headers:{ 'Accept':'application/json'
          });
      if(response.statusCode==201) {
        print("ds");
        return response.statusCode;
      }
      print(response.body);
      return 404;

    }
    catch (err){
      print("..........");
      print(err.toString());
      throw Exception(err);

    }

  }


  Future<List<SuptrasM>?> GetAllTransactions() async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.suptras}/");

      var response =
      await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as List;
        var d = res.map((e)=>SuptrasM.formJson(e)).toList();
        return d;
      }
      return null;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }
}
