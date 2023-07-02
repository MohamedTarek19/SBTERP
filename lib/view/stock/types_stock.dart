
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sbterp/business_logic/model/customer_m.dart';
import 'package:sbterp/business_logic/model/custtra_m.dart';
import 'package:sbterp/business_logic/model/groubitemsetups_m.dart';
import 'package:sbterp/business_logic/model/groubitsubs_m.dart';
import 'package:sbterp/business_logic/model/itstor_m.dart';
import 'package:sbterp/business_logic/model/stortype_m.dart';
import 'package:sbterp/business_logic/view_model/customer_vm.dart';
import 'package:sbterp/business_logic/view_model/custtra_vm.dart';
import 'package:sbterp/business_logic/view_model/groubitemsetups_vm.dart';
import 'package:sbterp/business_logic/view_model/groubitsubs_vm.dart';
import 'package:sbterp/business_logic/view_model/itstor_vm.dart';
import 'package:sbterp/business_logic/view_model/stortype_vm.dart';
import 'package:sbterp/theme/appthrmr.dart';
import 'package:sbterp/view/accounts/account_daily/daily_reports.dart';
import 'package:sbterp/view/solds/sold_home.dart';
import 'package:sbterp/view/solds/solds_helper.dart';
import 'package:sbterp/view/stock/stock_home.dart';
import 'package:sbterp/view/stock/store_type_helper.dart';
import 'package:sbterp/view/stock/sub_groups.dart';
import 'package:sbterp/widgets/custom_appbar2.dart';
import 'package:sbterp/widgets/custom_appbar3.dart';
import 'package:sbterp/widgets/custom_dropdown.dart';
import 'package:sbterp/widgets/custom_dropdownObjects.dart';
import 'package:sbterp/widgets/custom_textfield.dart';
import 'package:sbterp/widgets/main_container.dart';
import 'package:sbterp/utils/navigation.dart';
import 'package:provider/provider.dart';
import 'package:dio/dio.dart';
import 'package:sbterp/widgets/main_container.dart';
import '../../../utils/navigation.dart';
import '../../../widgets/service_widget.dart';
import 'package:sbterp/view/home.dart';
import 'package:sbterp/widgets/cuttom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:sbterp/view/landingpage.dart';
import 'package:number_inc_dec/number_inc_dec.dart';
import 'package:image_picker/image_picker.dart';
import 'package:sbterp/widgets/snackbar.dart';
import '../../business_logic/model/empsetup_m.dart';
import 'package:http_parser/http_parser.dart';

class TypesStock extends StatefulWidget {
  const TypesStock({Key? key}) : super(key: key);

  @override
  State<TypesStock> createState() => _TypesStockState();
}

class _TypesStockState extends State<TypesStock> {
  var landingInex = 0;
  var currentAppBarText = ['مخزن الأصناف'];
  String? value;
  var _Image;
  var imagePicker;
  StortypeM? store;
  List<ItstorM>? filteredItems = [];
  TextEditingController ItemName = TextEditingController();
  TextEditingController barCode = TextEditingController();
  TextEditingController purchasePrice = TextEditingController();
  TextEditingController SellconsumerPrice = TextEditingController();
  TextEditingController SpecialPrice = TextEditingController();
  TextEditingController GomlaPrice = TextEditingController();
  TextEditingController Discount = TextEditingController();
  TextEditingController DiscountPercent = TextEditingController();
  TextEditingController Quantity = TextEditingController();
  ItstorM? Item;

  String? MainGroup;
  String? subGroup;
  bool checkedValue = false;

  // Future UploadImage()async{
  //     var dio = Dio();
  //     var file = File(_Image?.path??" ");
  //     var filename1 = _Image.toString().split('/');
  //     if(_Image != null){
  //       FormData Data = FormData.fromMap({
  //         'image': await MultipartFile.fromFile(file.path,filename: filename1.last.toString(),contentType: new MediaType("image", "png")),
  //       });
  //       var res =await dio.post("https://api.pexels.com/v1/collections",data: Data,onSendProgress: (int sent,int totalSent){
  //         print('$sent  ,  $totalSent');
  //       },
  //       options: Options(
  //           method: 'POST',
  //           headers:{'Authorization':'LbgIYVs9gsfyCXNVtqRSXehgpTzCuK9J8pJ0wQ0LpA05aasgoBUuneQM','Accept': 'application/json','Content-Type': 'application/json' },
  //           responseType: ResponseType.plain// or ResponseType.JSON
  //       )).whenComplete(() {debugPrint("complete:");});
  //
  //     }else{
  //       print("err");
  //     }
  //   }

