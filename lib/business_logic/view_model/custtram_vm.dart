import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/data_layer/custsetups/custtram.dart';

import '../../business_logic/model/account_m.dart';
import 'package:sbterp/data_layer/localdata/localdata.dart';
import 'package:http/http.dart' as http;
import '../../apis/api_endpoints.dart';
import '../model/custtram_m.dart';
class CusttrarmVM extends ChangeNotifier{
  String? userDetails;
  CusttraMM? lctrsM;

  AccountReptra accountReptra=AccountReptra();
  SavedLocalData savedLocalData=SavedLocalData();
  void removeLocalData(String key)async{
    await savedLocalData.removeKey(key);
    userDetails=null;
    notifyListeners();
  }



  Future<void> losttSearchBySerial(int mid)async{

    var res=await accountReptra.losttSearchBySerial(mid);
    lctrsM=res;
    notifyListeners();
  }
  void LoadUserData()async{
    userDetails=await savedLocalData.getUserName();

    notifyListeners();
  }



}
