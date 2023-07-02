import 'package:flutter/cupertino.dart';


import '../../apis/api_endpoints.dart';
import 'package:http/http.dart' as http;

import '../../data_layer/custsetups/empsetup.dart';
import '../model/empsetup_m.dart';

class EmpVM extends ChangeNotifier {
  List<EmpsetupM>? jopTitls;
  List<EmpsetupM>? Emps;
  List<EmpsetupM>? filtredJobs;
  String?  searchValue;

  final EmpRep _EmpRep = EmpRep();
  getFiltredJobs(List<EmpsetupM>? jopTitls, String filterText) {
    if(filterText.length==0){
      filtredJobs=[];
    }
    else {
      filtredJobs =
          jopTitls?.where((e) => e.emp_name!.trim().contains(filterText)).toList();
    }
    notifyListeners();
  }

  Future<void> getJobTitles(String jopName) async {
    jopTitls = await _EmpRep.getJobTitles(jopName);
    notifyListeners();
  }
  Future<void> getEmps() async {
    Emps = await _EmpRep.getEmps();
    notifyListeners();
  }



}
