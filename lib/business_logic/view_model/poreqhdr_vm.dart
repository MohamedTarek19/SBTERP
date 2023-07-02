import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/poreqhdr_m.dart';
import 'package:sbterp/data_layer/custsetups/poreqhdr.dart';

import 'package:sbterp/data_layer/localdata/localdata.dart';
import 'package:http/http.dart' as http;
import '../../apis/api_endpoints.dart';
class PoreqhdrVM extends ChangeNotifier{
  PoreqhdrM? lsohdrM;

  String? userDetails;
  AccountReptra accountReptra=AccountReptra();
  SavedLocalData savedLocalData=SavedLocalData();
  void removeLocalData(String key)async{
    await savedLocalData.removeKey(key);
    userDetails=null;
    notifyListeners();
  }


  Future<dynamic> CreateInvoice(PoreqhdrM poreqhdrM)async{
    var result= await accountReptra.CreateInvoice(poreqhdrM);

    return result;
  }

  Future<void> findmaxinv(int mid)async{

    var res=await accountReptra.findmaxinv(mid);
    lsohdrM=res;
    notifyListeners();
  }


}
