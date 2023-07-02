import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/boxtrans_m.dart';
import 'package:sbterp/data_layer/custsetups/boxtrans.dart';

import 'package:sbterp/data_layer/localdata/localdata.dart';
import 'package:http/http.dart' as http;
import '../../apis/api_endpoints.dart';
class BoxtransVM extends ChangeNotifier{
  BoxtransM? lostsM;
  String? userDetails;
  AccountRep accountRep=AccountRep();



  Future<dynamic> Createrec(BoxtransM boxtransM)async{



    var result= await accountRep.Createrec(boxtransM);
    return result;
  }
  Future<void> losttSearchBySerial(int mid)async{

    var res=await accountRep.losttSearchBySerial(mid);
    lostsM=res;
    notifyListeners();
  }





}
