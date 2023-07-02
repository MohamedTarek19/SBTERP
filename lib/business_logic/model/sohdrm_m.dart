import 'dart:ffi';

import 'package:sbterp/data_layer/custsetups/sohdrms.dart';

class SohdrmM {
  int? invno;
  int? dayno;

  SohdrmM(
      {
        this.invno,
        this.dayno
      });

  factory SohdrmM.formJson(Map<String, dynamic> json) {
    return SohdrmM(
        invno: json["invno"],
        dayno: json["dayno"]
    );
  }
  Map toJson() {
    return {
      "invno": "0",
    "dayno":dayno .toString()
    };
  }
}
