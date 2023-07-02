import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/poreqdet_m.dart';
import 'package:sbterp/data_layer/custsetups/poreqdet.dart';

import 'package:sbterp/data_layer/localdata/localdata.dart';
import 'package:http/http.dart' as http;
import '../../apis/api_endpoints.dart';
class PoreqdetVM extends ChangeNotifier{
 PoreqdetM? lsohdrM;

  String? userDetails;
  AccountReptra accountReptra=AccountReptra();
  SavedLocalData savedLocalData=SavedLocalData();
  void removeLocalData(String key)async{
    await savedLocalData.removeKey(key);
    userDetails=null;
    notifyListeners();
  }


  Future<dynamic> CreateInvoice(PoreqdetM poreqdetM)async{
    var result= await accountReptra.CreateInvoice(poreqdetM);
    return result;
  }



}
