import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/customer_m.dart';
import 'package:sbterp/business_logic/model/custtra_m.dart';
import 'package:sbterp/business_logic/model/groubitemsetups_m.dart';
import 'package:sbterp/business_logic/model/groubitsubs_m.dart';
import 'package:sbterp/business_logic/model/stortype_m.dart';
import 'package:sbterp/business_logic/view_model/customer_vm.dart';
import 'package:sbterp/business_logic/view_model/custtra_vm.dart';
import 'package:sbterp/business_logic/view_model/groubitemsetups_vm.dart';
import 'package:sbterp/business_logic/view_model/groubitsubs_vm.dart';
import 'package:sbterp/business_logic/view_model/stortype_vm.dart';
import 'package:sbterp/theme/appthrmr.dart';
import 'package:sbterp/view/accounts/account_daily/daily_reports.dart';
import 'package:sbterp/view/solds/sold_home.dart';
import 'package:sbterp/view/solds/solds_helper.dart';
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

import '../../business_logic/model/empsetup_m.dart';

class CustSettings extends StatefulWidget {
  const CustSettings({Key? key}) : super(key: key);

  @override
  State<CustSettings> createState() => _CustSettingsState();
}

class _CustSettingsState extends State<CustSettings> {
  var landingInex = 0;
  var currentAppBarText = ['قائمة إعداد عملاء'];
  TextEditingController CustName = TextEditingController();
  TextEditingController CustPhone = TextEditingController();
  String? managerName;
  String? EmpName;
  String? city;
  String? pr;
  TextEditingController EmailAddress = TextEditingController();
  TextEditingController HomeAddress = TextEditingController();
  TextEditingController OrangeAccount = TextEditingController();
  TextEditingController OrangeSim = TextEditingController();
  TextEditingController MasaryAccount = TextEditingController();
  TextEditingController MasarySerial = TextEditingController();
  TextEditingController AhlyAccount = TextEditingController();
  TextEditingController AhlySerial = TextEditingController();
  TextEditingController AmanAccount = TextEditingController();
  TextEditingController AmanSerial = TextEditingController();
  TextEditingController MaxDaysAllowed = TextEditingController();
  TextEditingController Limit = TextEditingController();
  TextEditingController Pal = TextEditingController();
  List<EmpsetupM>? manager = [];
  List<EmpsetupM>? employee = [];
  List<String> prices = ['سعر شراء', 'سعر بيع', 'سعر جملة', 'سعر أون لاين'];


  void TextEditorReset(){
    OrangeAccount = TextEditingController();
    OrangeSim = TextEditingController();
    MasaryAccount = TextEditingController();
    MasarySerial = TextEditingController();
    AhlyAccount = TextEditingController();
    AhlySerial = TextEditingController();
    AmanAccount = TextEditingController();
    AmanSerial = TextEditingController();
    MaxDaysAllowed = TextEditingController();
    Limit = TextEditingController();
    EmailAddress = TextEditingController();
    HomeAddress = TextEditingController();
    Pal = TextEditingController();
    managerName = null;
    EmpName = null;
    city = null;
    pr = null;
    CustName = TextEditingController();
    CustPhone = TextEditingController();
  }
  void TextEditorAssign(CustomerM custM){
    OrangeAccount.text = custM.caccorang??'';
    OrangeSim.text = custM.cserorang??'';
    MasaryAccount.text= custM.caccmasary??'';
    MasarySerial.text = custM.csermasary??'';
    AhlyAccount.text=custM.caccahly??'';
    AhlySerial.text = custM.cserahly??'';
    AmanAccount.text =custM.caccaman??'';
    AmanSerial.text= custM.cseraman??'';
    MaxDaysAllowed.text = custM.MaxDayAllwo.toString();
    Limit.text = custM.CreditLimit.toString();
    EmailAddress.text =custM.custemail??'';
    HomeAddress.text = custM.custaddres1??'';
    Pal.text = custM.custbal.toString();
    managerName = custM.manage;
    EmpName = custM.mandob;
    city = custM.city;
    pr = custM.CustPrice;
    CustName.text = custM.custAname??'';
    CustPhone.text= custM.custmobile??'';
  }

