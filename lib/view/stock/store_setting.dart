import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/stortype_m.dart';
import 'package:sbterp/business_logic/view_model/stortype_vm.dart';
import 'package:sbterp/theme/appthrmr.dart';
import 'package:sbterp/view/accounts/account_daily/daily_reports.dart';
import 'package:sbterp/view/solds/sold_home.dart';
import 'package:sbterp/view/stock/stock_home.dart';
import 'package:sbterp/view/stock/store_type_helper.dart';
import 'package:sbterp/widgets/custom_appbar2.dart';
import 'package:sbterp/widgets/custom_appbar3.dart';
import 'package:sbterp/widgets/main_container.dart';
import 'package:sbterp/utils/navigation.dart';

import 'package:provider/provider.dart';
import 'package:sbterp/widgets/main_container.dart';
import '../../../utils/navigation.dart';
import '../../../widgets/service_widget.dart';
import 'package:sbterp/view/home.dart';
import 'package:sbterp/widgets/cuttom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:sbterp/view/landingpage.dart';

class StoreSettings extends StatefulWidget {
  const StoreSettings({Key? key}) : super(key: key);

  @override
  State<StoreSettings> createState() => _StoreSettingsState();
}

class _StoreSettingsState extends State<StoreSettings> {
  var landingInex = 0;
  var currentAppBarText = ['إعداد المخازن'];
  TextEditingController TController = TextEditingController();

