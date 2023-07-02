import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/sohdrm_m.dart';
import 'package:sbterp/data_layer/custsetups/sohdrms.dart';

import 'package:sbterp/data_layer/localdata/localdata.dart';
import 'package:http/http.dart' as http;
import '../../apis/api_endpoints.dart';
class SohdrmVM extends ChangeNotifier{
  SohdrmM? lsohdrM;
  AccountReptra accountReptra=AccountReptra();

  Future<void> findmaxinv(int mid)async{

    var res=await accountReptra.findmaxinv(mid);
    lsohdrM=res;
    notifyListeners();
  }



}
