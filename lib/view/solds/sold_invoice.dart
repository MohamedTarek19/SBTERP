import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sbterp/business_logic/model/boxtrans_m.dart';
import 'package:sbterp/business_logic/model/customer_m.dart';
import 'package:sbterp/business_logic/model/custtra_m.dart';
import 'package:sbterp/business_logic/model/itstor_m.dart';
import 'package:sbterp/business_logic/model/ittrans.dart';
import 'package:sbterp/business_logic/model/sodet_m.dart';
import 'package:sbterp/business_logic/model/sohdr_m.dart';
import 'package:sbterp/business_logic/view_model/account_vm.dart';
import 'package:sbterp/business_logic/view_model/boxtrans_vm.dart';
import 'package:sbterp/business_logic/view_model/cashboxset_vm.dart';
import 'package:sbterp/business_logic/view_model/customer_vm.dart';
import 'package:sbterp/business_logic/view_model/custtra_vm.dart';
import 'package:sbterp/business_logic/view_model/itstor_vm.dart';
import 'package:sbterp/business_logic/view_model/ittran_vm.dart';
import 'package:sbterp/business_logic/view_model/sodet_vm.dart';
import 'package:sbterp/business_logic/view_model/sohdr_vm.dart';
import 'package:sbterp/view/invoice_helper.dart';
import 'package:sbterp/widgets/custom_appbar3.dart';
import 'package:sbterp/widgets/customCalender.dart';
import 'package:sbterp/widgets/custom_dropdown.dart';
import 'package:sbterp/widgets/custom_dropdowncustomers.dart';
import 'package:sbterp/widgets/main_container.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'dart:ui' as ui;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:group_radio_button/group_radio_button.dart';

class SoldInvoice extends StatefulWidget {
  const SoldInvoice({Key? key}) : super(key: key);

  @override
  State<SoldInvoice> createState() => _SoldInvoiceState();
}

class _SoldInvoiceState extends State<SoldInvoice> {
  DateTime? Date;
  String? stockName;
  String? source;
  CustomerM? CustDropDown;
  String? ItemName = "fixed";
  bool viewHeader = false;
  DateTime? selectedDate;
  Color? clr = Color.fromRGBO(240, 240, 240, 1);
  String? barCodeVal;
  double? percent = 0.62;
  double totalprice = 0;
  double? paidVal;
  double? p;
  TextEditingController qty = TextEditingController();
  List<ItemsInInv>? items = [];
  TextEditingController price = TextEditingController();
  Map<int,ItemsInInv> SelectedItem = {};
  List<Color> SelectedItemColor = [];
  double remain= 0;
  String _verticalGroupValue = "آجل";
  String nme = "التاريخ";
  List<CustomerM>? custs = [];
  TextEditingController paid = TextEditingController();
  header head = header();
  Future barCodeReader() async{
    String? code = await FlutterBarcodeScanner.scanBarcode("#ff0000", 'Cancel', true, ScanMode.BARCODE);
    setState(() {
      barCodeVal = code;
    });
    print("#############################"+barCodeVal.toString());
  }

  @override
  initState() {
    super.initState();
    // Add listeners to this class
  }

