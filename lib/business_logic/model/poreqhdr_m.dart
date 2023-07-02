import 'dart:ffi';

import 'package:sbterp/data_layer/custsetups/sohdrs.dart';

class PoreqhdrM {
  String? name;
  int? invno;
  DateTime? invdate;
  int? stat;


  PoreqhdrM(
      {this.name,
        this.invno,
        this.invdate,
        this.stat,


      });
  factory PoreqhdrM.formJson(Map<String, dynamic> json) {
    return PoreqhdrM(
        name: json["name"] ,
        invno: json["invno"] ,
        invdate:DateTime.parse(json['invdate'] as String),
      stat: json["stat"]


    );
  }
  Map<String, dynamic> toJson() {
    return {
      "name": name as String,
      "invno": "0",
      "invdate": invdate.toString(),
      "stat": stat.toString(),
    };
  }
}
