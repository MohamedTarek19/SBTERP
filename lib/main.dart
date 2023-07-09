import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/view_model/Sorefhdrs_vm.dart';
import 'package:sbterp/business_logic/view_model/citysets_vm.dart';
import 'package:sbterp/business_logic/view_model/empsetup_vm.dart';
import 'package:sbterp/business_logic/view_model/groubitemsetups_vm.dart';
import 'package:sbterp/business_logic/view_model/groubitsubs_vm.dart';
import 'package:sbterp/business_logic/view_model/itstor_vm.dart';
import 'package:sbterp/business_logic/view_model/porefdets_vm.dart';
import 'package:sbterp/business_logic/view_model/porefhdrs_vm.dart';
import 'package:sbterp/business_logic/view_model/poreqhdr_vm.dart';
import 'package:sbterp/business_logic/view_model/sohdr_vm.dart';
import 'package:sbterp/business_logic/view_model/sorefdets_vm.dart';
import 'package:sbterp/business_logic/view_model/subsetups_vm.dart';
import 'package:sbterp/business_logic/view_model/suptras_vm.dart';
import 'package:sbterp/business_logic/view_model/tblsetts_vm.dart';
import 'package:sbterp/theme/appthrmr.dart';
import 'package:sbterp/view/home.dart';
import 'package:sbterp/view/loginscreen.dart';

import 'package:sbterp/business_logic/view_model/account_vm.dart';
import 'package:sbterp/business_logic/view_model/custtra_vm.dart';
import 'package:sbterp/business_logic/view_model/customer_vm.dart';
import 'package:sbterp/business_logic/view_model/line_vm.dart';
import 'package:sbterp/business_logic/view_model/boxtrans_vm.dart';
import 'package:provider/provider.dart';
import 'package:sbterp/business_logic/view_model/custtram_vm.dart';

import 'business_logic/view_model/cashboxset_vm.dart';
import 'business_logic/view_model/ittran_vm.dart';
import 'business_logic/view_model/poreqdet_vm.dart';
import 'business_logic/view_model/sodet_vm.dart';
import 'business_logic/view_model/sohdrm_vm.dart';
import 'business_logic/view_model/stortype_vm.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => AccountVM()),
        ChangeNotifierProvider(create: (context) => CustomerVM()),
        ChangeNotifierProvider(create: (context) => CusttrarVM()),
        ChangeNotifierProvider(create: (context) => LineVM()),
        ChangeNotifierProvider(create: (context) => BoxtransVM()),
        ChangeNotifierProvider(create: (context) => CusttrarmVM()),
        ChangeNotifierProvider(create: (context) => CashboxsetVM()),
        ChangeNotifierProvider(create: (context) => SohdrVM()),
        ChangeNotifierProvider(create: (context) => SohdrmVM()),
        ChangeNotifierProvider(create: (context) => StortypeVM()),
        ChangeNotifierProvider(create: (context) => SodetVM()),
        ChangeNotifierProvider(create: (context) => ItstorVM()),
        ChangeNotifierProvider(create: (context) => IttranVM()),
        ChangeNotifierProvider(create: (context) => PoreqhdrVM()),
        ChangeNotifierProvider(create: (context) => PoreqdetVM()),
        ChangeNotifierProvider(create: (context)=>  GroupItemSetupsVM()),
        ChangeNotifierProvider(create: (context)=>  GroubItSubsVM()),
        ChangeNotifierProvider(create: (context)=>  CitySetsVM()),
        ChangeNotifierProvider(create: (context)=>  EmpVM()),
        ChangeNotifierProvider(create: (context)=>  SupSetupsVM()),
        ChangeNotifierProvider(create: (context)=>  SoRefhdrVM()),
        ChangeNotifierProvider(create: (context)=>  SoRefdetsVM()),
        ChangeNotifierProvider(create: (context)=>  PoRefhdrVM()),
        ChangeNotifierProvider(create: (context)=>  PoRefdetsVM()),
        ChangeNotifierProvider(create: (context)=>  SupptrarVM()),
        ChangeNotifierProvider(create: (context)=>  TblSetTsVM()),
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
       theme: AppTheme.themeData,
        home: const LoginScreen(),
      ),
    );
  }
}
