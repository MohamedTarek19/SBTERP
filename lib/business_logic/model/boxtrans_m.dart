import 'package:decimal/decimal.dart';
import 'package:sbterp/data_layer/custsetups/boxtrans.dart';
import 'package:json_annotation/json_annotation.dart';
class BoxtransM {
  int? idsys;
  int? boxno;
  int? docno;
  DateTime? docdate;
  String? disc;
  double? credit;
  double? debit;
  double? lastb;

  BoxtransM(
      {this.idsys,
        this.boxno,
        this.docno,
        this.docdate,
        this.disc,
        this.credit,
        this.debit,
        this.lastb,
      });
  factory BoxtransM.formJson(Map<String, dynamic> json) {
    return BoxtransM(
        idsys: json["idsys"],
        boxno: json["boxno"],
        docno: json["docno"] ,
        docdate: DateTime.parse(json['docdate'] as String),
        disc: json["disc"],
        credit:json["credit"].toDouble(),
        debit: json["debit"].toDouble(),
        lastb: json["lastb"].toDouble()
    );
  }
  Map toJson() {
    return {
      "idsys": "0",
      "boxno": boxno.toString() ,
      "docno": docno.toString() ,
      "docdate":docdate.toString(),
      "disc": disc.toString(),
      "credit": credit.toString() ,
      "debit": debit.toString() ,
      "lastb":lastb.toString(),
    };
  }
}
