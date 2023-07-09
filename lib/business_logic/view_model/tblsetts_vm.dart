import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/stortype_m.dart';
import 'package:sbterp/business_logic/model/tblsetts_m.dart';
import 'package:sbterp/data_layer/custsetups/stortype.dart';
import 'package:sbterp/data_layer/custsetups/tblsetts.dart';

import 'package:sbterp/data_layer/localdata/localdata.dart';
import 'package:http/http.dart' as http;
import '../../apis/api_endpoints.dart';
class TblSetTsVM extends ChangeNotifier{
  TblSetTsM? lostsM;
  List<TblSetTsM>? tbls = [];
  TblSetTsRepo accountReptra=TblSetTsRepo();

  Future<List<TblSetTsM>?> GetAllTBLS()async{
    var res= await accountReptra.GetAllTbls();
    tbls = res;
    notifyListeners();
    return res;
  }
  Future<Object> AddStore(TblSetTsM tbl) async {
    var res = await accountReptra.AddTBL(tbl);
    notifyListeners();
    return res;
  }




}
