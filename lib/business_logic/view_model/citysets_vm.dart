import 'dart:convert';
import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/citysets_m.dart';

import 'package:sbterp/data_layer/custsetups/citysets.dart';

import 'package:http/http.dart' as http;

class CitySetsVM extends ChangeNotifier{
  List<CitySetsM>? cities = [];
  CitySetsRepository accountReptra=CitySetsRepository();

  Future<List<CitySetsM>?> GetAllCities()async{
    var res= await accountReptra.GetAllCities();
    cities = res;
    notifyListeners();
    return res;
  }

}
