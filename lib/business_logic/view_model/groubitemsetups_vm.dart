import 'dart:convert';
import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/groubitemsetups_m.dart';
import 'package:sbterp/business_logic/model/stortype_m.dart';
import 'package:sbterp/data_layer/custsetups/groubitemsetups.dart';
import 'package:sbterp/data_layer/custsetups/stortype.dart';

import 'package:sbterp/data_layer/localdata/localdata.dart';
import 'package:http/http.dart' as http;
import '../../apis/api_endpoints.dart';
class GroupItemSetupsVM extends ChangeNotifier{
  List<GroupItemSetupsM>? groups = [];
  GroupItemSetupsRepository accountReptra=GroupItemSetupsRepository();

  Future<List<GroupItemSetupsM>?> GetAllGroups()async{
    var res= await accountReptra.GetAllGroups();
    groups = res;
    notifyListeners();
    return res;
  }
  Future<Object> AddGroup(GroupItemSetupsM groupM) async {
    var res = await accountReptra.AddGroup(groupM);
    notifyListeners();
    return res;
  }

  Future<Object> deleteGroup(int id) async {
    var res = await accountReptra.deleteGroup(id);
    notifyListeners();
    return res;
  }



}
