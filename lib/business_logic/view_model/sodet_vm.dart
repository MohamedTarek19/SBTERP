import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/sodet_m.dart';
import 'package:sbterp/data_layer/custsetups/sodet.dart';

import 'package:sbterp/data_layer/localdata/localdata.dart';
import 'package:http/http.dart' as http;
import '../../apis/api_endpoints.dart';
class SodetVM extends ChangeNotifier{
  SodetM? lsohdrM;
List<SodetM>? soDets;

  String? userDetails;
  AccountReptra accountReptra=AccountReptra();
  SavedLocalData savedLocalData=SavedLocalData();
  void removeLocalData(String key)async{
    await savedLocalData.removeKey(key);
    userDetails=null;
    notifyListeners();
  }


  Future<dynamic> CreateInvoice(SodetM sodetM)async{
    var result= await accountReptra.CreateInvoice(sodetM);
    return result;
  }
Future<void> GetSodet() async{
    var res = await accountReptra.GetSodet();
    soDets = res;
    notifyListeners();
  }



}
