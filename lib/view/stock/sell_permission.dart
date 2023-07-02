import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sbterp/widgets/custom_appbar3.dart';
import 'package:sbterp/widgets/customCalender.dart';
import 'package:sbterp/widgets/custom_dropdown.dart';
import 'package:sbterp/widgets/main_container.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'package:flutter_barcode_scanner/flutter_barcode_scanner.dart';
import 'package:number_inc_dec/number_inc_dec.dart';

class SellingPermission extends StatefulWidget {
  const SellingPermission({Key? key}) : super(key: key);

  @override
  State<SellingPermission> createState() => _SellingPermissionState();
}

class _SellingPermissionState extends State<SellingPermission> {
  DateTime? Date;
  String? stockName;
  String? source;
  String? sourceName;
  List<String>? sources = ["عميل", "مورد"];
  String? ItemName = "fixed";
  bool viewHeader = false;
  DateTime? selectedDate;
  Color? clr = Color.fromRGBO(240, 240, 240, 1);
  String? barCodeVal;
  double? percent = 0.7;
  List<ItemsInInv>? items = [];
  TextEditingController qty = TextEditingController();
  List<int> SelectedItem = [];
  List<Color> SelectedItemColor = [];
  String nme = "التاريخ";
  Future barCodeReader() async{
    String? code = await FlutterBarcodeScanner.scanBarcode("#ff0000", 'Cancel', true, ScanMode.BARCODE);
    setState(() {
      barCodeVal = code;
    });
    print("#############################"+barCodeVal.toString());
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
                                    child: Text('الباركود',style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold),))),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height*0.5,
                        width: MediaQuery.of(context).size.width,
                        child: ListView.builder(
                            itemCount: 100,
                            itemBuilder: (BuildContext context, int index) {
                              return GestureDetector(
                                onTap: ()async{
                                  await AddingItem(ItemName.toString() + index.toString(),"${10000220 + index}");
                                },
                                child: Container(
                                  height: 50,
                                  child: Card(
                                    color: Color.fromRGBO(240, 240, 240, 1),
                                    child: Row
                                      (
                                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                      children: [
                                        Directionality(
                                          textDirection: ui.TextDirection.rtl,
                                          child: Container(
                                              width: MediaQuery.of(context).size.width*0.3,
                                              child: SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  child: Text(ItemName.toString() + index.toString(),
                                                    style: TextStyle(fontSize: 16 ),))
                                          ),
                                        ),
                                        Directionality(
                                          textDirection: ui.TextDirection.ltr,
                                          child: Container(
                                              width: MediaQuery.of(context).size.width*0.2,
                                              child: SingleChildScrollView(
                                                  scrollDirection: Axis.horizontal,
                                                  child: Text("${10000220 + index}",
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
  AddingItem(String? name, String? barcode) async {
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
                      // Container(
                      //   margin:
                      //   EdgeInsets.only(top: 2, bottom: 5, left: 5, right: 5),
                      //   child: NumberInputWithIncrementDecrement(
                      //     buttonArrangement: ButtonArrangement.incRightDecLeft,
                      //     incIcon: Icons.add,
                      //     decIcon: Icons.remove,
                      //     incIconDecoration: BoxDecoration(
                      //       border: Border.all(style: BorderStyle.none),
                      //     ),
                      //     decIconDecoration: BoxDecoration(
                      //       border: Border.all(style: BorderStyle.none),
                      //     ),
                      //     numberFieldDecoration:
                      //     InputDecoration(border: InputBorder.none),
                      //     separateIcons: true,
                      //     scaleHeight: 0.9,
                      //     incIconSize: 25,
                      //     decIconSize: 25,
                      //     incIconColor: Colors.black,
                      //     decIconColor: Colors.black,
                      //     widgetContainerDecoration: BoxDecoration(
                      //       color: Colors.white,
                      //       borderRadius: BorderRadius.circular(20),
                      //     ), controller: qty,
                      //   ),
                      // ),
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
                        child: Divider(
                          color: Colors.black,
                          height: 1,
                          thickness: 1,
                          indent: 10,
                          endIndent: 10,
                        ),
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
                        inv.itemBarcode = barcode;
                        inv.qty = int.tryParse(qty.text)??0;
                        inv.unit = "قطعة";
                        setState(() {
                          items?.add(inv);
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

  @override
  Widget build(BuildContext context) {
    var landingInex = 0;
    var currentAppBarText = ['إذن صرف'];
    return MainContainer(
        widget: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar3(currentAppBarText[landingInex], context, [
            IconButton(onPressed: (){
              SelectedItem.sort();
              setState(() {
                for(int i in SelectedItem.reversed){
                  items?.removeAt(i);
                  SelectedItemColor.removeAt(i);
                }
                SelectedItem.clear();
              });
            }, icon: Icon(Icons.remove)),
          ]),
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
                                percent = percent == 0.7? 0.2:0.7;
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
                                      child: Center(child: Text("1",style: TextStyle(fontSize: 20),)))),
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
                                  nme = DateFormat('yyyy-MM-dd')
                                      .format(selectedDate??DateTime.now());
                                  Date = selectedDate ?? DateTime.now();
                                });
                              },
                            ),
                            CustomDropDownMenu(
                                Left: 10,
                                Right: 10,
                                name: "إسم المخزن",
                                value: stockName,
                                Width: MediaQuery.of(context).size.width,
                                items: [],
                                fun: (String? val) {},
                                circularity: 10),
                            CustomDropDownMenu(
                                Left: 10,
                                Right: 10,
                                name: "من جهة",
                                value: source,
                                Width: MediaQuery.of(context).size.width,
                                items: sources?.map((e) {
                                  return DropdownMenuItem(
                                    value: e,
                                    child: Container(
                                        width: MediaQuery.of(context)
                                            .size
                                            .width, // for example
                                        child: Text(
                                          e ,
                                          textAlign: TextAlign.center,
                                          textDirection: ui.TextDirection.rtl,
                                          style: TextStyle(fontSize: 17),
                                        )),
                                  );
                                }).toList(),
                                fun: (String? val) {
                                  setState(() {
                                    source = val;
                                  });
                                },
                                circularity: 10),
                            CustomDropDownMenu(
                                Left: 10,
                                Right: 10,
                                name: source == 'عميل'
                                    ? "إسم العميل"
                                    : source == 'مورد'
                                    ? "إسم المورد"
                                    : "الإسم",
                                value: sourceName,
                                Width: MediaQuery.of(context).size.width,
                                items: [],
                                fun: (String? val) {
                                  setState(() {
                                    source = val;
                                  });
                                },
                                circularity: 10),
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
                                  icon: Icon(Icons.add,color: Color.fromRGBO(60, 20, 12, 1.0),),),
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
                            ),
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
                                    await barCodeReader();
                                  },
                                  icon: Icon(Icons.barcode_reader,color: Color.fromRGBO(60, 20, 12, 1.0),),),
                              ),),
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
                                      SelectedItemColor[index] == Colors.white? SelectedItem.add(index): SelectedItem.remove(index);
                                      SelectedItemColor[index] = SelectedItemColor[index] == Colors.white? Colors.blue:Colors.white;
                                    });
                                    print(SelectedItem.length);
                                  },
                                  child: Container(
                                    child: Card(
                                      color: SelectedItemColor[index],
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                                        children: [
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text("الكود : ",style: TextStyle(fontSize: 15),),
                                                  Container(width: MediaQuery.of(context).size.width*0.4,
                                                      child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                                                          child: Text("${items![index].itemBarcode}"))),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("إسم المنتج : ",style: TextStyle(fontSize: 15),),
                                                  Container(width: MediaQuery.of(context).size.width*0.3,
                                                      child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                                                          child: Text("${items![index].itemName}"))),

                                                ],
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Row(
                                                children: [
                                                  Text("الوحدة : ",style: TextStyle(fontSize: 15),),
                                                  Container(width: MediaQuery.of(context).size.width*0.3,
                                                      child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                                                          child: Text("${items![index].unit}"))),

                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Text("الكمية : ",style: TextStyle(fontSize: 15),),
                                                  Container(width: MediaQuery.of(context).size.width*0.3,
                                                      child: SingleChildScrollView(scrollDirection: Axis.horizontal,
                                                          child: Text("${items![index].qty}"))),

                                                ],
                                              ),
                                            ],
                                          ),


                                        ],
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
              floatingActionButton: FloatingActionButton(onPressed: () {  },
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
}
