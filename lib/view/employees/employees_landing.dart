import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/view/employees/employees_home.dart';
import 'package:sbterp/view/stock/stock_home.dart';
import 'package:sbterp/widgets/custom_appbar2.dart';
import 'package:sbterp/widgets/main_container.dart';
import 'package:sbterp/utils/navigation.dart';

import 'package:provider/provider.dart';
import 'package:sbterp/widgets/main_container.dart';
import '../../utils/navigation.dart';
import '../../widgets/service_widget.dart';
import 'package:sbterp/view/home.dart';
import 'package:sbterp/widgets/cuttom_appbar.dart';
import 'package:provider/provider.dart';
import 'package:sbterp/view/landingpage.dart';

class EmployeesLanding extends StatefulWidget {

  const EmployeesLanding({Key? key}) : super(key: key);
  @override
  State<EmployeesLanding> createState() => _EmployeesLandingState();
}

class _EmployeesLandingState extends State<EmployeesLanding> {

  var landingInex = 0;
  var currentAppBarText = ['الموظفين' ];
  var landingContent = [
    EmployeesHome(),
  ];

  @override
  Widget build(BuildContext context) {

    return MainContainer(
        widget: Scaffold(
          appBar:CustomAppBar2(currentAppBarText[landingInex],context),
          body: landingContent[landingInex],
        ));
  }
}


