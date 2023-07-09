import 'package:sbterp/data_layer/custsetups/custtra.dart';

class TblSetTsM {
  int? id              ;
 bool? stock           ;
 bool? po              ;
 bool? so              ;
 bool? employee        ;
 bool? acc             ;
 bool? factory         ;
 bool? maint           ;
 bool? crm             ;
 bool? contract        ;
 bool? setting         ;
 bool? cpanel          ;
 bool? Recipt          ;
 bool? bigrep          ;
 bool? onlinesup       ;
 bool? calcso          ;
 bool? stockpoin       ;
 bool? stocksoin       ;
 bool? stocktrans      ;
 bool? poin            ;
 bool? soin            ;
 bool? poinv           ;
 bool? soinv           ;
 bool? qution          ;
 bool? poinvref        ;
 bool? soinvref        ;
 bool? clolor          ;
 bool? size            ;
 bool? units           ;
 bool? multtistor      ;
 bool? transfer        ;
 bool? pos             ;
 bool? shipment        ;
 bool? carmaint        ;
 bool? casherfast      ;
 bool? cashercust      ;
 bool? constract       ;
 bool? computer        ;
 bool? mobile          ;
 bool? clothes         ;
 bool? foods           ;
 bool? sim             ;

  TblSetTsM(
      {
        this.id,
        this.stock       ,
        this.po          ,
        this.so          ,
        this.employee    ,
        this.acc         ,
        this.factory     ,
        this.maint       ,
        this.crm         ,
        this.contract    ,
        this.setting     ,
        this.cpanel      ,
        this.Recipt      ,
        this.bigrep      ,
        this.onlinesup   ,
        this.calcso      ,
        this.stockpoin   ,
        this.stocksoin   ,
        this.stocktrans  ,
        this.poin        ,
        this.soin        ,
        this.poinv       ,
        this.soinv       ,
        this.qution      ,
        this.poinvref    ,
        this.soinvref    ,
        this.clolor      ,
        this.size        ,
        this.units       ,
        this.multtistor  ,
        this.transfer    ,
        this.pos         ,
        this.shipment    ,
        this.carmaint    ,
        this.casherfast  ,
        this.cashercust  ,
        this.constract   ,
        this.computer    ,
        this.mobile      ,
        this.clothes     ,
        this.foods       ,
        this.sim         ,

      });
  factory TblSetTsM.formJson(Map<String, dynamic> json) {
    return TblSetTsM(
        id: json["id"],
      stock       : json["stock      ".trim()] as bool?,
      po          : json["po         ".trim()] as bool?,
      so          : json["so         ".trim()] as bool?,
      employee    : json["employee   ".trim()] as bool?,
      acc         : json["acc        ".trim()] as bool?,
      factory     : json["factory    ".trim()] as bool?,
      maint       : json["maint      ".trim()] as bool?,
      crm         : json["crm        ".trim()] as bool?,
      contract    : json["contract   ".trim()] as bool?,
      setting     : json["setting    ".trim()] as bool?,
      cpanel      : json["cpanel     ".trim()] as bool?,
      Recipt      : json["Recipt     ".trim()] as bool?,
      bigrep      : json["bigrep     ".trim()] as bool?,
      onlinesup   : json["onlinesup  ".trim()] as bool?,
      calcso      : json["calcso     ".trim()] as bool?,
      stockpoin   : json["stockpoin  ".trim()] as bool?,
      stocksoin   : json["stocksoin  ".trim()] as bool?,
      stocktrans  : json["stocktrans ".trim()] as bool?,
      poin        : json["poin       ".trim()] as bool?,
      soin        : json["soin       ".trim()] as bool?,
      poinv       : json["poinv      ".trim()] as bool?,
      soinv       : json["soinv      ".trim()] as bool?,
      qution      : json["qution     ".trim()] as bool?,
      poinvref    : json["poinvref   ".trim()] as bool?,
      soinvref    : json["soinvref   ".trim()] as bool?,
      clolor      : json["clolor     ".trim()] as bool?,
      size        : json["size       ".trim()] as bool?,
      units       : json["units      ".trim()] as bool?,
      multtistor  : json["multtistor ".trim()] as bool?,
      transfer    : json["transfer   ".trim()] as bool?,
      pos         : json["pos        ".trim()] as bool?,
      shipment    : json["shipment   ".trim()] as bool?,
      carmaint    : json["carmaint   ".trim()] as bool?,
      casherfast  : json["casherfast ".trim()] as bool?,
      cashercust  : json["cashercust ".trim()] as bool?,
      constract   : json["constract  ".trim()] as bool?,
      computer    : json["computer   ".trim()] as bool?,
      mobile      : json["mobile     ".trim()] as bool?,
      clothes     : json["clothes    ".trim()] as bool?,
      foods       : json["foods      ".trim()] as bool?,
      sim         : json["sim        ".trim()] as bool?,
    );
  }
  Map toJson() {
    return {
      "id":"0",
      "stock      ".trim(): stock      .toString(),
      "po         ".trim(): po         .toString(),
      "so         ".trim(): so         .toString(),
      "employee   ".trim(): employee   .toString(),
      "acc        ".trim(): acc        .toString(),
      "factory    ".trim(): factory    .toString(),
      "maint      ".trim(): maint      .toString(),
      "crm        ".trim(): crm        .toString(),
      "contract   ".trim(): contract   .toString(),
      "setting    ".trim(): setting    .toString(),
      "cpanel     ".trim(): cpanel     .toString(),
      "Recipt     ".trim(): Recipt     .toString(),
      "bigrep     ".trim(): bigrep     .toString(),
      "onlinesup  ".trim(): onlinesup  .toString(),
      "calcso     ".trim(): calcso     .toString(),
      "stockpoin  ".trim(): stockpoin  .toString(),
      "stocksoin  ".trim(): stocksoin  .toString(),
      "stocktrans ".trim(): stocktrans .toString(),
      "poin       ".trim(): poin       .toString(),
      "soin       ".trim(): soin       .toString(),
      "poinv      ".trim(): poinv      .toString(),
      "soinv      ".trim(): soinv      .toString(),
      "qution     ".trim(): qution     .toString(),
      "poinvref   ".trim(): poinvref   .toString(),
      "soinvref   ".trim(): soinvref   .toString(),
      "clolor     ".trim(): clolor     .toString(),
      "size       ".trim(): size       .toString(),
      "units      ".trim(): units      .toString(),
      "multtistor ".trim(): multtistor .toString(),
      "transfer   ".trim(): transfer   .toString(),
      "pos        ".trim(): pos        .toString(),
      "shipment   ".trim(): shipment   .toString(),
      "carmaint   ".trim(): carmaint   .toString(),
      "casherfast ".trim(): casherfast .toString(),
      "cashercust ".trim(): cashercust .toString(),
      "constract  ".trim(): constract  .toString(),
      "computer   ".trim(): computer   .toString(),
      "mobile     ".trim(): mobile     .toString(),
      "clothes    ".trim(): clothes    .toString(),
      "foods      ".trim(): foods      .toString(),
      "sim        ".trim(): sim        .toString(),


    };
  }
}
