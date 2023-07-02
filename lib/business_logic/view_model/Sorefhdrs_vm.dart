import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/sohdr_m.dart';
import 'package:sbterp/business_logic/model/sorefhdrs_m.dart';
import 'package:sbterp/data_layer/custsetups/SoRefhdrs.dart';
import 'package:sbterp/data_layer/custsetups/sohdrs.dart';

import 'package:sbterp/data_layer/localdata/localdata.dart';
import 'package:http/http.dart' as http;
import '../../apis/api_endpoints.dart';
class SoRefhdrVM extends ChangeNotifier{
  SoRefhdrsM? lsohdrM;
  List<SoRefhdrsM>? Invoises = [];

  String? userDetails;
  SoRefhdrsRepo accountReptra=SoRefhdrsRepo();
  SavedLocalData savedLocalData=SavedLocalData();
  void removeLocalData(String key)async{
    await savedLocalData.removeKey(key);
    userDetails=null;
    notifyListeners();
  }


  Future<dynamic> CreateInvoice(SoRefhdrsM sohdrM)async{
    var result= await accountReptra.CreateInvoice(sohdrM);

    return result;
  }

  Future<void> losttSearchBySerial()async{

    var res=await accountReptra.losttSearchBySerial();
    lsohdrM=res;
    notifyListeners();

  }
  Future<void> GetSohdrs() async{
    var res = await accountReptra.GetSohdrs();
    Invoises = res;
    notifyListeners();
  }

}
