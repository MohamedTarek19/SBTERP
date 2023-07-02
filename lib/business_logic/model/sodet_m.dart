import 'dart:ffi';


class SodetM {
  int? id;
  int? invno;
  int? e_id;
  String? e_disc;
  double? e_qty;
  double? e_price;
  double? e_tot;
  double? e_tax;
  double? e_disco;
  double? e_discprec;
  String? e_sale;
  int? storid;

  SodetM(
      {this.id,
        this.invno,
        this.e_id,
        this.e_disc,
        this.e_qty,
        this.e_price,
        this.e_tot,
        this.e_tax,
        this.e_disco,
        this.e_discprec,
        this.e_sale,
        this.storid,
      });
  factory SodetM.formJson(Map<String, dynamic> json) {
    return SodetM(
        id: json["id"] ,
        invno: json["invno"] ,
        e_id:json['e_id'] ,
        e_disc:json['e_disc'] ,
        e_qty: json["e_qty"].toDouble(),
        e_price: json["e_price"].toDouble(),
        e_tot: json["e_tot"].toDouble(),
        e_tax: json["e_tax"].toDouble(),
        e_discprec: json["e_discprec"].toDouble(),
        e_disco: json["e_disco"].toDouble(),
        e_sale: json["e_sale"] as String?,
        storid: json["storid"]

    );
  }
  Map toJson() {
    return {
      "id": "0",
      "invno": invno.toString(),
      "e_id": e_id.toString(),
      "e_disc": e_disc.toString(),
      "e_qty": e_qty.toString(),
      "e_price": e_price.toString(),
      "e_tot": e_tot.toString(),
      "e_tax": e_tax.toString(),
      "e_discprec":e_discprec .toString(),
      "e_disco":e_disco .toString(),
      "e_sale":e_sale .toString(),
      "storid":storid .toString(),
    };
  }
}