  void update(CustomerM custM){
    custM.caccorang=OrangeAccount.text;
    custM.cserorang = OrangeSim.text;
    custM.caccmasary = MasaryAccount.text;
    custM.csermasary = MasarySerial.text;
    custM.caccahly = AhlyAccount.text;
    custM.cserahly = AhlySerial.text;
    custM.caccaman = AmanAccount.text;
    custM.cseraman = AmanSerial.text ;
    custM.MaxDayAllwo = double.tryParse(MaxDaysAllowed.text);
    custM.CreditLimit = double.tryParse(Limit.text);
    custM.custemail = EmailAddress.text;
    custM.custaddres1 = HomeAddress.text;
    custM.custbal = double.tryParse(Pal.text);
    custM.manage = managerName;
    custM.mandob = EmpName;
    custM.city = city;
    custM.CustPrice = pr;
    custM.custAname = CustName.text;
    custM.custmobile = CustPhone.text;
    custM.custaddres2 = '';
  }


  void EmpManagerFilter() {
    manager = [];
    employee = [];
    for (EmpsetupM e in SoldsHelper.employees ?? []) {
      if (e.emp_job == 'مندوب مبيعات') {
        employee?.add(e);
      } else if (e.emp_job == 'مدير مبيعات') {
        manager?.add(e);
      }
    }
  }

