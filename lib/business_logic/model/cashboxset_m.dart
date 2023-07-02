import 'package:sbterp/data_layer/custsetups/boxtrans.dart';

class CashBoxsetM {
  int? id;
  String? boxname;
  int? boxval;


  CashBoxsetM(
      {this.id,
        this.boxname,
        this.boxval,

      });
  factory CashBoxsetM.formJson(Map<String, dynamic> json) {
    return CashBoxsetM(
        id: json["id"],
        boxname: json["boxname"],
        boxval: json["boxval"]

    );
  }
  Map toJson() {
    return {
      "id": "0",
      "boxname": boxname.toString() ,
      "boxval": boxval.toString() ,
    
    };
  }
}
