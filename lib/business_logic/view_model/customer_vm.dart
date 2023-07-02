import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/customer_m.dart';
import 'package:sbterp/data_layer/custsetups/customer.dart';

import 'package:sbterp/data_layer/localdata/localdata.dart';
import 'package:http/http.dart' as http;
import '../../apis/api_endpoints.dart';
class CustomerVM extends ChangeNotifier{

  String? userDetails;
  AccountRep accountRep=AccountRep();
  CustomerM? lostsM;
  List<CustomerM>? Customers = [];

  Future <Object> lostReport(CustomerM lostsM)async{
    var res=accountRep.lostReport(lostsM);
    return res;

  }
  Future<dynamic> CreateCustomer(CustomerM customerM)async{



    var result= await accountRep.CreateCustomer(customerM);
    return result;
  }


  Future<CustomerM?> findcustbyname(String cusName)async{

    var res= await accountRep.findcustbyname(cusName);
  return res;

  }

  Future <void> losttSearchBySerial(String lostM)async{
    var res=await accountRep.losttSearchBySerial(lostM);
    lostsM=res;
    notifyListeners();

  }


  Future <void> DeleteCustomer(int id)async{
    var res=await accountRep.deleteGroup(id);
    notifyListeners();
  }

  Future <void> EditCustomer(int id,CustomerM custM)async{
    print(id);
    var res=await accountRep.EditGroup(id, custM);
    print(res);
    notifyListeners();
  }

  Future <void> getCustomers()async{
    var res=await accountRep.GetCustomers();
    Customers = res;
    notifyListeners();

  }



}
