import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/custtra_m.dart';
import 'package:sbterp/business_logic/model/suptras_m.dart';
import 'package:sbterp/data_layer/custsetups/Suptras.dart';
import 'package:sbterp/data_layer/custsetups/custtra.dart';

import 'package:sbterp/data_layer/localdata/localdata.dart';
import 'package:http/http.dart' as http;
import '../../apis/api_endpoints.dart';
class SupptrarVM extends ChangeNotifier{
  SuptrasM? lostsM;
  SuptrasM? lctrsM;
  List<SuptrasM>? SuptransList;
  String? userDetails;
  SuppReptra accountReptra=SuppReptra();
  SavedLocalData savedLocalData=SavedLocalData();
  void removeLocalData(String key)async{
    await savedLocalData.removeKey(key);
    userDetails=null;
    notifyListeners();
  }
  Future <Object> lostReport(SuptrasM lostsM)async{
    var res=accountReptra.lostReport(lostsM);
    return res;

  }

  Future<dynamic> CreateCustomertra(SuptrasM supptraM)async{
    var result= await accountReptra.CreateSuppliertra(supptraM);
    return result;
  }

  Future<void> losttSearchBySerial(int mid)async{
    var res=await accountReptra.losttSearchBySerial(mid);
    lctrsM=res;
    notifyListeners();
  }
  Future<dynamic> GetAllTransactions()async{
    var result= await accountReptra.GetAllTransactions();
    SuptransList = result;
    return result;
  }



}