  void reset(){
    ItemName = TextEditingController();
    barCode = TextEditingController();
    purchasePrice = TextEditingController();
    SellconsumerPrice = TextEditingController();
    SpecialPrice = TextEditingController();
    GomlaPrice = TextEditingController();
    Discount = TextEditingController();
    DiscountPercent = TextEditingController();
    Quantity = TextEditingController();
    MainGroup = null;
    subGroup= null;
    checkedValue = false;
  }
  void assign(int idx){
    print(filteredItems![idx].sitemqty.toString());
    ItemName.text =           filteredItems![idx].sitemdisc??'';
    barCode.text =            filteredItems![idx].sitbarcode??'';
    purchasePrice.text =      filteredItems![idx].itpo.toString();
    SellconsumerPrice.text =  filteredItems![idx].itso.toString();
    SpecialPrice.text =       filteredItems![idx].itsos.toString();
    GomlaPrice.text =         filteredItems![idx].itsop.toString();
    Discount.text =           filteredItems![idx].disc.toString();
    DiscountPercent.text =    filteredItems![idx].discprec.toString();
    Quantity.text =           filteredItems![idx].sitemqty.toString();
    MainGroup =               filteredItems![idx].gitemid!.trim();
    subGroup=                 filteredItems![idx].gitemsubid!.trim();
    checkedValue =           (filteredItems![idx].itservice??0) == 1;
  }
  void GetValues(int id){
    Item = null;
    Item = ItstorM(
      sitemid: id,
      sitemdisc: ItemName.text,
      sitbarcode: barCode.text,
      itso: double.tryParse(SellconsumerPrice.text),
      gitemid: MainGroup,
      storid: store!.id,
      bal: double.tryParse(Quantity.text)??0,
      disc: double.tryParse(Discount.text),
      discprec: double.tryParse(DiscountPercent.text),
      gitemsubid: subGroup,
      //imgpat: _Image.toString(),
      itpo: double.tryParse(purchasePrice.text),
      itservice: checkedValue? 1:0,
      itsop: double.tryParse(GomlaPrice.text),
      itsos: double.tryParse(SpecialPrice.text),
      sitemqty: int.tryParse(Quantity.text) ?? 0,
      sitemunit: "قطعة",
    );
  }


