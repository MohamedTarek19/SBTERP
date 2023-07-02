import 'package:sbterp/data_layer/custsetups/customer.dart';

class SubSetupsM {
  String? supAname;
  int? code;
  String? supaddres1;
  String? supaddres2;
  String? supmobile;
  String? suptel1;
  String? supemail;
  double? supfbal;
  double? supbal;
  int? compid;
  String? supaccno;


  SubSetupsM(
      {this.supAname,
        this.supaddres1,
        this.supaddres2,
        this.supmobile,
        this.code,
        this.supbal,
        this.supaccno,
        this.supemail,
        this.supfbal,
        this.compid,
        this.suptel1,
      });
  factory SubSetupsM.formJson(Map<String, dynamic> json) {
    return SubSetupsM(
      supAname: json["supAname"] as String?,
      supaddres1: json["supaddres1"] as String?,
      supaddres2: json["supaddres2"] as String?,
      supmobile: json["supmobile"] as String?,
      code: json["code"] as int?,
      supbal: json["supbal"],
      supfbal: json["supfbal"],
      supaccno: json["supaccno"] as String?,
      supemail: json["supemail"] as String?,
      compid: json["compid"] as int?,
      suptel1: json['suptel1'] as String?,
    );
  }
  Map toJson() {
    return {
      "supAname": supAname as String?,
      "supaddres1": supaddres1 as String?,
      "supaddres2": supaddres2 as String?,
      "supmobile": supmobile as String?,
      "code":code.toString(),
      "supbal": supbal.toString(),
      "supfbal": supfbal.toString(),
      "supaccno": supaccno as String?,
      "supemail": supemail as String?,
      "compid": compid.toString(),
      "suptel1": suptel1 as String?,
    };
  }
}