  DisplayItems() async {

    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromRGBO(240, 240, 240, 1),
            elevation: 100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            title: Container(
                child: Text(
                  'إضافة صنف',
                  style: TextStyle(color: Colors.black, fontSize: 17),
                  textDirection: ui.TextDirection.rtl,
                )),
            content: StatefulBuilder(builder: (context, setState) {
              return Directionality(
                textDirection: ui.TextDirection.rtl,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border:Border.all(color: Colors.black,style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            hintStyle: TextStyle(),
                            hintText: "إدخل إسم المنتج",
                          ),),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5,bottom: 10),
                        child: Divider(
                          color: Colors.black,
                          height: 1,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 5,right: 5),
                        width: MediaQuery.of(context).size.width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              //color: Colors.blue,
                                child: Text('منتج',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),)),
                            Container(
                              //color: Colors.blue,
                                child: Directionality(textDirection: ui.TextDirection.ltr,
                                    child: Text('السعر',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.5,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            itemCount: InvoiceHelper.items?.length,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: ()async{
                                  print(InvoiceHelper.items![index].bal);
                                  await AddingItem(InvoiceHelper.items![index].sitemdisc,InvoiceHelper.items![index].itso,int.tryParse(InvoiceHelper.items![index].sitbarcode??'0')??0,InvoiceHelper.items![index]);
                                },
                                child: Container(
                                  height: 50,
                                  child: Card(
                                    color: Color.fromRGBO(240, 240, 240, 1),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Directionality(
                                          textDirection: ui.TextDirection.rtl,
                                          child: Container(
                                              width: MediaQuery.of(context).size.width*0.18,
                                              child: SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  child: Text(InvoiceHelper.items![index].sitemdisc??'',
                                                    style: TextStyle(fontSize: 16),))
                                          ),
                                        ),
                                        Directionality(
                                          textDirection: ui.TextDirection.ltr,
                                          child: Container(
                                              width: MediaQuery.of(context).size.width*0.2,
                                              child: SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  child: Text(InvoiceHelper.items![index].itso.toString()??'',
                                                    style: TextStyle(fontSize: 16 ),))
                                          ),
                                        ),
                                      ],
                                    ),

                                  ),
                                ),
                              );
                            }),
                      )
                    ],
                  ),
                ),
              );
            }),
            actions: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('إلغاء')),
                ),
              )
            ],
          );
        });
  }
  AddingItem(String? name,double? pce,int? id,ItstorM itsor) async {
    price = TextEditingController();
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromRGBO(240, 240, 240, 1),
            elevation: 100,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            title: Container(
                child: const Text(
                  'إضافة صنف',
                  style: TextStyle(color: Colors.black, fontSize: 17),
                  textDirection: ui.TextDirection.rtl,
                )),
            content: StatefulBuilder(builder: (context, setState) {
              return Directionality(
                textDirection: ui.TextDirection.rtl,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Container(
                        decoration: BoxDecoration(
                          border:Border.all(color: Colors.black,style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            //prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            hintStyle: TextStyle(),
                            enabled: false,
                            hintText: name,
                          ),),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 5,bottom: 10),
                        child: const Divider(
                          color: Colors.black,
                          height: 1,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 1,
                                color: Colors.black,
                                margin: EdgeInsets.only(left: 2,right: 3),
                              )),
                          Expanded(
                              flex: 2,
                              child: Container(
                                child:Center(
                                  child: Text(
                                    "الكمية",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 1,
                                color: Colors.black,
                                margin: EdgeInsets.only(left: 3,right: 2),
                              )),
                        ],
                      ),
                      Container(
                        margin:
                        EdgeInsets.only(top: 2, bottom: 5, left: 5, right: 5),
                        child: NumberInputWithIncrementDecrement(
                          buttonArrangement: ButtonArrangement.incRightDecLeft,
                          incIcon: Icons.add,
                          decIcon: Icons.remove,
                          incIconDecoration: BoxDecoration(
                            border: Border.all(style: BorderStyle.none),
                          ),
                          decIconDecoration: BoxDecoration(
                            border: Border.all(style: BorderStyle.none),
                          ),
                          numberFieldDecoration:
                          InputDecoration(border: InputBorder.none),
                          separateIcons: true,
                          scaleHeight: 0.9,
                          incIconSize: 25,
                          decIconSize: 25,
                          incIconColor: Colors.black,
                          decIconColor: Colors.black,
                          widgetContainerDecoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ), controller: qty,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 1,
                                color: Colors.black,
                                margin: EdgeInsets.only(left: 2,right: 3),
                              )),
                          Expanded(
                              flex: 2,
                              child: Container(
                                child:Center(
                                  child: Text(
                                    "السعر",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 1,
                                color: Colors.black,
                                margin: EdgeInsets.only(left: 3,right: 2),
                              )),
                        ],
                      ),
                      Container(
                        margin:
                        EdgeInsets.only(top: 2, bottom: 5, left: 5, right: 5),
                        child: NumberInputWithIncrementDecrement(
                          buttonArrangement: ButtonArrangement.incRightDecLeft,
                          incIcon: Icons.add,
                          decIcon: Icons.remove,
                          incIconDecoration: BoxDecoration(
                            border: Border.all(style: BorderStyle.none),
                          ),
                          decIconDecoration: BoxDecoration(
                            border: Border.all(style: BorderStyle.none),
                          ),
                          numberFieldDecoration:
                          InputDecoration(border: InputBorder.none),
                          initialValue: pce??0,
                          separateIcons: true,
                          scaleHeight: 0.9,
                          incIconSize: 25,
                          decIconSize: 25,
                          incIconColor: Colors.black,
                          decIconColor: Colors.black,
                          widgetContainerDecoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ), controller: price,
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }),
            actions: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: ElevatedButton(
                      onPressed: () {
                        ItemsInInv inv = ItemsInInv();
                        inv.itemName = name;
                        inv.qty = int.parse(qty.text);
                        inv.unit = "قطعة";
                        inv.price = double.tryParse(price.text)??0.0;
                        double total = inv.qty?.toDouble()??0;
                        inv.totalPrice = (inv.price??0) * total;
                        inv.barId = id;
                        setState(() {
                          totalprice += (inv.totalPrice??0);
                          head.total = totalprice;
                          items?.add(inv);
                          inv.item = itsor;
                          SelectedItemColor.add(Colors.white);
                        });
                        Navigator.of(context).pop();
                      },
                      child: Text('إضافة')),
                ),
              )
            ],
          );
        });
  }

  errorMessage(String message) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromRGBO(240, 240, 240, 1),
            elevation: 100,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            title: Container(
                child: Text(
                  message,
                  style: TextStyle(color: Colors.black, fontSize: 17),
                  textDirection: ui.TextDirection.rtl,
                )),

            actions: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: ElevatedButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text('حسنا')),
                ),
              )
            ],
          );
        });
  }
  SavingInvoice(SohdrVM _sohdrVm,CustomerVM CustVm,CusttrarVM _custtraVm,
      BoxtransVM _boxtraVm,AccountVM account_vm,SodetVM _sodetVm,IttranVM _ittranVm,ItstorVM _itStorVM) async {
    remain = totalprice;
    price = TextEditingController();
    await _custtraVm.losttSearchBySerial(CustDropDown?.code??0);
    // ignore: use_build_context_synchronously
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Color.fromRGBO(240, 240, 240, 1),
            elevation: 100,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            title: Container(
                child: const Text(
                  'حفظ الفاتورة',
                  style: TextStyle(color: Colors.black, fontSize: 17),
                  textDirection: ui.TextDirection.rtl,
                )),
            content: StatefulBuilder(builder: (context, setState) {
              return Directionality(
                textDirection: ui.TextDirection.rtl,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 1,
                                color: Colors.black,
                                margin: EdgeInsets.only(left: 2,right: 3),
                              )),
                          Expanded(
                              flex: 2,
                              child: Container(
                                child:const Center(
                                  child: Text(
                                    "الرصيد السابق",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 1,
                                color: Colors.black,
                                margin: EdgeInsets.only(left: 3,right: 2),
                              )),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border:Border.all(color: Colors.black,style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            //prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            hintStyle: TextStyle(),
                            enabled: false,
                            hintText: _custtraVm.lctrsM?.lastb.toString(),
                          ),),
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 1,
                                color: Colors.black,
                                margin: EdgeInsets.only(left: 2,right: 3),
                              )),
                          Expanded(
                              flex: 2,
                              child: Container(
                                child:const Center(
                                  child: Text(
                                    "إجمالي الفاتورة",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 1,
                                color: Colors.black,
                                margin: EdgeInsets.only(left: 3,right: 2),
                              )),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border:Border.all(color: Colors.black,style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            //prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            hintStyle: TextStyle(),
                            enabled: false,
                            hintText: totalprice.toString(),
                          ),),
                      ),
                      Container(
                        child:RadioGroup<String>.builder(
                          direction: Axis.horizontal,
                          groupValue: _verticalGroupValue,
                          onChanged: (String? val){
                            setState((){
                              _verticalGroupValue = val??'';
                            });
                          },
                          items: ["نقدا","آجل"],
                          itemBuilder: (item) => RadioButtonBuilder(
                            item,
                            textPosition: RadioButtonTextPosition.left,
                          ),),
                      ),
                      SizedBox(
                        height:10,
                      ),
                      //////////////////////////////////////////////////////////////////////////////////////////////////////////
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 1,
                                color: Colors.black,
                                margin: EdgeInsets.only(left: 2,right: 3),
                              )),
                          Expanded(
                              flex: 2,
                              child: Container(
                                child:Center(
                                  child: Text(
                                    "المدفوع",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 1,
                                color: Colors.black,
                                margin: EdgeInsets.only(left: 3,right: 2),
                              )),
                        ],
                      ),
                      Container(
                        margin:
                        EdgeInsets.only(top: 2, bottom: 5, left: 5, right: 5),
                        child: NumberInputWithIncrementDecrement(
                          onChanged: (val){
                            setState((){
                              paidVal = double.tryParse(val.toString())??0;
                              print(double.tryParse(val.toString())??0);
                              remain = totalprice;
                              remain = remain - val;
                            });
                          },

                          onDecrement: (val){
                            if(_verticalGroupValue == 'نقدا'){
                              if(val < totalprice){
                                errorMessage('المبلغ المدفوع أقل من الإجمالي');
                              }
                            }
                            setState((){
                              paidVal = double.tryParse(val.toString())??0;
                              print(double.tryParse(val.toString())??0);
                              remain = totalprice;
                              remain = remain - val;
                            });
                          },
                          onIncrement: (val){
                            print(val);
                            setState((){
                              paidVal = double.tryParse(val.toString())??0;
                              print(double.tryParse(val.toString())??0);
                              remain = totalprice;
                              remain = remain - val;
                            });
                          },
                          buttonArrangement: ButtonArrangement.incRightDecLeft,
                          incIcon: Icons.add,
                          decIcon: Icons.remove,
                          incIconDecoration: BoxDecoration(
                            border: Border.all(style: BorderStyle.none),
                          ),
                          decIconDecoration: BoxDecoration(
                            border: Border.all(style: BorderStyle.none),
                          ),
                          numberFieldDecoration:
                          InputDecoration(border: InputBorder.none),
                          separateIcons: true,
                          scaleHeight: 0.9,
                          incIconSize: 25,
                          decIconSize: 25,
                          incIconColor: Colors.black,
                          decIconColor: Colors.black,
                          widgetContainerDecoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(20),
                          ), controller: paid,
                        ),
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 1,
                                color: Colors.black,
                                margin: EdgeInsets.only(left: 2,right: 3),
                              )),
                          Expanded(
                              flex: 2,
                              child: Container(
                                child:Center(
                                  child: Text(
                                    "المتبقي",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 1,
                                color: Colors.black,
                                margin: EdgeInsets.only(left: 3,right: 2),
                              )),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border:Border.all(color: Colors.black,style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            //prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            hintStyle: TextStyle(),
                            enabled: false,
                            hintText: remain.toString(),
                          ),),
                      ),
                      Row(
                        children: [
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 1,
                                color: Colors.black,
                                margin: EdgeInsets.only(left: 2,right: 3),
                              )),
                          Expanded(
                              flex: 2,
                              child: Container(
                                child:Center(
                                  child: Text(
                                    "إجمالي الرصيد",style: TextStyle(fontSize: 18,fontWeight: FontWeight.bold),
                                  ),
                                ),
                              )),
                          Expanded(
                              flex: 1,
                              child: Container(
                                height: 1,
                                color: Colors.black,
                                margin: EdgeInsets.only(left: 3,right: 2),
                              )),
                        ],
                      ),
                      Container(
                        decoration: BoxDecoration(
                          border:Border.all(color: Colors.black,style: BorderStyle.solid),
                          borderRadius: BorderRadius.circular(10),
                          color: Colors.white,
                        ),
                        child: TextField(
                          keyboardType: TextInputType.text,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                            //prefixIcon: Icon(Icons.search),
                            border: InputBorder.none,
                            hintStyle: TextStyle(),
                            enabled: false,
                            hintText: (remain+(_custtraVm.lctrsM?.lastb??0)).toString(),
                          ),),
                      ),
                    ],
                  ),
                ),
              );
            }),
            actions: [
              Container(
                width: MediaQuery.of(context).size.width,
                child: Center(
                  child: ElevatedButton(
                      onPressed: () async {
                        showDialog(context: context, builder: (
                            context) {
                          return const Center(
                              child: CircularProgressIndicator());
                        });
                        double p = double.parse(paid.text);
                        var _boxsetVm = Provider.of<CashboxsetVM>(context, listen: false);
                        //print(p > totalprice);
                        if(totalprice == 0){
                          await errorMessage('الفاتورة فارغة');
                        }else if(head.name == null){
                          await errorMessage('يجب عليك إختيار عميل');
                        }else{
                          if(_verticalGroupValue == 'نقدا'){
                            if(p < totalprice){
                              await errorMessage('المبلغ المدفوع أقل من الإجمالي');
                            }else{
                              print('done');
                              print(head.storid);
                              print(account_vm.user?.cashbox??'');
                              var cashboxsetM = await _boxsetVm.findboxbyname(account_vm.user?.cashbox??'');
                              var boxtrlastb = await _boxtraVm.losttSearchBySerial(cashboxsetM?.id??0);
                              var b = _boxtraVm.lostsM?.lastb;
                              await _sohdrVm.CreateInvoice(SohdrM(
                                name: head.name,
                                invno: 0,
                                invdate: DateTime.tryParse(head.date??'')??DateTime.now(),
                                invtot: head.total,
                                salesman: head.salesman,
                                storid: head.storid,
                                vatpo: 0,
                                stat: 0,
                                dayno: 0,
                                discount:0,
                              ));
                              await _custtraVm.CreateCustomertra(CusttraM(
                                id: 0,
                                custid: CustDropDown?.code,
                                disc:"فاتورة مبيعات",
                                credit: paidVal,
                                debit: totalprice,
                                docno: ((_sohdrVm.Invoises?.last.invno ?? 0) + 1),
                                lastb: (remain+(_custtraVm.lctrsM?.lastb??0)),
                                docdate: DateTime.tryParse(head.date??'')??DateTime.now(),
                              ));
                              var mydocno = _boxtraVm.lostsM?.docno;
                              mydocno = (mydocno! + 1);
                              var statusCode = await _boxtraVm.Createrec(
                                  BoxtransM(
                                      boxno: cashboxsetM?.id,
                                      docno: mydocno,
                                      docdate: DateTime.tryParse(head.date??'')??DateTime.now(),
                                      disc: "دفعة ",
                                      credit: paidVal,
                                      debit: 0,
                                      lastb: (b!) + (paidVal??0),
                                      idsys: 0
                                    // custemail: email.text
                                  ));
                              CustDropDown?.custbal = (remain+(_custtraVm.lctrsM?.lastb??0));
                              await CustVm.EditCustomer(CustDropDown?.code??0, CustDropDown??CustomerM());
                              for(ItemsInInv inv in items??[]){
                                await _sodetVm.CreateInvoice(SodetM(
                                  id: 0,
                                  invno: ((_sohdrVm.Invoises?.last.invno ?? 0) + 1),
                                  e_id: inv.barId,
                                  e_disc: inv.itemName,
                                  e_price: inv.price,
                                  e_qty: double.tryParse(inv.qty.toString())??0,
                                  e_tot: inv.totalPrice,
                                  storid: InvoiceHelper.storid,
                                  e_sale: account_vm.user?.username,
                                  e_disco: 0,
                                  e_discprec: 0,
                                  e_tax: 0,
                                ));
                                var ittranlastb = await _ittranVm.losttSearchBySerial(inv.barId.toString(), InvoiceHelper.storid);
                                var d = _ittranVm.lostsM?.bal??0;
                                print("ittrans last bal $d");
                                var a = inv.qty;
                                var c = d - (a??0);
                                try {
                                  var statusCode = await _ittranVm.Createrec(
                                      IttransM(
                                          id: 0,
                                          invno: ((_sohdrVm.Invoises?.last.invno ?? 0) + 1),
                                          itbar: inv.barId.toString(),
                                          itdisc: inv.itemName,
                                          invdate: DateTime.now(),
                                          note: 'فاتورة مبيعات',
                                          sitqty: double.parse(inv.qty.toString()),
                                          itqty: 0,
                                          itpo: 0,
                                          storid: InvoiceHelper.storid,
                                          bal: c
                                      ));
                                } catch (err) {
                                  print(err);
                                }
                                inv.item?.bal = c;
                                await _itStorVM.EditItem(inv.item?.sitemid??0, inv.item ?? ItstorM());
                              }
                              print(paidVal);
                              Navigator.of(context).pop();
                            }
                          }
                          else{
                            print(account_vm.user?.cashbox??'');

                            print(head.storid);
                            print('done');
                            var cashboxsetM = await _boxsetVm.findboxbyname(account_vm.userCash.toString());
                            var boxtrlastb = await _boxtraVm.losttSearchBySerial(cashboxsetM?.id??0);
                            var b = _boxtraVm.lostsM?.lastb;
                            await _sohdrVm.CreateInvoice(SohdrM(
                              name: head.name,
                              invno: 0,
                              invdate: DateTime.tryParse(head.date??'')??DateTime.now(),
                              invtot: head.total,
                              salesman: head.salesman,
                              storid: head.storid,
                              vatpo: 0,
                              stat: 0,
                              dayno: 0,
                              discount:0,
                            ));
                            await _custtraVm.CreateCustomertra(CusttraM(
                              id: 0,
                              custid: CustDropDown?.code,
                              disc:"فاتورة مبيعات",
                              credit: paidVal,
                              debit: totalprice,
                              docno: ((_sohdrVm.Invoises?.last.invno ?? 0) + 1),
                              lastb: (remain+(_custtraVm.lctrsM?.lastb??0)),
                              docdate: DateTime.tryParse(head.date??'')??DateTime.now(),
                            ));
                            var mydocno = _boxtraVm.lostsM?.docno;
                            mydocno = (mydocno! + 1);
                            var statusCode = await _boxtraVm.Createrec(
                                BoxtransM(
                                    boxno: cashboxsetM?.id,
                                    docno: mydocno,
                                    docdate: DateTime.tryParse(head.date??'')??DateTime.now(),
                                    disc: "دفعة ",
                                    credit: paidVal,
                                    debit: 0,
                                    lastb: (b!) + (paidVal??0),
                                    idsys: 0
                                  // custemail: email.text
                                ));
                            CustDropDown?.custbal = (remain+(_custtraVm.lctrsM?.lastb??0));
                            await CustVm.EditCustomer(CustDropDown?.code??0, CustDropDown??CustomerM());
                            for(ItemsInInv inv in items??[]){
                              await _sodetVm.CreateInvoice(SodetM(
                                id: 0,
                                invno: ((_sohdrVm.Invoises?.last.invno ?? 0) + 1),
                                e_id: inv.barId,
                                e_disc: inv.itemName,
                                e_price: inv.price,
                                e_qty: double.tryParse(inv.qty.toString())??0,
                                e_tot: inv.totalPrice,
                                storid: InvoiceHelper.storid,
                                e_sale: account_vm.user?.username,
                                e_disco: 0,
                                e_discprec: 0,
                                e_tax: 0,
                              ));
                              var ittranlastb = await _ittranVm.losttSearchBySerial(inv.barId.toString(), InvoiceHelper.storid);
                              var d = _ittranVm.lostsM?.bal??0;
                              print("ittrans last bal $d");
                              var a = inv.qty;
                              var c = d - (a??0);
                              try {
                                var statusCode = await _ittranVm.Createrec(
                                    IttransM(
                                        id: 0,
                                        invno: ((_sohdrVm.Invoises?.last.invno ?? 0) + 1),
                                        itbar: inv.barId.toString(),
                                        itdisc: inv.itemName,
                                        invdate: DateTime.now(),
                                        note: 'فاتورة مبيعات',
                                        sitqty: double.parse(inv.qty.toString()),
                                        itqty: 0,
                                        itpo: 0,
                                        storid: InvoiceHelper.storid,
                                        bal: c
                                    ));
                              } catch (err) {
                                print(err);
                              }
                              inv.item?.bal = c;
                              await _itStorVM.EditItem(inv.item?.sitemid??0, inv.item ?? ItstorM());
                            }
                            print(paidVal);
                            Navigator.of(context).pop();
                          }
                        }
                        Navigator.pop(context);
                        Navigator.pop(context);
                      },
                      child: Text('حفظ')),
                ),
              )
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    final _custtraVm = Provider.of<CusttrarVM>(context, listen: false);
    var _boxtraVm = Provider.of<BoxtransVM>(context,listen: false);
    var _sohdrVm = Provider.of<SohdrVM>(context,listen: false);
    var account_vm = Provider.of<AccountVM>(context,listen: false);
    var customerVm = Provider.of<CustomerVM>(context, listen: false);
    var _sodetVm = Provider.of<SodetVM>(context, listen: false);
    var _ittranVm = Provider.of<IttranVM>(context, listen: false);
    var _itstorVm = Provider.of<ItstorVM>(context, listen: false);
    head.salesman = account_vm.user?.username;
    var landingInex = 0;
    var currentAppBarText = ['فاتورة مبيعات'];
    return Container(
        color:Color.fromRGBO(240, 240, 240, 1),
        child: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar3(currentAppBarText[landingInex], context, [
            IconButton(onPressed: (){
              setState(() {
                for(MapEntry<int,ItemsInInv> i in SelectedItem.entries){
                  totalprice -= (i.value.totalPrice??0);
                  items?.remove(i.value);
                  SelectedItemColor.removeLast();
                }
                SelectedItemColor.fillRange(0, items!.length,Colors.white);
                SelectedItem.clear();
              });
            }, icon: Icon(Icons.remove)),
          ]),
          bottomNavigationBar: PreferredSize(preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
            child: Container(
              decoration: BoxDecoration(
                border:Border.all(color: Colors.black,style: BorderStyle.solid),
                borderRadius: BorderRadius.circular(10),
                color: Colors.white,
              ),
              child: TextField(
                keyboardType: TextInputType.text,
                textAlign: TextAlign.center,
                decoration: InputDecoration(
                  //prefixIcon: Icon(Icons.search),
                  border: InputBorder.none,
                  hintStyle: TextStyle(),
                  enabled: false,
                  hintText: totalprice.toString(),
                ),),
            ),
          ),
          body: Directionality(
            textDirection: ui.TextDirection.rtl,
            child: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(240, 240, 240, 1),
                ),
                child: SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Column(children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: 50,
                            margin: EdgeInsets.only(top: 15,right: 15,bottom: 15),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(40)
                            ),
                            child: IconButton(onPressed: (){
                              setState(() {
                                viewHeader = viewHeader == false;
                                percent = percent == 0.62? 0.25:0.62;
                              });
                            }, icon: Icon(Icons.view_headline_outlined,color: Colors.black,)),
                          ),
                        ],
                      ),
                      viewHeader == true
                          ? Container(
                        margin: EdgeInsets.fromLTRB(5, 5, 5, 10),
                        padding: EdgeInsets.only(left: 5, right: 5),
                        decoration: BoxDecoration(
                          border: Border.all(
                              style: BorderStyle.solid,
                              color: Colors.black),
                          color: Colors.transparent,
                          borderRadius: BorderRadius.circular(15),
                        ),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                    margin: EdgeInsets.only(right: 10),
                                    child: Text(
                                      "رقم الفاتورة :",
                                      style: TextStyle(fontSize: 20),
                                    )),
                                Container(
                                  width: MediaQuery.of(context).size.width *
                                      0.5,
                                  margin: EdgeInsets.only(
                                      top: 10,
                                      bottom: 10,
                                      left: 10,
                                      right: 10),
                                  padding: EdgeInsets.only(right: 10),
                                  decoration: BoxDecoration(
                                      color: Colors.grey,
                                      borderRadius:
                                      BorderRadius.circular(10)),
                                  child:
                                  SizedBox(height: 45, child: Container(width: MediaQuery.of(context).size.width * 0.5,
                                      child: Center(child: Text(((_sohdrVm.Invoises?.last.invno ?? 0) + 1).toString()??'1',style: TextStyle(fontSize: 20),)))),
                                ),
                              ],
                            ),
                            CustomInputCalender(
                              Icn: Icons.calendar_month_outlined,
                              name: nme,
                              controller: Date,
                              color: clr,
                              onTapDown: (down){
                                setState(() {
                                  clr = Colors.blue;
                                });
                              },
                              onTap: () async{
                                selectedDate = await showDatePicker(context: context, initialDate: DateTime.now(), firstDate: DateTime(1980), lastDate: DateTime.now());
                                print(selectedDate ?? DateTime.now());
                                setState((){
                                  clr = Color.fromRGBO(240, 240, 240, 1);
                                  nme = DateFormat('yyyy-MM-dd').format(selectedDate??DateTime.now());
                                  Date = selectedDate ?? DateTime.now();
                                  head.date = DateFormat('yyyy-MM-dd').format(selectedDate??DateTime.now());
                                });
                              },
                            ),
                            CustomDropDownMenuCustomers(
                                Left: 10,
                                Right: 10,
                                name: "إسم العميل",
                                value: CustDropDown,
                                Width: MediaQuery.of(context).size.width,
                                items: InvoiceHelper.custs?.map((e) {
                                  return DropdownMenuItem<CustomerM?>(
                                    value: e,
                                    child: Container(
                                        width: MediaQuery.of(context).size.width,
                                        child: Center(child: Text(e.custAname??"",style: TextStyle(fontSize: 16),))),
                                  );
                                }).toList(),
                                fun: (CustomerM? val) {
                                  setState(() {
                                    CustDropDown = val;
                                    head.name = CustDropDown?.custAname;
                                    head.storid = InvoiceHelper.storid;
                                    print(CustDropDown?.code);
                                    print(CustDropDown?.custbal);
                                  });
                                },
                                circularity: 10),
                            Container(
                              width: MediaQuery.of(context).size.width,
                              height: 45,
                              margin: EdgeInsets.fromLTRB(10, 10, 10, 10),
                              decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              child: TextField(
                                keyboardType: TextInputType.text,
                                textAlign: TextAlign.center,
                                decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(),
                                  enabled: false,
                                  hintText: InvoiceHelper.user?.storid??"المخزن",
                                ),),
                            ),
                          ],
                        ),
                      )
                          : Container(),
                      Container(
                        height: MediaQuery.of(context).size.height*0.07,
                        width: MediaQuery.of(context).size.width,
                        padding: EdgeInsets.only(left:5,right: 5 ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              flex:1,
                              child: Container(
                                decoration: BoxDecoration(
                                  border:Border.all(color: Colors.black,style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: IconButton(
                                  onPressed: () async {
                                    await DisplayItems();
                                  },
                                  icon: Icon(Icons.add,color: Colors.deepOrange,),),
                              ),
                            ),
                            Expanded(
                              flex:3,
                              child: Container(
                                decoration: BoxDecoration(
                                  border:Border.all(color: Colors.black,style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: const TextField(
                                  keyboardType: TextInputType.text,
                                  textAlign: TextAlign.center,
                                  decoration: InputDecoration(
                                    prefixIcon: Icon(Icons.search),
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(),
                                    hintText: "إدخل إسم المنتج",
                                  ),),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 7),
                        child: SizedBox(
                          height: MediaQuery.of(context).size.height*percent!,
                          child: ListView.builder(
                              itemCount: items?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return GestureDetector(
                                  onTap: (){
                                    setState(() {
                                      Map<int,ItemsInInv> item= {index: items![index]};
                                      //print(item.entries.first.key);
                                      SelectedItemColor[index] == Colors.white? SelectedItem.addEntries(item.entries): SelectedItem.remove(item.entries.first.key);
                                      SelectedItemColor[index] = SelectedItemColor[index] == Colors.white? Colors.blue:Colors.white;
                                    });
                                    print(SelectedItem.length);
                                  },
                                  child: Container(
                                    child: Directionality(
                                      textDirection: ui.TextDirection.rtl,
                                      child: Card(
                                        color: SelectedItemColor[index],
                                        child: Row(
                                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                          children: [
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("إسم المنتج : ",style: TextStyle(fontSize: 15),),
                                                    Container(width: MediaQuery.of(context).size.width*0.25,
                                                        child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                                                            child: Text("${items![index].itemName}"))),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text("سعر الوحدة : ",style: TextStyle(fontSize: 15),),
                                                    Container(width: MediaQuery.of(context).size.width*0.25,
                                                        child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                                                            child: Text("${items![index].price}")
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                            Column(
                                              children: [
                                                Row(
                                                  children: [
                                                    Text("الكمية : ",style: TextStyle(fontSize: 15),),
                                                    Container(width: MediaQuery.of(context).size.width*0.3,
                                                        child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                                                            child: Text("${items![index].qty}")
                                                        )
                                                    ),
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Text("الإجمالي : ",style: TextStyle(fontSize: 15),),
                                                    Container(width: MediaQuery.of(context).size.width*0.3,
                                                        child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                                                            child: Text("${items![index].totalPrice}")
                                                        )
                                                    ),
                                                  ],
                                                ),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                );
                              }),
                        ),
                      )
                    ]),
                  ),
                ),
              ),
              floatingActionButton: FloatingActionButton(onPressed: () async {
                showDialog(context: context, builder: (
                    context) {
                  return const Center(
                      child: CircularProgressIndicator());
                });
                await SavingInvoice(_sohdrVm,customerVm,_custtraVm,_boxtraVm
                    ,account_vm,_sodetVm,_ittranVm,_itstorVm);
                Navigator.pop(context);
              },
                elevation: 20,
                backgroundColor: Colors.white,
                child: Container(
                    child: Icon(Icons.save,color: Colors.blue,)),
              ),
            ),
          ),
        ));
  }
}

class ItemsInInv {
  String? itemName;
  String? itemBarcode;
  String? unit;
  int? qty;
  int? barId;
  double? price;
  double? totalPrice;
  ItstorM? item;
}
class header{
  String? date;
  String? name;
  String? salesman;
  int? storid;
  double? total;

}