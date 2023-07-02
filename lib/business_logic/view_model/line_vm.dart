import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/line_m.dart';
import 'package:sbterp/data_layer/line/lineset.dart';
import 'package:sbterp/data_layer/localdata/localdata.dart';
import 'package:sbterp/data_layer/line/lineset.dart';
class LineVM extends ChangeNotifier{

  LineM? lostsM;
  AccountRep stolenRep=AccountRep();
  Future <Object> lostReport(LineM lostM)async{
  var res=stolenRep.lostReport(lostM);
  return res;

  }
  Future <void> losttSearchBySerial(String lostM)async{
  var res=await stolenRep.losttSearchBySerial(lostM);
  lostsM=res;
  notifyListeners();

  }

  }