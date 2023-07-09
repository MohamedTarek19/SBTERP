import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/groubitsubs_m.dart';
import 'package:sbterp/data_layer/custsetups/groubitsubs.dart';

import 'package:http/http.dart' as http;
import '../../apis/api_endpoints.dart';
class GroubItSubsVM extends ChangeNotifier{
  List<GroubItSubsM>? groups = [];
  GroubItSubsRepository accountReptra=GroubItSubsRepository();

  Future<List<GroubItSubsM>?> GetAllGroups()async{
    var res= await accountReptra.GetAllGroups();
    groups = res;
    notifyListeners();
    return res;
  }
  Future<Object> AddGroup(GroubItSubsM groupS) async {
    var res = await accountReptra.AddGroup(groupS);
    notifyListeners();
    return res;
  }

  Future<Object> deleteGroup(int id) async {
    var res = await accountReptra.deleteGroup(id);
    notifyListeners();
    return res;
  }
  Future<List<GroubItSubsM>?> GetSubGroups(String mainGroup)async{
    var res= await accountReptra.GetSubGroups(mainGroup);
    groups = res;
    notifyListeners();
    return res;
  }



}
