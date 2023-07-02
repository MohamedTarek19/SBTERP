import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/cashboxset_m.dart';
import 'package:sbterp/data_layer/custsetups/cashboxsets.dart';

import 'package:sbterp/data_layer/localdata/localdata.dart';
import 'package:http/http.dart' as http;
import '../../apis/api_endpoints.dart';
class CashboxsetVM extends ChangeNotifier{

  String? userDetails;
  AccountRep accountRep=AccountRep();
  CashBoxsetM? lostsM;





  Future<CashBoxsetM?> findboxbyname(String boxName)async{

    var res= await accountRep.findboxbyname(boxName);
    return res;

  }





}
