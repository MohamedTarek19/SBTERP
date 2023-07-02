import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/view/accounts/accounts_home.dart';
import 'package:sbterp/view/backline/backline_home.dart';
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

class BackLineLanding extends StatefulWidget {

  const BackLineLanding({Key? key}) : super(key: key);
  @override
  State<BackLineLanding> createState() => _BackLineLandingState();
}

class _BackLineLandingState extends State<BackLineLanding> {

  var landingInex = 0;
  var currentAppBarText = ['الخطوط' ];
  var landingContent = [
    BackLineHome(),
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


