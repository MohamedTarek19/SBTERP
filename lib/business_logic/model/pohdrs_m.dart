import 'dart:ffi';

import 'package:sbterp/data_layer/custsetups/sohdrs.dart';

class PohdrsM {
  String? name;
  int? invno;
  DateTime? invdate;
  double? invtot;
  double? discount;
  double? vatpo;
  String? salesman;
  int? storid;
  int? stat;
  int? dayno;

  PohdrsM(
      {this.name,
        this.invno,
        this.invdate,
        this.invtot,
        this.discount,
        this.vatpo,
        this.salesman,
        this.storid,
        this.stat,
        this.dayno,

      });
  factory PohdrsM.formJson(Map<String, dynamic> json) {
    return PohdrsM(
      name: json["name"] ,
      invno: json["invno"] ,
      invdate:DateTime.parse(json['invdate'] as String),
      invtot: json["invtot"].toDouble(),
      discount: json["discount"].toDouble(),
      vatpo: json["vatpo"].toDouble(),
      salesman: json["custmobile"] as String?,
      storid: json["storid"],
      stat: json["stat"] ,
      dayno: json["dayno"],
    );
  }
  Map<String, dynamic> toJson() {
    return {
      "name": name as String,
      "invno": "0",
      "invdate": invdate.toString(),
      "invtot": invtot.toString(),
      "discount": discount.toString(),
      "vatpo": vatpo.toString(),
      "salesman": salesman.toString(),
      "storid": storid.toString(),
      "stat": stat.toString(),
      "dayno":dayno .toString(),
    };
  }
}
