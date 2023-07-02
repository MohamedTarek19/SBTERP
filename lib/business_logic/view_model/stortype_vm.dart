import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/stortype_m.dart';
import 'package:sbterp/data_layer/custsetups/stortype.dart';

import 'package:sbterp/data_layer/localdata/localdata.dart';
import 'package:http/http.dart' as http;
import '../../apis/api_endpoints.dart';
class StortypeVM extends ChangeNotifier{
  StortypeVM? lostsM;
  List<StortypeM>? stores = [];
  AccountReptra accountReptra=AccountReptra();

  Future<StortypeM?> findstorbyname(String cusName)async{
    var res= await accountReptra.findstorbyname(cusName);
    notifyListeners();
    return res;
  }

  Future<List<StortypeM>?> GetAllStores()async{
    var res= await accountReptra.GetAllStores();
    stores = res;
    notifyListeners();
    return res;
  }
  Future<Object> AddStore(StortypeM storM) async {
    var res = await accountReptra.AddStore(storM);
    notifyListeners();
    return res;
  }




}
