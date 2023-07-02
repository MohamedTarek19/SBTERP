import 'dart:ffi';

import 'package:sbterp/data_layer/custsetups/sodet.dart';

class PoreqdetM {
  int? idsys;
  int? invno;
  String? e_id;
  String? e_disc;
  double? e_qty;


  PoreqdetM(
      {this.idsys,
        this.invno,
        this.e_id,
        this.e_disc,
        this.e_qty,

      });
  factory PoreqdetM.formJson(Map<String, dynamic> json) {
    return PoreqdetM(
        idsys: json["idsys"] ,
        invno: json["invno"] ,
        e_id:json['e_id'] ,
        e_disc:json['e_disc'] ,
        e_qty: json["e_qty"].toDouble()

    );
  }
  Map toJson() {
    return {
      "idsys": "0",
      "invno": invno.toString(),
      "e_id": e_id.toString(),
      "e_disc": e_disc.toString(),
      "e_qty": e_qty.toString(),

    };
  }
}
