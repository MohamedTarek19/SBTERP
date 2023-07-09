import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/porefdets_m.dart';
import 'package:sbterp/business_logic/model/sodet_m.dart';
import 'package:sbterp/business_logic/model/sorefdets_m.dart';
import 'package:sbterp/data_layer/custsetups/porefdet.dart';
import 'package:sbterp/data_layer/custsetups/sodet.dart';
import 'package:sbterp/data_layer/custsetups/sorefdets.dart';

import 'package:sbterp/data_layer/localdata/localdata.dart';
import 'package:http/http.dart' as http;
import '../../apis/api_endpoints.dart';
class PoRefdetsVM extends ChangeNotifier{
  PoRefdetsM? lsohdrM;
  List<PoRefdetsM>? poDets;

  String? userDetails;
  PoRefdetsRepo accountReptra=PoRefdetsRepo();
  SavedLocalData savedLocalData=SavedLocalData();
  void removeLocalData(String key)async{
    await savedLocalData.removeKey(key);
    userDetails=null;
    notifyListeners();
  }


  Future<dynamic> CreateInvoice(PoRefdetsM PorefdetM)async{
    var result= await accountReptra.CreateInvoice(PorefdetM);
    return result;
  }
  Future<void> GetPoRefdets() async{
    var res = await accountReptra.GetPoRefdet();
    poDets = res;
    notifyListeners();
  }



}
