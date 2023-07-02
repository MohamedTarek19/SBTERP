import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/sodet_m.dart';
import 'package:sbterp/business_logic/model/sorefdets_m.dart';
import 'package:sbterp/data_layer/custsetups/sodet.dart';
import 'package:sbterp/data_layer/custsetups/sorefdets.dart';

import 'package:sbterp/data_layer/localdata/localdata.dart';
import 'package:http/http.dart' as http;
import '../../apis/api_endpoints.dart';
class SoRefdetsVM extends ChangeNotifier{
  SoRefdetsM? lsohdrM;
  List<SoRefdetsM>? soDets;

  String? userDetails;
  SoRefdetsRepo accountReptra=SoRefdetsRepo();
  SavedLocalData savedLocalData=SavedLocalData();
  void removeLocalData(String key)async{
    await savedLocalData.removeKey(key);
    userDetails=null;
    notifyListeners();
  }


  Future<dynamic> CreateInvoice(SoRefdetsM soRdetM)async{
    var result= await accountReptra.CreateInvoice(soRdetM);
    return result;
  }
  Future<void> GetSoRefdets() async{
    var res = await accountReptra.GetSodet();
    soDets = res;
    notifyListeners();
  }



}
