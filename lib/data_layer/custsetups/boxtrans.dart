import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbterp/apis/api_endpoints.dart';
import 'dart:io';
import 'package:sbterp/business_logic/model/boxtrans_m.dart';

class AccountRep {
  Future<Object> Createrec(BoxtransM boxtransM) async {
    try {
      var url = Uri.parse(Apis.baseUrl + Apis.boxtrans);

      var response = await http.post(url,
          body: boxtransM.toJson(), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        return response.statusCode;
      }
      return 404;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }
  Future<BoxtransM?> losttSearchBySerial(int code) async{
    try{
      var url=Uri.parse("${Apis.baseUrl}${Apis.boxtrans}/$code");

      var response=await http.get(url,
          headers:{ 'Accept':'application/json'
          });
      if(response.statusCode==200)
      {

        var res=  jsonDecode(response.body) as Map<String,dynamic>;
        return BoxtransM.formJson(res);
      }

      return null;


    }
    catch (err){
      print(err.toString());
      throw Exception(err);

    }}

}
