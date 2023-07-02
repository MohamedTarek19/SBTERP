import 'package:sbterp/data_layer/line/lineset.dart';

class LineM {
  String? lser;
  int? id;
  String? ldial;
  String? lshopname;
  String? lstat;
  String? lmandoub;

  LineM(
      {this.lser,
        this.ldial,
        this.lshopname,
        this.id,
        this.lstat, this.lmandoub});
  factory LineM.formJson(Map<String, dynamic> json) {
    return LineM(
        lser: json["lser"] as String,
        ldial: json["ldial"] as String,
        lshopname: json["lshopname"] as String?,
        id: json["id"]  ,
        lmandoub: json["lmandoub"] as String ,
        lstat: json["lstat"] as String);
  }
  Map toJson() {
    return {
      "lser": lser as String,
      "ldial": ldial as String,
      "lshopname": lshopname as String,
      "id":"0",
      "lstat": lstat as String,
      "lmandoub" : lmandoub as String
    };
  }
}
