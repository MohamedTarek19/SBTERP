import 'package:sbterp/data_layer/custsetups/custtra.dart';

class CusttraM {
  int? id;
  int? custid;
  String? disc;
 DateTime? docdate;
 int? docno;
 double? credit;
 double? debit;
 double? lastb;

  CusttraM(
      {this.id,
      this.custid,
        this.disc,
     this.docdate,
        this.docno,
        this.credit,
        this.debit,
        this.lastb

      });
  factory CusttraM.formJson(Map<String, dynamic> json) {
    return CusttraM(
        id: json["id"],
        custid: json["custid"],
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
     "custid": custid.toString(),
      "disc": disc.toString(),
     "docdate":docdate.toString(),
      "docno": docno.toString(),
      "credit": credit.toString() ,
      "debit": debit.toString(),
      "lastb": lastb.toString(),
    };
  }
}
