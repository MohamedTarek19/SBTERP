import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/groubitemsetups_m.dart';
import 'package:sbterp/business_logic/model/groubitsubs_m.dart';
import 'package:sbterp/business_logic/model/stortype_m.dart';
import 'package:sbterp/business_logic/model/supsetups_m.dart';
import 'package:sbterp/business_logic/view_model/groubitemsetups_vm.dart';
import 'package:sbterp/business_logic/view_model/groubitsubs_vm.dart';
import 'package:sbterp/business_logic/view_model/stortype_vm.dart';
import 'package:sbterp/business_logic/view_model/subsetups_vm.dart';
import 'package:sbterp/theme/appthrmr.dart';
import 'package:sbterp/view/accounts/account_daily/daily_reports.dart';
import 'package:sbterp/view/purchases/purchases_helper.dart';
import 'package:sbterp/view/solds/sold_home.dart';
import 'package:sbterp/view/stock/stock_home.dart';
import 'package:sbterp/view/stock/store_type_helper.dart';
import 'package:sbterp/widgets/custom_appbar2.dart';
import 'package:sbterp/widgets/custom_appbar3.dart';
import 'package:sbterp/widgets/custom_dropdown.dart';
import 'package:sbterp/widgets/custom_textfield.dart';
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
import 'package:number_inc_dec/number_inc_dec.dart';

class SuppliersSettings extends StatefulWidget {
  const SuppliersSettings({Key? key}) : super(key: key);

  @override
  State<SuppliersSettings> createState() => _SuppliersSettingsState();
}

class _SuppliersSettingsState extends State<SuppliersSettings> {
  var landingInex = 0;
  var currentAppBarText = ['قائمة إعداد الموردين'];
  TextEditingController SuppName = TextEditingController();
  TextEditingController SuppPhone = TextEditingController();
  TextEditingController Telephone = TextEditingController();
  TextEditingController EmailAddress = TextEditingController();
  TextEditingController HomeAddress = TextEditingController();
  TextEditingController Pal = TextEditingController();
  void TextEditorReset(){
    SuppName = TextEditingController();
    SuppPhone = TextEditingController();
    Telephone = TextEditingController();
    EmailAddress = TextEditingController();
    HomeAddress = TextEditingController();
    Pal = TextEditingController();
  }

