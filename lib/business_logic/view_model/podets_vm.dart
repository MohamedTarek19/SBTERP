import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/podets_m.dart';
import 'package:sbterp/business_logic/model/porefdets_m.dart';
import 'package:sbterp/business_logic/model/sodet_m.dart';
import 'package:sbterp/business_logic/model/sorefdets_m.dart';
import 'package:sbterp/data_layer/custsetups/podets.dart';
import 'package:sbterp/data_layer/custsetups/porefdet.dart';
import 'package:sbterp/data_layer/custsetups/sodet.dart';
import 'package:sbterp/data_layer/custsetups/sorefdets.dart';

import 'package:sbterp/data_layer/localdata/localdata.dart';
import 'package:http/http.dart' as http;
import '../../apis/api_endpoints.dart';
class PodetsVM extends ChangeNotifier{
  PodetsM? lsohdrM;
  List<PodetsM>? poDets;

  String? userDetails;
  PodetsRepo accountReptra=PodetsRepo();
  SavedLocalData savedLocalData=SavedLocalData();
  void removeLocalData(String key)async{
    await savedLocalData.removeKey(key);
    userDetails=null;
    notifyListeners();
  }


  Future<dynamic> CreateInvoice(PodetsM PodetM)async{
    var result= await accountReptra.CreateInvoice(PodetM);
    return result;
  }
  Future<void> GetPoRefdets() async{
    var res = await accountReptra.GetPodet();
    poDets = res;
    notifyListeners();
  }



}
