import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/customer_m.dart';
import 'package:sbterp/business_logic/model/supsetups_m.dart';
import 'package:sbterp/data_layer/custsetups/customer.dart';
import 'package:sbterp/data_layer/custsetups/subsetups.dart';

import 'package:sbterp/data_layer/localdata/localdata.dart';
import 'package:http/http.dart' as http;
import '../../apis/api_endpoints.dart';
class SupSetupsVM extends ChangeNotifier{

  SupSetupsRepository accountRep=SupSetupsRepository();
  List<SubSetupsM>? Suppliers = [];

  Future<dynamic> CreateSupplier(SubSetupsM supplierM)async{

    var result= await accountRep.CreateSupplier(supplierM);
    return result;
  }

  Future <void> getSuppliers()async{
    var res=await accountRep.GetSuppliers();
    Suppliers = res;
    notifyListeners();

  }
  Future <void> DeleteSupplier(int id)async{
    var res=await accountRep.deleteGroup(id);
    notifyListeners();
  }
  Future <void> EditSupplier(int id,SubSetupsM supplierM)async{
    var res=await accountRep.EditGroup(id, supplierM);
    notifyListeners();

  }



}
