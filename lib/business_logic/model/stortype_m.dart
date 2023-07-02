import 'dart:ffi';

import 'package:sbterp/data_layer/custsetups/stortype.dart';

class StortypeM {
  String? stordisc;
  int? id;
  StortypeM(
      {this.stordisc,
        this.id,

      });
  factory StortypeM.formJson(Map<String, dynamic> json) {
    return StortypeM(
        stordisc: json["stordisc"] ,
        id: json["id"]
    );
  }
  Map toJson() {
    return {
      "stordisc": stordisc as String,
      "id": "0",


    };
  }
}
