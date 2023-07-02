import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:sbterp/apis/api_endpoints.dart';
import 'dart:io';
import 'package:sbterp/business_logic/model/customer_m.dart';

class AccountRep {
  Future<Object> CreateCustomer(CustomerM customerM) async {
    try {
      var url = Uri.parse(Apis.baseUrl + Apis.customer);

      var response = await http.post(url,
          body: customerM.toJson(), headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        return response.statusCode;
      }
      return 404;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }
  Future<CustomerM?> findcustbyname(String custname) async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.customer}/$custname");

      var response =
      await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as Map<String, dynamic>;
        return CustomerM.formJson(res);
      }

      return null;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }
  Future<CustomerM?> losttSearchBySerial(String gserial) async{
    try{
      var url=Uri.parse("${Apis.baseUrl}${Apis.customer}/$gserial");

      var response=await http.get(url,
          headers:{ 'Accept':'application/json'
          });
      if(response.statusCode==200)
      {
        var res=  jsonDecode(response.body) as Map<String,dynamic>;
        return CustomerM.formJson(res);
      }
      return null;
    }
    on Exception catch (err){
      print(err.toString());
      throw Exception(err);

    }}

  Future<Object> lostReport(CustomerM custtel) async{
    print("dsdsdsd");
    try{
      var url=Uri.parse(Apis.baseUrl+Apis.customer);

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
  Future<Object> deleteGroup(int id) async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.customer}/$id");
      var response = await http.delete(url, headers: {'Accept': 'application/json'});
        return response.statusCode;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }

  Future<Object> EditGroup(int id,CustomerM custM) async {
    var mmap = {
      "custAname": custM.custAname as String?,
      "custaddres1": custM.custaddres1 as String?,
      "custaddres2": custM.custaddres2 as String?,
      "custmobile": custM.custmobile as String?,
      "mandob": custM.mandob as String?,
      "city": custM.city as String?,
      "code": id.toString(),
      "CustPrice": custM.CustPrice as String?,
      "custbal": custM.custbal.toString(),
      "CreditLimit": custM.CreditLimit.toString(),
      "custfbal": custM.custfbal.toString(),
      "caccahly": custM.caccahly as String?,
      "caccaman": custM.caccaman as String?,
      "caccmasary": custM.caccmasary as String?,
      "caccorang": custM.caccorang as String?,
      "cserahly": custM.cserahly as String?,
      "cseraman": custM.cseraman as String?,
      "csermasary": custM.csermasary as String?,
      "cserorang": custM.cserorang as String?,
      "custemail": custM.custemail as String?,
      "manage": custM.manage as String?,
      "MaxDayAllwo": custM.MaxDayAllwo.toString(),
    };
    try {
      var url = Uri.parse("http://erpapi.teletech-egypt.com/api/custsetups/$id");
      print("${url.toString().compareTo("http://erpapi.teletech-egypt.com/api/custsetups/1124")}");
      var response = await http.put(url,body: jsonEncode(mmap), headers: {'Content-Type': 'application/json'});
        return response.statusCode;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }

  Future<List<CustomerM>?> GetCustomers() async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.customer}/");

      var response = await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as List;
        var d = res.map((e)=>CustomerM.formJson(e)).toList();
        return d;
      }
      return null;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }
}
