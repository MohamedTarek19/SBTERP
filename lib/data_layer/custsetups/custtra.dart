import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbterp/apis/api_endpoints.dart';
import 'dart:io';
import 'package:sbterp/business_logic/model/custtra_m.dart';

class AccountReptra {
  Future<Object> CreateCustomertra(CusttraM custtraM) async {
    try {
      var url = Uri.parse(Apis.baseUrl + Apis.custtra);

      var response = await http.post(url,
          body: custtraM.toJson(), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        return response.statusCode;
      }
      return 404;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }

  Future<CusttraM?> losttSearchBySerial(int code) async{
    try{
      var url=Uri.parse("https://mobapi.teletech-egypt.com/api/custtras/$code");

      var response=await http.get(url,
          headers:{ 'Accept':'application/json'
          });
      if(response.statusCode==200)
      {

        var res=  jsonDecode(response.body) as Map<String,dynamic>;
        return CusttraM.formJson(res);
      }

      return null;


    }
    catch (err){
      print(err.toString());
      throw Exception(err);

    }}
  Future<Object> lostReport(CusttraM custtel) async{
    print("dsdsdsd");
    try{
      var url=Uri.parse(Apis.baseUrl+Apis.custtra);

      var response=await http.post(url,body: custtel.toJson(),
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
}
