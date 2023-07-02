import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbterp/apis/api_endpoints.dart';
import 'dart:io';
import 'package:sbterp/business_logic/model/ittrans.dart';

class AccountRep {
  Future<Object> Createrec(IttransM ittransM) async {
    try {
      var url = Uri.parse(Apis.baseUrl + Apis.ittran);

      var response = await http.post(url,
          body: ittransM.toJson(), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        return response.statusCode;
      }
      return 404;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }
  Future<IttransM?> losttSearchBySerial(String barcode,int storcode) async{
    try{
      var url=Uri.parse("https://mobapi.teletech-egypt.com/api/ittrans/$barcode?storcode=$storcode");

      var response=await http.get(url,
          headers:{ 'Accept':'application/json'
          });
      if(response.statusCode==200)
      {

        var res=  jsonDecode(response.body) as Map<String,dynamic>;
        return IttransM.formJson(res);
      }

      return null;


    }
    catch (err){
      print(err.toString());
      throw Exception(err);

    }}

}
