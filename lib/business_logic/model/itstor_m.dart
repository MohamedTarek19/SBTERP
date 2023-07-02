import 'package:sbterp/data_layer/custsetups/itstor.dart';

class ItstorM {
  int? sitemid;
  String? sitemdisc;
  String? sitbarcode;
  String? sitemunit;
  int? storid;
  int? sitemqty;
  String? gitemid;
  String? gitemsubid;
  double? itpo;
  double? itso;
  double? itsos;
  double? itsop;
  double? bal;
  double? disc;
  double? discprec;
  int? itservice;
  //String? imgpat;

  String? accno;
  int? netsho;
  int? branid;
  int? compid;

  ItstorM(
      {this.sitemid,
        this.sitemdisc,
        this.sitbarcode,
        this.itso,
        this.gitemid,
        this.storid,
        this.bal,
        this.disc,
        this.discprec,
        this.gitemsubid,
        //this.imgpat,
        this.itpo,
        this.itservice,
        this.itsop,
        this.itsos,
        this.sitemqty,
        this.sitemunit,


        this.compid,
        this.branid,
        this.accno,
        this.netsho,
      });
  factory ItstorM.formJson(Map<String, dynamic> json) {
    return ItstorM(
        sitemid: json["sitemid"],
        sitemdisc: json["sitemdisc"],
        sitbarcode: json["sitbarcode"],
        itso: json["itso"]as double?,
        gitemid: json["gitemid"],
        storid: json["storid"].toInt(),
        bal: json["bal"] as double?,
        disc: json["disc"] as double?,
        discprec: json["discprec"]as double?,
        gitemsubid: json["gitemsubid"],
        //imgpat: json["imgpat"],
        itpo: json["itpo"]as double?,
        itservice: json["itservice"].toInt(),
        itsop: json["itsop"]as double?,
        itsos: json["itsos"]as double?,
        sitemqty: json["sitemqty"] as int?,
        sitemunit: json["sitemunit"],

        compid: json["compid"]as int?,
        branid: json['branid']as int?,
        accno: json['accno'],
        netsho: json['netsho']as int?,

    );
  }
  Map toJson() {
    return {
      "sitemid":"0",
      "sitemdisc": sitemdisc,
      "sitbarcode": sitbarcode,
      "itso": itso.toString(),
      "storid": storid.toString(),
      "bal": bal.toString(),
      "disc": disc.toString(),
      "discprec": discprec.toString(),
      "gitemsubid": gitemsubid,
      "gitemid": gitemid,
      //"imgpat": imgpat.toString(),
      "itservice": itservice.toString(),
      "itpo": itpo.toString(),
      "itsop": itsop.toString(),
      "itsos": itsos.toString(),
      "sitemqty": sitemqty.toString(),
      "sitemunit": sitemunit,
      'compid': compid.toString(),
      'branid': branid.toString(),
      'accno': accno,
      'netsho': netsho.toString(),
    };
  }
}
