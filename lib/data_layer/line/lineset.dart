import 'dart:convert';
import 'package:sbterp/apis/api_endpoints.dart';
import 'package:sbterp/business_logic/model/line_m.dart';
import '../../apis/api_endpoints.dart';
import 'package:http/http.dart'as http;
class AccountRep {


  Future<LineM?> losttSearchBySerial(String gserial) async{
    try{
      var url=Uri.parse("${Apis.baseUrl}${Apis.linese}/$gserial");

      var response=await http.get(url,
          headers:{ 'Accept':'application/json'
          });
      if(response.statusCode==200)
      {

        var res=  jsonDecode(response.body) as Map<String,dynamic>;
        return LineM.formJson(res);
      }

      return null;


    }
    on Exception catch (err){
      print(err.toString());
      throw Exception(err);

    }}

  Future<Object> lostReport(LineM lineM) async{
    print("dsdsdsd");
    try{
      var url=Uri.parse(Apis.baseUrl+Apis.linese);

      var response=await http.post(url,body: lineM.toJson(),
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