import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/theme/appthrmr.dart';
import 'package:sbterp/view/solds/sold_home.dart';
import 'package:sbterp/view/stock/stock_home.dart';
import 'package:sbterp/widgets/custom_appbar2.dart';
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

class EmployeesReport extends StatefulWidget {

  const EmployeesReport({Key? key}) : super(key: key);
  @override
  State<EmployeesReport> createState() => _EmployeesReportState();
}

class _EmployeesReportState extends State<EmployeesReport> {

  var landingInex = 0;
  var currentAppBarText = ['التقارير'];

  @override
  Widget build(BuildContext context) {

    return MainContainer(
        widget: Scaffold(
          appBar:CustomAppBar2(currentAppBarText[landingInex],context),
          body: StatelessReports(),
        ));
  }
}

class StatelessReports extends StatelessWidget {
  const StatelessReports({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
          children: [
            Container(
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: AssetImage("assets/Backkground.jpg"),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SingleChildScrollView(
              padding: EdgeInsets.only(top: 30.0),
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ServiceWidget(
                        imahePath: "assets/empabs.png",
                        name: "",
                        action: () {},
                      ),
                      ServiceWidget(
                        imahePath: "assets/empholidaytran.png",
                        name: "",
                        action: () {},
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ServiceWidget(
                        imahePath: "assets/empsolf.png",
                        name: "",
                        action: () {},
                      ),
                      ServiceWidget(
                        imahePath: "assets/tax.png",
                        name: "",
                        action: () {},
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ServiceWidget(
                        imahePath: "assets/empinsurance.png",
                        name: "",
                        action: () {},
                      ),
                      ServiceWidget(
                        imahePath: "assets/empsalary.png",
                        name: "",
                        action: () {},
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}



