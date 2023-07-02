import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/custtra_m.dart';
import 'package:sbterp/data_layer/custsetups/custtra.dart';

import 'package:sbterp/data_layer/localdata/localdata.dart';
import 'package:http/http.dart' as http;
import '../../apis/api_endpoints.dart';
class CusttrarVM extends ChangeNotifier{
 CusttraM? lostsM;
 CusttraM? lctrsM;
  String? userDetails;
  AccountReptra accountReptra=AccountReptra();
  SavedLocalData savedLocalData=SavedLocalData();
  void removeLocalData(String key)async{
    await savedLocalData.removeKey(key);
    userDetails=null;
    notifyListeners();
  }
 Future <Object> lostReport(CusttraM lostsM)async{
   var res=accountReptra.lostReport(lostsM);
   return res;

 }

  Future<dynamic> CreateCustomertra(CusttraM custtraM)async{



    var result= await accountReptra.CreateCustomertra(custtraM);
    return result;
  }
 Future<void> losttSearchBySerial(int mid)async{

   var res=await accountReptra.losttSearchBySerial(mid);
   lctrsM=res;
   notifyListeners();
 }



}
