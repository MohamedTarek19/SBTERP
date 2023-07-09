import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sbterp/apis/api_endpoints.dart';
import 'package:sbterp/business_logic/model/porefhdrs_m.dart';
import 'package:sbterp/business_logic/model/sorefhdrs_m.dart';

class PoRefhdrsRepo {
  Future<Object> CreateInvoice(PoRefhdrsM PohdrM) async {
    try {
      var url = Uri.parse(Apis.baseUrl + Apis.porefhdrs);

      var response = await http.post(url,
          body: PohdrM.toJson(), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        return response.statusCode;
      }
      return 404;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }
  Future<PoRefhdrsM?> losttSearchBySerial() async{
    try{
      var url=Uri.parse("${Apis.baseUrl}${Apis.porefhdrs}");

      var response=await http.get(url,
          headers:{ 'Accept':'application/json'
          });
      if(response.statusCode==200)
      {
        var res=  jsonDecode(response.body) as Map<String,dynamic>;
        return PoRefhdrsM.formJson(res);
      }
      return null;
    }
    catch (err){
      print(err.toString());
      throw Exception(err);

    }}

  Future<List<PoRefhdrsM>?> GetPoRefhdrs() async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.porefhdrs}");

      var response =
      await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as List;
        var d = res.map((e)=>PoRefhdrsM.formJson(e)).toList();
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
