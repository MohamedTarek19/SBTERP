import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbterp/apis/api_endpoints.dart';
import 'dart:io';
import 'package:sbterp/business_logic/model/custtram_m.dart';

import '../../business_logic/model/account_m.dart';

class AccountReptra {

  Future<CusttraMM?> losttSearchBySerial(int code) async{
    try{
      var url=Uri.parse("${Apis.baseUrl}${Apis.custtra}/$code");

      var response=await http.get(url,
          headers:{ 'Accept':'application/json'
          });
      if(response.statusCode==200)
      {

        var res=  jsonDecode(response.body) as Map<String,dynamic>;
        return CusttraMM.formJson(res);
      }

      return null;


    }
    catch (err){
      print(err.toString());
      throw Exception(err);

    }}

  Future<UserM?> login(String username) async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.users}/$username");

      var response =
      await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as Map<String, dynamic>;
        return UserM.formJson(res);
      }

      return null;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }

}
