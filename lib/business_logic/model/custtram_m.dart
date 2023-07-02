import 'package:sbterp/data_layer/custsetups/custtra.dart';

class CusttraMM {
  int? id;
  int? custid;
  int? docno;
  double? lastb;

  CusttraMM(
      {this.id,
        this.custid,
        this.docno,
        this.lastb

      });
  factory CusttraMM.formJson(Map<String, dynamic> json) {
    return CusttraMM(
        id: json["id"],
        custid: json["custid"],
        docno: json["docno"],
        lastb: json["lastb"].toDouble()
    );
  }
  Map toJson() {
    return {
      "id":"0",
      "custid": custid.toString(),
      "docno": docno.toString(),
      "lastb": lastb.toString(),
    };
  }
}