  AddingMessage(SupSetupsVM _subSetup_Vm) async {
    TextEditorReset();
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
                  'إضافة مورد',
                  style: TextStyle(color: Colors.black, fontSize: 17),
                  textDirection: TextDirection.rtl,
                )),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextField(icon: Icons.person,controller: SuppName,name:'الإسم'),
                  CustomTextField(icon: Icons.location_on_outlined,controller: HomeAddress,name:'العنوان'),
                  CustomTextField(icon: Icons.contact_phone,controller: Telephone,name:'رقم الخط الأرضي',type: TextInputType.phone),
                  CustomTextField(icon: Icons.phone,controller: SuppPhone,name:'رقم الجوال',type: TextInputType.phone),
                  CustomTextField(icon: Icons.email_outlined,controller: EmailAddress,name:'البريد الإلكتروني',type: TextInputType.emailAddress),
                  CustomTextField(icon: Icons.numbers,controller: Pal,name:'الرصيد',type:TextInputType.number),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    int id = int.parse(PurchasesHelper.Sppliers!.last.code.toString());
                    showDialog(context: context, builder: (context) {return const Center(child: CircularProgressIndicator());});
                    SubSetupsM supplier = SubSetupsM(
                      supAname: SuppName.text,
                      supaddres1: HomeAddress.text,
                      supemail: EmailAddress.text,
                      supmobile: SuppPhone.text,
                      supbal: double.parse(Pal.text),
                      supfbal: double.parse(Pal.text),
                      supaccno: '',
                      code: id += 1,
                      compid: 0,
                      supaddres2: '',
                      suptel1: Telephone.text,
                    );
                    await _subSetup_Vm.CreateSupplier(supplier);
                    setState(() {
                      PurchasesHelper.Sppliers!.add(supplier);
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
  RemovingRecord(int id,SupSetupsVM _subSetup_Vm,int idx) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            title: Container(
                child: Text(
                  'هل تريد حذف هذا القسم',
                  style: TextStyle(color: Colors.black, fontSize: 17),
                  textDirection: TextDirection.rtl,
                )),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    showDialog(context: context, builder: (context) {return const Center(child: CircularProgressIndicator());});
                    await _subSetup_Vm.DeleteSupplier(id);
                    setState(() {
                      PurchasesHelper.Sppliers!.removeAt(idx);
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
  EditRecord(int id,SupSetupsVM _subSetup_Vm,int idx) async {
    TextEditorReset();
    SuppName.text = PurchasesHelper.Sppliers![idx].supAname??'';
    HomeAddress.text =PurchasesHelper.Sppliers![idx].supaddres1??'';
    Telephone.text =PurchasesHelper.Sppliers![idx].suptel1??'';
    SuppPhone.text = PurchasesHelper.Sppliers![idx].supmobile??'';
    EmailAddress.text = PurchasesHelper.Sppliers![idx].supemail??'';
    Pal.text = PurchasesHelper.Sppliers![idx].supbal.toString();
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
            content: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextField(icon: Icons.person,controller: SuppName,name:PurchasesHelper.Sppliers![idx].supAname??''),
                  CustomTextField(icon: Icons.location_on_outlined,controller: HomeAddress,name:PurchasesHelper.Sppliers![idx].supaddres1??''),
                  CustomTextField(icon: Icons.contact_phone,controller: Telephone,name:PurchasesHelper.Sppliers![idx].suptel1??'',type: TextInputType.phone),
                  CustomTextField(icon: Icons.phone,controller: SuppPhone,name:PurchasesHelper.Sppliers![idx].supmobile??'',type: TextInputType.phone),
                  CustomTextField(icon: Icons.email_outlined,controller: EmailAddress,name:PurchasesHelper.Sppliers![idx].supemail??'',type: TextInputType.emailAddress),
                  CustomTextField(icon: Icons.numbers,controller: Pal,name:PurchasesHelper.Sppliers![idx].supbal.toString(),type:TextInputType.number),
                ],
              ),
            ),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    showDialog(context: context, builder: (context) {return const Center(child: CircularProgressIndicator());});
                    setState(() {
                      PurchasesHelper.Sppliers![idx].supAname = SuppName.text;
                      PurchasesHelper.Sppliers![idx].supbal = double.parse(Pal.text);
                      PurchasesHelper.Sppliers![idx].supemail = EmailAddress.text;
                      PurchasesHelper.Sppliers![idx].supmobile = SuppPhone.text;
                      PurchasesHelper.Sppliers![idx].suptel1 = Telephone.text;
                      PurchasesHelper.Sppliers![idx].supaddres1 = HomeAddress.text;
                      PurchasesHelper.Sppliers![idx].supaccno = '';
                      PurchasesHelper.Sppliers![idx].supaddres2 = '';

                    });
                    await _subSetup_Vm.EditSupplier(id, PurchasesHelper.Sppliers![idx]);
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
  perviewRecord(int idx) async {
    TextEditorReset();
    SuppName.text = PurchasesHelper.Sppliers![idx].supAname??'';
    HomeAddress.text =PurchasesHelper.Sppliers![idx].supaddres1??'';
    Telephone.text =PurchasesHelper.Sppliers![idx].suptel1??'';
    SuppPhone.text = PurchasesHelper.Sppliers![idx].supmobile??'';
    EmailAddress.text = PurchasesHelper.Sppliers![idx].supemail??'';
    Pal.text = PurchasesHelper.Sppliers![idx].supbal.toString();
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
            content: SingleChildScrollView(
              child: Column(
                children: [
                  CustomTextField(icon: Icons.person,controller: SuppName,name:PurchasesHelper.Sppliers![idx].supAname??''),
                  CustomTextField(icon: Icons.location_on_outlined,controller: HomeAddress,name:PurchasesHelper.Sppliers![idx].supaddres1??''),
                  CustomTextField(icon: Icons.contact_phone,controller: Telephone,name:PurchasesHelper.Sppliers![idx].suptel1??'',type: TextInputType.phone),
                  CustomTextField(icon: Icons.phone,controller: SuppPhone,name:PurchasesHelper.Sppliers![idx].supmobile??'',type: TextInputType.phone),
                  CustomTextField(icon: Icons.email_outlined,controller: EmailAddress,name:PurchasesHelper.Sppliers![idx].supemail??'',type: TextInputType.emailAddress),
                  CustomTextField(icon: Icons.numbers,controller: Pal,name:PurchasesHelper.Sppliers![idx].supbal.toString(),type:TextInputType.number),
                ],
              ),
            ),
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
    var _subSetup_Vm = Provider.of<SupSetupsVM>(context,listen: false);
    return MainContainer(
        widget: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar3(currentAppBarText[landingInex], context, [
            IconButton(
                onPressed: () async {
                  await AddingMessage(_subSetup_Vm);
                  // await AddingMessage(_groupItem_Vm);
                },
                icon: Icon(Icons.add)),
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          ]),
          body: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child:SingleChildScrollView(
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
                                  "اسم المورد",
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
                              itemCount: PurchasesHelper.Sppliers?.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: ListTile(
                                            title: Row(
                                              mainAxisAlignment: MainAxisAlignment.center,
                                              children: [
                                                Text(PurchasesHelper.Sppliers![index].supAname??
                                                    'فارغ'),
                                              ],
                                            ),
                                            trailing: Icon(Icons.list),
                                            leading: SizedBox(
                                              width:96,
                                              child: Row(
                                                children: [
                                                  IconButton(
                                                    onPressed: () async {
                                                      EditRecord(PurchasesHelper.Sppliers![index].code??0,_subSetup_Vm,index);
                                                    },
                                                    icon: Icon(Icons.edit,size: 20,),
                                                    color: Colors.grey,
                                                  ),
                                                  IconButton(
                                                    onPressed: () async {
                                                      await RemovingRecord(PurchasesHelper.Sppliers![index].code??0,_subSetup_Vm,index);
                                                    },
                                                    icon: Icon(Icons.cancel_outlined,size: 20),
                                                    color: Colors.red,
                                                  ),
                                                ],
                                              ),
                                            ),
                                            onTap: (){
                                              perviewRecord(index);
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
