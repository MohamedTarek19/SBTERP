import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/widgets/main_container.dart';
import 'package:sbterp/utils/navigation.dart';

import 'package:provider/provider.dart';
import 'package:sbterp/widgets/main_container.dart';
import '../../utils/navigation.dart';
import '../../widgets/service_widget.dart';
import 'package:sbterp/view/home.dart';
import 'package:sbterp/widgets/cuttom_appbar.dart';
import 'package:provider/provider.dart';
import '../business_logic/view_model/account_vm.dart';
import 'package:sbterp/view/landingpage.dart';

class LandingPage extends StatefulWidget {

  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {


  var landingInex = 0;
  var currentAppBarText = ['SBT' ];
  var landingContent = [
    Homescreen(),
  ];
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {

    return MainContainer(
        widget: Scaffold(
          key: _scaffoldKey,
          appBar: CustomAbbBar(currentAppBarText[landingInex], context),
          body: landingContent[landingInex],
        ));
  }
}