  AddingMessage(CustomerVM _customerVm) async {
    TextEditorReset();
    EmpManagerFilter();
    return showDialog(
        context: context,
        builder: (context) {
          final _custtraVm = Provider.of<CusttrarVM>(context, listen: false);
          return AlertDialog(
            backgroundColor: Color.fromRGBO(240, 240, 240, 1),
            elevation: 100,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            title: Container(
                child: Text(
              'إضافة عميل',
              style: TextStyle(color: Colors.black, fontSize: 17),
              textDirection: TextDirection.rtl,
            )),
            content: StatefulBuilder(builder: (context, setState) {
              return SingleChildScrollView(
                child: Column(
                  children: [
                    CustomTextField(
                        icon: Icons.person,
                        controller: CustName,
                        name: 'الإسم'),
                    CustomDropDownMenu(
                        Width: MediaQuery.of(context).size.width,
                        value: city,
                        fun: (String? val) {
                          setState(() {
                            city = val.toString();
                          });
                        },
                        items: SoldsHelper.cities?.map((item) {
                          return DropdownMenuItem(
                            value: item.cityname ?? '',
                            child: Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // for example
                                child: Text(
                                  item.cityname ?? '',
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 17),
                                )),
                          );
                        }).toList(),
                        Left: 0,
                        Right: 0,
                        name: 'المدينة'),
                    CustomDropDownMenu(
                        Width: MediaQuery.of(context).size.width,
                        value: managerName,
                        fun: (String? val) {
                          setState(() {
                            managerName = val;
                          });
                        },
                        items: manager?.map((item) {
                          return DropdownMenuItem(
                            value: item.emp_name ?? '',
                            child: Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // for example
                                child: Text(
                                  item.emp_name ?? '',
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 17),
                                )),
                          );
                        }).toList(),
                        Left: 0,
                        Right: 0,
                        name: 'مدير المبيعات'),
                    CustomDropDownMenu(
                        Width: MediaQuery.of(context).size.width,
                        value: EmpName,
                        fun: (String? val) {
                          setState(() {
                            EmpName = val;
                          });
                        },
                        items: employee?.map((item) {
                          return DropdownMenuItem(
                            value: item.emp_name ?? '',
                            child: Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // for example
                                child: Text(
                                  item.emp_name ?? '',
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 17),
                                )),
                          );
                        }).toList(),
                        Left: 0,
                        Right: 0,
                        name: 'مندوب المبيعات'),
                    Divider(
                      height: 1,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text("حد اللإئتمان")),
                    Container(
                      margin:
                          EdgeInsets.only(top: 2, bottom: 2, left: 5, right: 5),
                      child: NumberInputWithIncrementDecrement(
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
                        controller: Limit,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text("مدة السماح / باليوم")),
                    Container(
                      margin:
                          EdgeInsets.only(top: 2, bottom: 5, left: 5, right: 5),
                      child: NumberInputWithIncrementDecrement(
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
                        controller: MaxDaysAllowed,
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
                    CustomDropDownMenu(
                        Width: MediaQuery.of(context).size.width,
                        value: pr,
                        fun: (String? val) {
                          setState((){
                            pr = val.toString();
                          });
                        },
                        items: prices.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // for example
                                child: Text(
                                  item,
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 17),
                                )),
                          );
                        }).toList(),
                        Left: 0,
                        Right: 0,
                        name: 'قائمة أسعار'),
                    CustomTextField(
                        icon: Icons.location_on_outlined,
                        controller: HomeAddress,
                        name: 'العنوان'),
                    CustomTextField(
                        icon: Icons.phone,
                        controller: CustPhone,
                        name: 'رقم الجوال',
                        type: TextInputType.phone),
                    CustomTextField(
                        icon: Icons.email_outlined,
                        controller: EmailAddress,
                        name: 'البريد الإلكتروني',
                        type: TextInputType.emailAddress),
                    Divider(
                      height: 1,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text("الرصيد")),
                    Container(
                      margin:
                          EdgeInsets.only(top: 2, bottom: 5, left: 5, right: 5),
                      child: NumberInputWithIncrementDecrement(
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
                        controller: Pal,
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
                    CustomTextField(
                        icon: Icons.numbers,
                        controller: OrangeAccount,
                        name: 'رقم حساب أورانج',
                        type: TextInputType.number),
                    CustomTextField(
                        icon: Icons.numbers,
                        controller: OrangeSim,
                        name: 'رقم خط أورانج',
                        type: TextInputType.number),
                    CustomTextField(
                        icon: Icons.numbers,
                        controller: MasaryAccount,
                        name: 'رقم حساب مصاري',
                        type: TextInputType.number),
                    CustomTextField(
                        icon: Icons.numbers,
                        controller: MasarySerial,
                        name: 'رقم سيريال ماكينة مصاري',
                        type: TextInputType.number),
                    CustomTextField(
                        icon: Icons.numbers,
                        controller: AhlyAccount,
                        name: 'رقم حساب الأهلي',
                        type: TextInputType.number),
                    CustomTextField(
                        icon: Icons.numbers,
                        controller: AhlySerial,
                        name: 'رقم سيريال ماكينة الأهلي',
                        type: TextInputType.number),
                    CustomTextField(
                        icon: Icons.numbers,
                        controller: AmanAccount,
                        name: 'رقم حساب أمان',
                        type: TextInputType.number),
                    CustomTextField(
                        icon: Icons.numbers,
                        controller: AmanSerial,
                        name: 'رقم سيريال ماكينة أمان',
                        type: TextInputType.number),
                  ],
                ),
              );
            }),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    showDialog(context: context, builder: (context) {return const Center(child: CircularProgressIndicator());});
                    CustomerM cust = CustomerM(
                      custAname: CustName.text,
                      custaddres1: HomeAddress.text,
                      city: city,
                      custaddres2: '',
                      custmobile: CustPhone.text,
                      mandob: EmpName,
                      manage: managerName,
                      custfbal: double.tryParse(Pal.text.toString())??0,
                      custbal: double.tryParse(Pal.text.toString())??0,
                      code: 0,
                      custemail: EmailAddress.text,
                      CustPrice: pr,
                      CreditLimit: double.tryParse(Limit.text.toString())??0,
                      MaxDayAllwo: double.tryParse(MaxDaysAllowed.text.toString())??0,
                      caccorang: OrangeAccount.text,
                      caccahly: AhlyAccount.text,
                      caccaman: AmanAccount.text,
                      caccmasary: MasaryAccount.text,
                      cserorang: OrangeSim.text,
                      cserahly: AhlySerial.text,
                      cseraman: AmanSerial.text,
                      csermasary: MasarySerial.text,
                      // custemail: email.text
                    );
                    await _customerVm.getCustomers();
                    setState(() {
                      cust.code = _customerVm.Customers!.last.code;
                      print(cust.code);
                      SoldsHelper.Customers?.add(cust);
                    });
                      await _customerVm.CreateCustomer(cust);
                      await _custtraVm.CreateCustomertra(CusttraM(
                          custid: cust.code,
                          docno: 0,
                          docdate: DateTime.now(),
                          id: 0,
                          credit: 0,
                          debit: 0,
                          lastb: 0,
                          disc: "رصيد اول المدة"));
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

  RemovingRecord(int id,CustomerVM _customerVm,int idx) async {
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
                  'هل تريد حذف هذا القسم',
                  style: TextStyle(color: Colors.black, fontSize: 17),
                  textDirection: TextDirection.rtl,
                )),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    showDialog(context: context, builder: (context) {return const Center(child: CircularProgressIndicator());});
                    await _customerVm.DeleteCustomer(id);
                    setState(() {
                      SoldsHelper.Customers!.removeAt(idx);
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

  EditRecord(int id,CustomerVM _customerVm,int idx) async {
    print(SoldsHelper.Customers![idx].code);
    TextEditorReset();
    EmpManagerFilter();
    TextEditorAssign(SoldsHelper.Customers![idx]);
    print("${SoldsHelper.Customers![idx].custfbal} and ${SoldsHelper.Customers![idx].custbal} and ${Pal.text}");
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
                        icon: Icons.person,
                        controller: CustName,
                        name: SoldsHelper.Customers![idx].custAname??''),
                    CustomDropDownMenu(
                        Width: MediaQuery.of(context).size.width,
                        value: city!.trim(),
                        fun: (String? val) {
                          setState(() {
                            city = val.toString();
                          });
                        },
                        items: SoldsHelper.cities?.map((item) {
                          //print(SoldsHelper.cities?.length);
                          return DropdownMenuItem(
                            value: item.cityname ?? '',
                            child: Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // for example
                                child: Text(
                                  item.cityname ?? '',
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 17),
                                )),
                          );
                        }).toList(),
                        Left: 0,
                        Right: 0,
                        name: 'المدينة'),
                    CustomDropDownMenu(
                        Width: MediaQuery.of(context).size.width,
                        value: managerName,
                        fun: (String? val) {
                          setState(() {
                            managerName = val;
                          });
                        },
                        items: manager?.map((item) {
                          return DropdownMenuItem(
                            value: item.emp_name ?? '',
                            child: Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // for example
                                child: Text(
                                  item.emp_name ?? '',
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 17),
                                )),
                          );
                        }).toList(),
                        Left: 0,
                        Right: 0,
                        name: 'مدير المبيعات'),
                    CustomDropDownMenu(
                        Width: MediaQuery.of(context).size.width,
                        value: int.tryParse(EmpName!) == null? EmpName: null,
                        fun: (String? val) {
                          setState(() {
                            EmpName = val;
                          });
                        },
                        items: employee?.map((item) {
                          return DropdownMenuItem(
                            value: item.emp_name ?? '',
                            child: Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // for example
                                child: Text(
                                  item.emp_name ?? '',
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 17),
                                )),
                          );
                        }).toList(),
                        Left: 0,
                        Right: 0,
                        name: 'مندوب المبيعات'),
                    Divider(
                      height: 1,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text("حد اللإئتمان")),
                    Container(
                      margin:
                      EdgeInsets.only(top: 2, bottom: 2, left: 5, right: 5),
                      child: NumberInputWithIncrementDecrement(
                        initialValue:double.tryParse(Limit.text.toString())??0,
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
                        controller: Limit,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text("مدة السماح / باليوم")),
                    Container(
                      margin:
                      EdgeInsets.only(top: 2, bottom: 5, left: 5, right: 5),
                      child: NumberInputWithIncrementDecrement(
                        initialValue:double.tryParse(Limit.text.toString())??0,
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
                        controller: MaxDaysAllowed,
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
                    CustomDropDownMenu(
                        Width: MediaQuery.of(context).size.width,
                        value: pr,
                        fun: (String? val) {
                          setState((){
                            pr = val.toString();
                          });
                        },
                        items: prices.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // for example
                                child: Text(
                                  item,
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 17),
                                )),
                          );
                        }).toList(),
                        Left: 0,
                        Right: 0,
                        name: 'قائمة أسعار'),
                    CustomTextField(
                        icon: Icons.location_on_outlined,
                        controller: HomeAddress,
                        name: SoldsHelper.Customers![idx].custaddres1??''),
                    CustomTextField(
                        icon: Icons.phone,
                        controller: CustPhone,
                        name: SoldsHelper.Customers![idx].custmobile??'',
                        type: TextInputType.phone),
                    CustomTextField(
                        icon: Icons.email_outlined,
                        controller: EmailAddress,
                        name: SoldsHelper.Customers![idx].custemail??'',
                        type: TextInputType.emailAddress),
                    Divider(
                      height: 1,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text("الرصيد")),
                    Container(
                      margin:
                      EdgeInsets.only(top: 2, bottom: 5, left: 5, right: 5),
                      child: NumberInputWithIncrementDecrement(
                        buttonArrangement: ButtonArrangement.leftEnd,
                        initialValue:double.tryParse(Pal.text.toString())??0,
                        numberFieldDecoration:
                        InputDecoration(border: InputBorder.none,hintText: Pal.text,),
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
                        controller: Pal,

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
                    CustomTextField(
                        icon: Icons.numbers,
                        controller: OrangeAccount,
                        name: SoldsHelper.Customers![idx].caccorang??'',
                        type: TextInputType.number),
                    CustomTextField(
                        icon: Icons.numbers,
                        controller: OrangeSim,
                        name: SoldsHelper.Customers![idx].cserorang??'',
                        type: TextInputType.number),
                    CustomTextField(
                        icon: Icons.numbers,
                        controller: MasaryAccount,
                        name: SoldsHelper.Customers![idx].caccmasary??'',
                        type: TextInputType.number),
                    CustomTextField(
                        icon: Icons.numbers,
                        controller: MasarySerial,
                        name: SoldsHelper.Customers![idx].csermasary??'',
                        type: TextInputType.number),
                    CustomTextField(
                        icon: Icons.numbers,
                        controller: AhlyAccount,
                        name: SoldsHelper.Customers![idx].caccahly??'',
                        type: TextInputType.number),
                    CustomTextField(
                        icon: Icons.numbers,
                        controller: AhlySerial,
                        name: SoldsHelper.Customers![idx].cserahly??'',
                        type: TextInputType.number),
                    CustomTextField(
                        icon: Icons.numbers,
                        controller: AmanAccount,
                        name: SoldsHelper.Customers![idx].caccaman??'',
                        type: TextInputType.number),
                    CustomTextField(
                        icon: Icons.numbers,
                        controller: AmanSerial,
                        name: SoldsHelper.Customers![idx].cseraman??'',
                        type: TextInputType.number),
                  ],
                ),
              );
            }),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    showDialog(context: context, builder: (context) {return const Center(child: CircularProgressIndicator());});

                    setState(() {
                      update(SoldsHelper.Customers![idx]);
                    });
                    await _customerVm.EditCustomer(id, SoldsHelper.Customers![idx]);
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
    TextEditorReset();
    EmpManagerFilter();
    TextEditorAssign(SoldsHelper.Customers![idx]);
    print("${SoldsHelper.Customers![idx].custfbal} and ${SoldsHelper.Customers![idx].custbal} and ${Pal.text}");
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
                        icon: Icons.person,
                        controller: CustName,
                        name: SoldsHelper.Customers![idx].custAname??''),
                    CustomDropDownMenu(
                        Width: MediaQuery.of(context).size.width,
                        value: city!.trim(),
                        fun: (String? val) {
                          setState(() {
                            city = val.toString();
                          });
                        },
                        items: SoldsHelper.cities?.map((item) {
                          print(SoldsHelper.cities?.length);
                          return DropdownMenuItem(
                            value: item.cityname ?? '',
                            child: Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // for example
                                child: Text(
                                  item.cityname ?? '',
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 17),
                                )),
                          );
                        }).toList(),
                        Left: 0,
                        Right: 0,
                        name: 'المدينة'),
                    CustomDropDownMenu(
                        Width: MediaQuery.of(context).size.width,
                        value: managerName,
                        fun: (String? val) {
                          setState(() {
                            managerName = val;
                          });
                        },
                        items: manager?.map((item) {
                          return DropdownMenuItem(
                            value: item.emp_name ?? '',
                            child: Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // for example
                                child: Text(
                                  item.emp_name ?? '',
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 17),
                                )),
                          );
                        }).toList(),
                        Left: 0,
                        Right: 0,
                        name: 'مدير المبيعات'),
                    CustomDropDownMenu(
                        Width: MediaQuery.of(context).size.width,
                        value: int.tryParse(EmpName!) == null? EmpName: null,
                        fun: (String? val) {
                          setState(() {
                            EmpName = val;
                          });
                        },
                        items: employee?.map((item) {
                          return DropdownMenuItem(
                            value: item.emp_name ?? '',
                            child: Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // for example
                                child: Text(
                                  item.emp_name ?? '',
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 17),
                                )),
                          );
                        }).toList(),
                        Left: 0,
                        Right: 0,
                        name: 'مندوب المبيعات'),
                    Divider(
                      height: 1,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text("حد اللإئتمان")),
                    Container(
                      margin:
                      EdgeInsets.only(top: 2, bottom: 2, left: 5, right: 5),
                      child: NumberInputWithIncrementDecrement(
                        initialValue:double.tryParse(Limit.text.toString())??0,
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
                        controller: Limit,
                      ),
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text("مدة السماح / باليوم")),
                    Container(
                      margin:
                      EdgeInsets.only(top: 2, bottom: 5, left: 5, right: 5),
                      child: NumberInputWithIncrementDecrement(
                        initialValue:double.tryParse(Limit.text.toString())??0,
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
                        controller: MaxDaysAllowed,
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
                    CustomDropDownMenu(
                        Width: MediaQuery.of(context).size.width,
                        value: pr,
                        fun: (String? val) {
                          setState((){
                            pr = val.toString();
                          });
                        },
                        items: prices.map((item) {
                          return DropdownMenuItem(
                            value: item,
                            child: Container(
                                width: MediaQuery.of(context)
                                    .size
                                    .width, // for example
                                child: Text(
                                  item,
                                  textAlign: TextAlign.center,
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(fontSize: 17),
                                )),
                          );
                        }).toList(),
                        Left: 0,
                        Right: 0,
                        name: 'قائمة أسعار'),
                    CustomTextField(
                        icon: Icons.location_on_outlined,
                        controller: HomeAddress,
                        name: SoldsHelper.Customers![idx].custaddres1??''),
                    CustomTextField(
                        icon: Icons.phone,
                        controller: CustPhone,
                        name: SoldsHelper.Customers![idx].custmobile??'',
                        type: TextInputType.phone),
                    CustomTextField(
                        icon: Icons.email_outlined,
                        controller: EmailAddress,
                        name: SoldsHelper.Customers![idx].custemail??'',
                        type: TextInputType.emailAddress),
                    Divider(
                      height: 1,
                      thickness: 1,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Container(
                        margin: EdgeInsets.only(top: 15),
                        child: Text("الرصيد")),
                    Container(
                      margin:
                      EdgeInsets.only(top: 2, bottom: 5, left: 5, right: 5),
                      child: NumberInputWithIncrementDecrement(
                        buttonArrangement: ButtonArrangement.leftEnd,
                        initialValue:double.tryParse(Pal.text.toString())??0,
                        numberFieldDecoration:
                        InputDecoration(border: InputBorder.none,hintText: Pal.text,),
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
                        controller: Pal,

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
                    CustomTextField(
                        icon: Icons.numbers,
                        controller: OrangeAccount,
                        name: SoldsHelper.Customers![idx].caccorang??'',
                        type: TextInputType.number),
                    CustomTextField(
                        icon: Icons.numbers,
                        controller: OrangeSim,
                        name: SoldsHelper.Customers![idx].cserorang??'',
                        type: TextInputType.number),
                    CustomTextField(
                        icon: Icons.numbers,
                        controller: MasaryAccount,
                        name: SoldsHelper.Customers![idx].caccmasary??'',
                        type: TextInputType.number),
                    CustomTextField(
                        icon: Icons.numbers,
                        controller: MasarySerial,
                        name: SoldsHelper.Customers![idx].csermasary??'',
                        type: TextInputType.number),
                    CustomTextField(
                        icon: Icons.numbers,
                        controller: AhlyAccount,
                        name: SoldsHelper.Customers![idx].caccahly??'',
                        type: TextInputType.number),
                    CustomTextField(
                        icon: Icons.numbers,
                        controller: AhlySerial,
                        name: SoldsHelper.Customers![idx].cserahly??'',
                        type: TextInputType.number),
                    CustomTextField(
                        icon: Icons.numbers,
                        controller: AmanAccount,
                        name: SoldsHelper.Customers![idx].caccaman??'',
                        type: TextInputType.number),
                    CustomTextField(
                        icon: Icons.numbers,
                        controller: AmanSerial,
                        name: SoldsHelper.Customers![idx].cseraman??'',
                        type: TextInputType.number),
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
    final _customerVm = Provider.of<CustomerVM>(context, listen: false);
    return MainContainer(
        widget: Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: CustomAppBar3(currentAppBarText[landingInex], context, [
        IconButton(
            onPressed: () async {
              await AddingMessage(_customerVm);
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
                              "اسم العميل",
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
                          itemCount: SoldsHelper.Customers?.length,
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
                                            Container(
                                              width:MediaQuery.of(context).size.width*0.45,
                                              child: FittedBox(
                                                  fit: BoxFit.scaleDown,child: Text(style:TextStyle(fontSize: 14),SoldsHelper.Customers![index].custAname ?? 'فارغ')),
                                            ),
                                          ],
                                        ),
                                        trailing: Icon(Icons.list),
                                        leading: SizedBox(
                                          width: 96,
                                          child: Row(
                                            children: [
                                              IconButton(
                                                onPressed: () async {
                                                  await EditRecord(SoldsHelper.Customers![index].code??0,_customerVm,index);

                                                },
                                                icon: Icon(
                                                  Icons.edit,
                                                  size: 20,
                                                ),
                                                color: Colors.grey,
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  //await RemovingRecord(SoldsHelper.Customers![index].code??0,_customerVm,index);
                                                },
                                                icon: Icon(Icons.cancel_outlined,
                                                    size: 20),
                                                color: Colors.red,
                                              ),
                                            ],
                                          ),
                                        ),
                                        onTap: (){
                                          PerviewRecord(index);
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