  alert() async {
    return showDialog(
        context: context,
        builder: (context) {
          var _StorType_Vm = Provider.of<StortypeVM>(context,listen: false);

          return AlertDialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            title: Container(
                child: Text(
              'إضافة مخزن',
              style: TextStyle(color: Colors.black, fontSize: 17),
              textDirection: TextDirection.rtl,
            )),
            content: TextField(
              controller: TController,
              textDirection: TextDirection.rtl,
            ),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    StortypeM newStore = StortypeM();
                    showDialog(context: context, builder: (context) {return const Center(child: CircularProgressIndicator());});
                    newStore.stordisc = TController.text;
                    await _StorType_Vm.AddStore(newStore);
                    setState(() {
                      StorTypeHelper.stores?.add(newStore);
                    });
                    TController.text = '';
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text('حفظ')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('إلغاء'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    return MainContainer(
        widget: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar3(currentAppBarText[landingInex], context, [
        IconButton(
            onPressed: () async {
              await alert();
            },
            icon: Icon(Icons.add)),
        IconButton(onPressed: () {}, icon: Icon(Icons.search)),
      ]),
      body: Scaffold(
          resizeToAvoidBottomInset: false,
          body: Stack(children: [
            SizedBox(
              height: MediaQuery.of(context).size.height,
              child: SingleChildScrollView(
                child: Container(
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Container(
                        color: Colors.grey,
                        height: 40,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              "اسم المخزن",
                              textDirection: TextDirection.rtl,
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 19,
                                  fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.8,
                        child: ListView.builder(
                          itemCount: StorTypeHelper.stores?.length ?? 0,
                          itemBuilder: (BuildContext context, int index) {
                            return Column(
                              children: [
                                ListTile(
                                  title: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Text(StorTypeHelper.stores![index].stordisc ??
                                          'فارغ'),
                                    ],
                                  ),
                                  trailing: Icon(Icons.list),
                                  leading: IconButton(
                                    onPressed: (){},
                                    icon: Icon(Icons.cancel_outlined),
                                    color: Colors.red,
                                  ),
                                ),
                                Divider(
                                  height: 2,
                                  indent: 1,
                                  endIndent: 1,
                                  thickness: 1,
                                )
                              ],
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ])),
    ));
  }
}

/*
*
* Container(
                      margin: EdgeInsets.only(top: 15),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text("سعر شراء")),
                    Container(
                      margin:
                      EdgeInsets.only(top: 2, bottom: 2, left: 5, right: 5),
                      child: NumberInputWithIncrementDecrement(
                        buttonArrangement: ButtonArrangement.leftEnd,
                        numberFieldDecoration:
                        InputDecoration(border: InputBorder.none),
                        initialValue:double.tryParse(purchasePrice.text.toString())??0,
                        separateIcons: true,
                        scaleHeight: 0.9,
                        incIconSize: 15,
                        decIconSize: 15,
                        incIconColor: Colors.black,
                        decIconColor: Colors.black,
                        widgetContainerDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        controller: purchasePrice,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text("سعر بيع مستهلك")),
                    Container(
                      margin:
                      EdgeInsets.only(top: 2, bottom: 5, left: 5, right: 5),
                      child: NumberInputWithIncrementDecrement(
                        buttonArrangement: ButtonArrangement.leftEnd,
                          initialValue:double.tryParse(SellconsumerPrice.text.toString())??0,
                        numberFieldDecoration:
                        InputDecoration(border: InputBorder.none),
                        separateIcons: true,
                        scaleHeight: 0.9,
                        incIconSize: 15,
                        decIconSize: 15,
                        incIconColor: Colors.black,
                        decIconColor: Colors.black,
                        widgetContainerDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        controller: SellconsumerPrice,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text("سعر خاص")),
                    Container(
                      margin:
                      EdgeInsets.only(top: 2, bottom: 5, left: 5, right: 5),
                      child: NumberInputWithIncrementDecrement(
                        initialValue:double.tryParse(SpecialPrice.text.toString())??0,

                        buttonArrangement: ButtonArrangement.leftEnd,
                        numberFieldDecoration:
                        InputDecoration(border: InputBorder.none),
                        separateIcons: true,
                        scaleHeight: 0.9,
                        incIconSize: 15,
                        decIconSize: 15,
                        incIconColor: Colors.black,
                        decIconColor: Colors.black,
                        widgetContainerDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        controller: SpecialPrice,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text("سعر جملة")),
                    Container(
                      margin:
                      EdgeInsets.only(top: 2, bottom: 5, left: 5, right: 5),
                      child: NumberInputWithIncrementDecrement(
                        buttonArrangement: ButtonArrangement.leftEnd,
                        initialValue:double.tryParse(GomlaPrice.text.toString())??0,

                        numberFieldDecoration:
                        InputDecoration(border: InputBorder.none),
                        separateIcons: true,
                        scaleHeight: 0.9,
                        incIconSize: 15,
                        decIconSize: 15,
                        incIconColor: Colors.black,
                        decIconColor: Colors.black,
                        widgetContainerDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        controller: GomlaPrice,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text("التخفيض")),
                    Container(
                      margin:
                      EdgeInsets.only(top: 2, bottom: 5, left: 5, right: 5),
                      child: NumberInputWithIncrementDecrement(
                        buttonArrangement: ButtonArrangement.leftEnd,
                        initialValue:double.tryParse(Discount.text.toString())??0,

                        numberFieldDecoration:
                        InputDecoration(border: InputBorder.none),
                        separateIcons: true,
                        scaleHeight: 0.9,
                        incIconSize: 15,
                        decIconSize: 15,
                        incIconColor: Colors.black,
                        decIconColor: Colors.black,
                        widgetContainerDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        controller: Discount,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text("تخفيض بالنسبة")),
                    Container(
                      margin:
                      EdgeInsets.only(top: 2, bottom: 5, left: 5, right: 5),
                      child: NumberInputWithIncrementDecrement(
                        buttonArrangement: ButtonArrangement.leftEnd,
                        initialValue:double.tryParse(DiscountPercent.text.toString())??0,

                        numberFieldDecoration:
                        InputDecoration(border: InputBorder.none),
                        separateIcons: true,
                        incDecFactor: 0.1,
                        max: 1,
                        min: 0,
                        scaleHeight: 0.9,
                        incIconSize: 15,
                        decIconSize: 15,
                        incIconColor: Colors.black,
                        decIconColor: Colors.black,
                        widgetContainerDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        controller: DiscountPercent,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text("الكمية")),
                    Container(
                      margin:
                      EdgeInsets.only(top: 2, bottom: 5, left: 5, right: 5),
                      child: NumberInputWithIncrementDecrement(
                        buttonArrangement: ButtonArrangement.leftEnd,
                        initialValue:double.tryParse(Quantity.text.toString())??0,

                        numberFieldDecoration:
                        InputDecoration(border: InputBorder.none),
                        separateIcons: true,
                        scaleHeight: 0.9,
                        incIconSize: 15,
                        decIconSize: 15,
                        incIconColor: Colors.black,
                        decIconColor: Colors.black,
                        widgetContainerDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        controller: Quantity,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text("السعر المطلوب")),
                    Container(
                      margin:
                      EdgeInsets.only(top: 2, bottom: 5, left: 5, right: 5),
                      child: NumberInputWithIncrementDecrement(
                        buttonArrangement: ButtonArrangement.leftEnd,
                        initialValue:double.tryParse(wantedPrice.text.toString())??0,

                        numberFieldDecoration:
                        InputDecoration(border: InputBorder.none),
                        separateIcons: true,
                        scaleHeight: 0.9,
                        incIconSize: 15,
                        decIconSize: 15,
                        incIconColor: Colors.black,
                        decIconColor: Colors.black,
                        widgetContainerDecoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(20),
                        ),
                        controller: wantedPrice,
                      ),
                    ),
                    Container(
                      margin: EdgeInsets.only(bottom: 10),
                      child: Divider(
                        height: 1,
                        thickness: 1,
                        indent: 10,
                        endIndent: 10,
                      ),
                    ),
*
*
*
* */