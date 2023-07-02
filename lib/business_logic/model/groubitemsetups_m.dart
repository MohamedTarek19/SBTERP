import 'dart:ffi';

import 'package:sbterp/data_layer/custsetups/stortype.dart';

class GroupItemSetupsM {
  String? gitemdisc;
  int? gitemid;
  String? accno;
  int? branid;
  GroupItemSetupsM(
      {this.gitemdisc,
        this.gitemid,
        this.accno,
        this.branid,
      });

  factory GroupItemSetupsM.formJson(Map<String, dynamic> json) {
    return GroupItemSetupsM(
        gitemdisc: json["gitemdisc"] ,
        gitemid: json["gitemid"],
        accno: json["accno"],
        branid: json["branid"],
    );
  }

  Map toJson() {
    return {
      "gitemdisc": gitemdisc as String,
      "gitemid": "0",
      "accno": accno as String,
      "branid": '0',
    };
  }
}
