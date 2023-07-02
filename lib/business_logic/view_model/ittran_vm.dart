import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/ittrans.dart';
import 'package:sbterp/data_layer/custsetups/ittran.dart';

import 'package:sbterp/data_layer/localdata/localdata.dart';
import 'package:http/http.dart' as http;
import '../../apis/api_endpoints.dart';
class IttranVM extends ChangeNotifier{
  IttransM? lostsM;
  String? userDetails;
  AccountRep accountRep=AccountRep();



  Future<dynamic> Createrec(IttransM ittransM)async{



    var result= await accountRep.Createrec(ittransM);
    return result;
  }
  Future<void> losttSearchBySerial(String code ,int storcode)async{

    var res=await accountRep.losttSearchBySerial(code,storcode);
    lostsM=res;
    notifyListeners();
  }





}
