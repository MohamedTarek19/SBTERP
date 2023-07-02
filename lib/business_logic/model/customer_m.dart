import 'package:sbterp/data_layer/custsetups/customer.dart';

class CustomerM {
  String? custAname;
  int? code;
  String? CustPrice;
  String? custaddres1;
  String? custaddres2;
  String? custmobile;
  String? mandob;
  String? city;

  String? custemail;
  double? custfbal;
  double? custbal;
  double? CreditLimit;

  String? manage;

  double? MaxDayAllwo;
  String? caccorang;
  String? cserorang;
  String? caccaman;
  String? cseraman;
  String? caccahly;
  String? cserahly;
  String? caccmasary;
  String? csermasary;

  CustomerM(
      {this.custAname,
        this.CustPrice,
        this.custaddres1,
        this.custaddres2,
        this.mandob,
        this.custmobile,
        this.city,
        this.code,
        this.custbal,
        this.caccahly,
        this.caccaman,
        this.caccmasary,
        this.caccorang,
        this.CreditLimit,
        this.cserahly,
        this.cseraman,
        this.csermasary,
        this.cserorang,
        this.custemail,
        this.custfbal,
        this.manage,
        this.MaxDayAllwo,
       });
  factory CustomerM.formJson(Map<String, dynamic> json) {
    return CustomerM(
        custAname: json["custAname"] as String?,
        custaddres1: json["custaddres1"] as String?,
        custaddres2: json["custaddres2"] as String?,
        custmobile: json["custmobile"] as String?,
        mandob: json["mandob"] as String?,
        city: json["city"] as String?,
        code: json["code"] as int,
        CustPrice: json["CustPrice"] as String?,
        custbal: json["custbal"],
      custfbal: json["custfbal"],
      CreditLimit: json["CreditLimit"],
      caccahly: json["caccahly"] as String?,
      caccaman: json["caccaman"] as String?,
      caccmasary: json["caccmasary"] as String?,
      caccorang: json["caccorang"] as String?,
      cserahly: json["cserahly"] as String?,
      cseraman: json["cseraman"] as String?,
      csermasary: json["csermasary"] as String?,
      cserorang: json["cserorang"] as String?,
      custemail: json["custemail"] as String?,
      manage: json["manage"] as String?,
      MaxDayAllwo: json["MaxDayAllwo"],

    );
  }
  Map toJson() {
    return {
      "custAname": custAname as String?,
      "custaddres1": custaddres1 as String?,
      "custaddres2": custaddres2 as String?,
      "custmobile": custmobile as String?,
      "mandob": mandob as String?,
      "city": city as String?,
      "code":"0",
      "CustPrice": CustPrice as String?,
      "custbal": custbal.toString(),
      "CreditLimit": CreditLimit.toString(),
      "custfbal": custfbal.toString(),
      "caccahly": caccahly as String?,
      "caccaman": caccaman as String?,
      "caccmasary": caccmasary as String?,
      "caccorang": caccorang as String?,
      "cserahly": cserahly as String?,
      "cseraman": cseraman as String?,
      "csermasary": csermasary as String?,
      "cserorang": cserorang as String?,
      "custemail": custemail as String?,
      "manage": manage as String?,
      "MaxDayAllwo": MaxDayAllwo.toString(),
    };
  }
}