  void FilterSubGroups(GroubItSubsVM _GroupSubs_Vm){
    StorTypeHelper.TempSubGroups!.clear();
    for(GroubItSubsM val in _GroupSubs_Vm.groups??[]){
      if(val.gitemmain == MainGroup){
        StorTypeHelper.TempSubGroups!.add(val);
      }
    }
  }
  void FilterItems(){
    filteredItems!.clear();
    for(ItstorM val in StorTypeHelper.StoreItems??[]){
      if(val.storid == store!.id){
        filteredItems!.add(val);
      }
    }
  }
  AddingMessage(GroubItSubsVM _GroupSubs_Vm,ItstorVM _Itstor_Vm) async {
    reset();
    _Image = null;
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
                  textDirection: TextDirection.rtl,
                )),
            content: StatefulBuilder(builder: (context, setState) {

              return SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextField(
                        icon: Icons.library_books_outlined,
                        controller: ItemName,
                        name: 'اسم الصنف'),
                    CustomDropDownMenu(
                        Width: MediaQuery.of(context).size.width,
                        value: MainGroup,
                        fun: (String? val) {
                          subGroup = null;
                          setState(() {
                            MainGroup = val.toString();
                            FilterSubGroups(_GroupSubs_Vm);
                          });
                        },
                        items: StorTypeHelper.MainGroups?.map((item) {
                          return DropdownMenuItem(
                            value: item.gitemdisc ?? '',
                            child: Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // for example
                                child: Text(
                                  item.gitemdisc ?? '',
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 17),
                                )),
                          );
                        }).toList(),
                        Left: 0,
                        Right: 0,
                        name: 'القسم الرئيسي'),
                    CustomDropDownMenu(
                        Width: MediaQuery.of(context).size.width,
                        value: subGroup,
                        fun: (String? val) {
                          setState(() {
                            subGroup = val.toString();
                          });
                        },
                        items: StorTypeHelper.TempSubGroups?.map((item) {
                          return DropdownMenuItem(
                            value: item.gitemsub ?? '',
                            child: Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // for example
                                child: Text(
                                  item.gitemsub ?? '',
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 17),
                                )),
                          );
                        }).toList(),
                        Left: 0,
                        Right: 0,
                        name: 'القسم الفرعي'),
                    CustomTextField(
                        icon: Icons.barcode_reader,
                        controller: barCode,
                        name: 'الباركود'),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20)
                      ),
                      child: Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.black),
                        child: CheckboxListTile(
                          dense: true,
                          visualDensity: VisualDensity(vertical: 0),
                          activeColor: Colors.white,
                          checkColor: Colors.purple,
                          shape: RoundedRectangleBorder( //<-- SEE HERE
                            borderRadius: BorderRadius.circular(20),
                          ),
                          tileColor: Colors.white,
                          title: Text("صنف خدمة",textAlign: TextAlign.center ,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),textDirection: TextDirection.rtl,),
                          value: checkedValue,
                          onChanged: (newValue) {
                            setState(() {
                              checkedValue = newValue??false;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.trailing,  //  <-- leading Checkbox
                        ),
                      ),
                    ),
                    Container(
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
                        //separateIcons: true,
                        scaleHeight: 0.9,
                        incIconSize: 25,
                        decIconSize: 25,
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
                        incDecFactor: 0.1,
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
                        ),
                        controller: Quantity,
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
                    SizedBox(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            setState(() async{
                              try {
                                print('img2');
                                final image = await ImagePicker().pickImage(
                                    source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);
                                if (image == null) return;
                                final imageTemp = File(image.path);
                                print(imageTemp);
                                setState((){ _Image = imageTemp;
                                });
                              } on PlatformException catch (e) {
                                print('Failed to pick image: $e');
                              }
                            });
                          },
                          child: Container(
                            margin: EdgeInsets.only(top: 0),
                            height: 200,
                            width: MediaQuery.of(context).size.width,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.black,style: BorderStyle.solid),
                              borderRadius: BorderRadius.circular(20)
                            ),
                            child:Center(
                              child: _Image != null
                                  ? ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                    child: Image.file(
                                _Image,
                                width: MediaQuery.of(context).size.width,
                                height: 200,
                                fit: BoxFit.fitWidth,
                              ),
                                  ) : Icon(Icons.camera_alt_outlined),
                            )
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
            actions: [

              ElevatedButton(
                  onPressed: () async {
                    showDialog(context: context, builder: (context) {return const Center(child: CircularProgressIndicator());});
                    ItstorM item = ItstorM(
                        sitemid: 0,
                        sitemdisc: ItemName.text,
                        sitbarcode: barCode.text == ''? ((StorTypeHelper.StoreItems!.last.sitemid??0)+10000+1).toString() : barCode.text,
                        itso: double.tryParse(SellconsumerPrice.text),
                        gitemid: MainGroup,
                        storid: store!.id,
                        bal: double.tryParse(Quantity.text),
                        disc: double.tryParse(Discount.text),
                        discprec: double.tryParse(DiscountPercent.text),
                        gitemsubid: subGroup,
                        //imgpat: _Image.toString(),
                        itpo: double.tryParse(purchasePrice.text),
                        itservice: checkedValue? 1:0,
                        itsop: double.tryParse(GomlaPrice.text),
                        itsos: double.tryParse(SpecialPrice.text),
                        sitemqty: int.tryParse(Quantity.text),
                        sitemunit: "قطعة",
                    );
                    print("${item.sitemid}\n${item.gitemsubid}\n${item.gitemid}\n${item.sitemqty}\n${item.discprec}\n${item.disc}\n"
                        "${item.itsop}\n${item.itso}\n${item.itsos}\n${item.itpo}\n${item.sitbarcode}\n${item.sitemdisc}\n${item.storid}\n"
                        "${item.sitemunit}\n${item.itservice}\n${item.bal}\n");
                    await _Itstor_Vm.CreateItem(item);
                    await _Itstor_Vm.GetAllItems();
                    setState(() {
                      StorTypeHelper.StoreItems = _Itstor_Vm.items;
                      FilterItems();
                    });
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

  RemovingRecord(int id,ItstorVM _Itstor_Vm,ItstorM item) async {
    print(id);
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            title: Container(
                child: Text(
                  'هل تريد حذف هذا الصنف',
                  style: TextStyle(color: Colors.black, fontSize: 17),
                  textDirection: TextDirection.rtl,
                )),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    showDialog(context: context, builder: (context) {return const Center(child: CircularProgressIndicator());});
                    await _Itstor_Vm.deleteItem(id);
                    setState(() {
                      filteredItems!.remove(item);
                      StorTypeHelper.StoreItems!.remove(item);
                      FilterItems();
                    });
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text('حذف')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('رجوع'))
            ],
          );
        });
  }

  EditRecord(int id,GroubItSubsVM _GroupSubs_Vm,ItstorVM _Itstor_Vm,int idx) async {
    reset();
    assign(idx);
    FilterSubGroups(_GroupSubs_Vm);
    print(MainGroup);
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
                  'تعديل',
                  style: TextStyle(color: Colors.black, fontSize: 17),
                  textDirection: TextDirection.rtl,
                )),
            content:StatefulBuilder(builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextField(
                        icon: Icons.library_books_outlined,
                        controller: ItemName,
                        name: 'اسم الصنف'),
                    CustomDropDownMenu(
                        Width: MediaQuery.of(context).size.width,
                        value: int.tryParse(MainGroup??'0') != null? null:MainGroup,
                        fun: (String? val) {
                          subGroup = null;
                          setState(() {
                            MainGroup = val.toString();
                            FilterSubGroups(_GroupSubs_Vm);
                          });
                        },
                        items: StorTypeHelper.MainGroups?.map((item) {
                          return DropdownMenuItem(
                            value: item.gitemdisc ?? '',
                            child: Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // for example
                                child: Text(
                                  item.gitemdisc ?? '',
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 17),
                                )),
                          );
                        }).toList(),
                        Left: 0,
                        Right: 0,
                        name: 'القسم الرئيسي'),
                    CustomDropDownMenu(
                        Width: MediaQuery.of(context).size.width,
                        value: int.tryParse(subGroup??'0') != null? null:subGroup,
                        fun: (String? val) {
                          setState(() {
                            subGroup = val.toString();
                          });
                        },
                        items: StorTypeHelper.TempSubGroups?.map((item) {
                          return DropdownMenuItem(
                            value: item.gitemsub ?? '',
                            child: Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // for example
                                child: Text(
                                  item.gitemsub ?? '',
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 17),
                                )),
                          );
                        }).toList(),
                        Left: 0,
                        Right: 0,
                        name: 'القسم الفرعي'),
                    CustomTextField(
                        icon: Icons.barcode_reader,
                        controller: barCode,
                        name: 'الباركود'),
                    Container(
                      margin: EdgeInsets.only(top: 10),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Theme(
                        data: ThemeData(unselectedWidgetColor: Colors.black),
                        child: CheckboxListTile(
                          dense: true,
                          visualDensity: VisualDensity(vertical: 0),
                          activeColor: Colors.white,
                          checkColor: Colors.purple,
                          shape: RoundedRectangleBorder( //<-- SEE HERE
                            borderRadius: BorderRadius.circular(20),
                          ),
                          tileColor: Colors.white,
                          title: Text("صنف خدمة",textAlign: TextAlign.center ,style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold),textDirection: TextDirection.rtl,),
                          value: checkedValue,
                          onChanged: (newValue) {
                            setState(() {
                              checkedValue = newValue??false;
                            });
                          },
                          controlAffinity: ListTileControlAffinity.trailing,  //  <-- leading Checkbox
                        ),
                      ),
                    ),
                    Container(
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
                        initialValue: double.parse(purchasePrice.text),
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
                        initialValue: double.parse(SellconsumerPrice.text),
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
                        initialValue: double.parse(SpecialPrice.text),
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
                        initialValue: double.parse(GomlaPrice.text),
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
                        initialValue: double.parse(Discount.text),
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
                        initialValue: double.parse(DiscountPercent.text),
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
                        incDecFactor: 0.1,
                        max: 1,
                        min: 0,
                        scaleHeight: 0.9,
                        incIconSize: 25,
                        decIconSize: 25,
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
                        initialValue: double.tryParse(Quantity.text)??0,
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
                        ),
                        controller: Quantity,
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
                    SizedBox(
                      height: 250,
                      width: MediaQuery.of(context).size.width,
                      child: Center(
                        child: GestureDetector(
                          onTap: () async {
                            setState(() async{
                              try {
                                print('img2');
                                final image = await ImagePicker().pickImage(
                                    source: ImageSource.camera, preferredCameraDevice: CameraDevice.rear);
                                if (image == null) return;
                                final imageTemp = File(image.path);
                                print(imageTemp);
                                setState((){ _Image = imageTemp;
                                });
                              } on PlatformException catch (e) {
                                print('Failed to pick image: $e');
                              }
                            });
                          },
                          child: Container(
                              margin: EdgeInsets.only(top: 0),
                              height: 200,
                              width: MediaQuery.of(context).size.width,
                              decoration: BoxDecoration(
                                  border: Border.all(color: Colors.black,style: BorderStyle.solid),
                                  borderRadius: BorderRadius.circular(20)
                              ),
                              child:Center(
                                child: _Image != null
                                    ? ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    _Image,
                                    width: MediaQuery.of(context).size.width,
                                    height: 200,
                                    fit: BoxFit.fitWidth,
                                  ),
                                ) : Icon(Icons.camera_alt_outlined),
                              )
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              );
            }),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    showDialog(context: context, builder: (context) {return const Center(child: CircularProgressIndicator());});
                    GetValues(id);
                    await _Itstor_Vm.EditItem(id, Item!);
                    setState(() {
                      filteredItems![idx] = Item!;
                    });
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text('تعديل')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('رجوع'))
            ],
          );
        });
  }

  PerviewRecord(int idx) {
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
                  'تعديل',
                  style: TextStyle(color: Colors.black, fontSize: 17),
                  textDirection: TextDirection.rtl,
                )),
            content:StatefulBuilder(builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
                  children: [

                  ],
                ),
              );
            }),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('رجوع'))
            ],
          );
        });
  }


  @override
  Widget build(BuildContext context) {
    var _GroupSubs_Vm = Provider.of<GroubItSubsVM>(context,listen: false);
    var _Itstor_Vm = Provider.of<ItstorVM>(context,listen: false);
    return MainContainer(
        widget: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar3(currentAppBarText[landingInex], context, [
            IconButton(
                onPressed: () async {
                  if(store == null){
                    CSnackBar.showSnackBar(context, "يجب عليك اختيار مخزن اولا");
                  }else{
                    await AddingMessage(_GroupSubs_Vm,_Itstor_Vm);
                  }
                  // await AddingMessage(_groupItem_Vm);
                },
                icon: Icon(Icons.add)),
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          ],
          bottombar: PreferredSize(
              preferredSize: Size.fromHeight(MediaQuery.of(context).size.height * 0.07),
            child: Container(
              child: CustomDropDownMenuForObjects(
                  Width: MediaQuery.of(context).size.width,
                  value: store,
                  fun: (StortypeM? val) {
                    setState(() {
                      store = val;
                      FilterItems();
                      print(val!.id);
                    });
                  },
                  items: StorTypeHelper.stores?.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Container(
                          width: MediaQuery.of(context)
                              .size
                              .width, // for example
                          child: Text(
                            item.stordisc ?? 'فارغ',
                            textAlign: TextAlign.center,
                            textDirection: TextDirection.rtl,
                            style: TextStyle(fontSize: 17),
                          )),
                    );
                  }).toList(),
                  Left: 0,
                  Right: 0,
                  name: 'المخزن'),

            ),
          ),),
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
                                  "اسم الصنف",
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
                            height: MediaQuery.of(context).size.height * 0.77,
                            child: ListView.builder(
                              itemCount: filteredItems?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ListTile(
                                            title: Row(
                                              mainAxisAlignment:
                                              MainAxisAlignment.center,
                                              children: [
                                                Text(filteredItems![index].sitemdisc ?? 'فارغ'),
                                              ],
                                            ),
                                            trailing: Icon(Icons.list),
                                            leading: SizedBox(
                                              width: 96,
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () async {
                                                      await EditRecord(filteredItems![index].sitemid??0,_GroupSubs_Vm,_Itstor_Vm,index);
                                                    },
                                                    icon: Icon(
                                                      Icons.edit,
                                                      size: 20,
                                                    ),
                                                    color: Colors.grey,
                                                  ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      await RemovingRecord(filteredItems![index].sitemid??0, _Itstor_Vm,filteredItems![index]);
                                                    },
                                                    icon: Icon(Icons.cancel_outlined,
                                                        size: 20),
                                                    color: Colors.red,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: (){

                                            },
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        Divider(
                                          height: 2,
                                          indent: 1,
                                          endIndent: 1,
                                          thickness: 1,
                                        ),
                                      ],
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
