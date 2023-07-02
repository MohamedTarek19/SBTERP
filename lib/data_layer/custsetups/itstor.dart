import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:sbterp/apis/api_endpoints.dart';
import 'dart:io';
import 'package:sbterp/business_logic/model/itstor_m.dart';
import 'package:sbterp/view/stock/store_type_helper.dart';

import '../../business_logic/model/account_m.dart';

class ItemStoreRepository {
/*
      "sitemid":((StorTypeHelper.StoreItems!.last.sitemid??0)+1).toString(),
      "sitemdisc": storIt.sitemdisc,
      "sitbarcode": storIt.sitbarcode,
      "itso": storIt.itso.toString(),
      "storid": storIt.storid.toString(),
      "bal": storIt.bal.toString(),
      "disc": storIt.disc.toString(),
      "discprec": storIt.discprec.toString(),
      "gitemsubid": storIt.gitemsubid,
      "gitemid": storIt.gitemid,
      "imgpat": '',
      "itservice": storIt.itservice.toString(),
      "itpo": storIt.itpo.toString(),
      "itsop": storIt.itsop.toString(),
      "itsos": storIt.itsos.toString(),
      "sitemqty": storIt.sitemqty.toString(),
      "sitemunit": storIt.sitemunit,
      "sitemreq": storIt.sitemreq.toString(),
      'compid': '0',
      'branid': '0',
      'accno': '0',
      'netsho': '0',
      * */
  Future<ItstorM?> losttSearchBySerial(String barcode) async{
    try{
      var url=Uri.parse("https://mobapi.teletech-egypt.com/api/itstors/$barcode");

      var response=await http.get(url,
          headers:{ 'Accept':'application/json'
          });
      if(response.statusCode==200)
      {

        var res=  jsonDecode(response.body) as Map<String,dynamic>;
        return ItstorM.formJson(res);
      }

      return null;


    }
    catch (err){
      print(err.toString());
      throw Exception(err);

    }}
  Future<Object> CreateItem(ItstorM storIt) async {
    var mmap ={
      "sitemid":'0',
      "sitemdisc": storIt.sitemdisc,
      "sitbarcode": storIt.sitbarcode,
      "itso": storIt.itso.toString(),
      "storid": storIt.storid.toString(),
      "bal": storIt.bal.toString(),
      "disc": storIt.disc.toString(),
      "discprec": storIt.discprec.toString(),
      "gitemsubid": storIt.gitemsubid,
      "gitemid": storIt.gitemid,
      "imgpat": '0',
      "itservice": storIt.itservice.toString(),
      "itpo": storIt.itpo.toString(),
      "itsop": storIt.itsop.toString(),
      "itsos": storIt.itsos.toString(),
      "sitemqty": storIt.sitemqty.toString(),
      "sitemunit": storIt.sitemunit,
      "sitemreq": '0',
      'compid': '0',
      'branid': '0',
      'accno': '0',
      'netsho': '0',
    };
    try {
      var url = Uri.parse(Apis.baseUrl + Apis.itstor);
      var response = await http.post(url,
          body:mmap, headers: {'Accept': 'application/json'});
      print('${response.contentLength} and response code is : ${response.statusCode}');
      if (response.statusCode == 20) {
        return response.statusCode;
      }
      return 404;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }

  Future<List<ItstorM>?> GetAllItems() async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.itstor}/");
      var response =
      await http.get(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 200) {
        var res = jsonDecode(response.body) as List;
        var d = res.map((e)=>ItstorM.formJson(e)).toList();
        return d;
      }
      return null;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }
  Future<Object> deleteItem(int id) async {
    try {
      var url = Uri.parse("${Apis.baseUrl}${Apis.itstor}/$id");
      var response = await http.delete(url, headers: {'Accept': 'application/json'});
      if (response.statusCode == 20) {
        return response.statusCode;
      }
      return 404;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }
  Future<Object> EditGroup(int id,ItstorM storIt) async {
    var mmap ={
      "sitemid": storIt.sitemid.toString(),
      "sitemdisc": storIt.sitemdisc,
      "sitbarcode": storIt.sitbarcode,
      "itso": storIt.itso.toString(),
      "storid": storIt.storid.toString(),
      "bal": storIt.bal.toString(),
      "disc": storIt.disc.toString(),
      "discprec": storIt.discprec.toString(),
      "gitemsubid": storIt.gitemsubid,
      "gitemid": storIt.gitemid,
      "imgpat": '0',
      "itservice": storIt.itservice.toString(),
      "itpo": storIt.itpo.toString(),
      "itsop": storIt.itsop.toString(),
      "itsos": storIt.itsos.toString(),
      "sitemqty": (storIt.sitemqty??0).toString(),
      "sitemunit": storIt.sitemunit,
      "sitemreq": '0',
      'compid': '0',
      'branid': '0',
      'accno': '0',
      'netsho': '0',
    };
    try {
      var url = Uri.parse("http://erpapi.teletech-egypt.com/api/itstors/$id");
      //print("${url.toString().compareTo("http://erpapi.teletech-egypt.com/api/itstors")}");
      var response = await http.put(url,body: jsonEncode(mmap), headers: {'Content-Type': 'application/json'});
      print(response.statusCode);
      return response.statusCode;
    } on Exception catch (err) {
      print(err.toString());
      throw Exception(err);
    }
  }


}
