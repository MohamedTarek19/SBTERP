import 'dart:ffi';

import 'package:sbterp/data_layer/custsetups/stortype.dart';

class CitySetsM {
  String? cityname;
  int? id;
  String? ntown;

  CitySetsM(
      {this.cityname,
        this.id,
        this.ntown,
      });

  factory CitySetsM.formJson(Map<String, dynamic> json) {
    return CitySetsM(
      cityname: json["cityname"] ,
      id: json["id"],
      ntown: json["ntown"],

    );
  }

  Map toJson() {
    return {
      "cityname": cityname as String,
      "id": "0",
      "ntown": ntown as String,
    };
  }
}
