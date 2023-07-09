import 'package:sbterp/data_layer/custsetups/custtra.dart';

class SuptrasM {
  int? id;
  int? supid;
  String? disc;
  DateTime? docdate;
  int? docno;
  double? credit;
  double? debit;
  double? lastb;

  SuptrasM(
      {this.id,
        this.supid,
        this.disc,
        this.docdate,
        this.docno,
        this.credit,
        this.debit,
        this.lastb

      });
  factory SuptrasM.formJson(Map<String, dynamic> json) {
    return SuptrasM(
        id: json["id"],
        supid: json["supid"],
        disc: json["disc"] ,
        docdate:DateTime.parse(json['docdate'] as String),
        docno: json["docno"],
        credit: json["credit"].toDouble(),
        debit: json["debit"].toDouble(),
        lastb: json["lastb"].toDouble()
    );
  }
  Map toJson() {
    return {
      "id":"0",
      "supid": supid.toString(),
      "disc": disc.toString(),
      "docdate":docdate.toString(),
      "docno": docno.toString(),
      "credit": credit.toString() ,
      "debit": debit.toString(),
      "lastb": lastb.toString(),
    };
  }
}
