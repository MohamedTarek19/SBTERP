import 'package:decimal/decimal.dart';
import 'package:sbterp/data_layer/custsetups/boxtrans.dart';
import 'package:json_annotation/json_annotation.dart';
class IttransM {
  int? id;
  String? itbar;
  String? itdisc;
  int? invno;
  int? storid;
  DateTime? invdate;
  String? note;
  double? itqty;
  double? sitqty;
  double? itpo;
  double? bal;

  IttransM(
      {this.id,
        this.itbar,
        this.itdisc,
        this.invno,
        this.storid,
        this.invdate,
        this.note,
        this.itqty,
        this.sitqty,
        this.itpo,
        this.bal,
      });
  factory IttransM.formJson(Map<String, dynamic> json) {
    return IttransM(
        id: json["id"],
        itbar: json["itbar"],
        itdisc: json["itdisc"] ,
        invno: json["invno"] ,
        storid: json["storid"] ,
        invdate: DateTime.parse(json['invdate'] as String),
        note: json["note"],
        itqty:json["itqty"].toDouble(),
        sitqty: json["sitqty"].toDouble(),
        itpo: json["itpo"].toDouble(),
        bal: json["bal"].toDouble()
    );
  }
  Map toJson() {
    return {
      "id": "0",
      "itbar": itbar.toString() ,
      "itdisc": itdisc.toString() ,
      "invno":invno.toString(),
      "storid": storid.toString(),
      "invdate": invdate.toString() ,
      "note": note.toString() ,
      "itqty":itqty.toString(),
      "sitqty": sitqty.toString() ,
      "itpo": itpo.toString() ,
      "bal":bal.toString(),
    };
  }
}
