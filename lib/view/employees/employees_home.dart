import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/view/employees/employee_reports/employee_report.dart';
import 'package:sbterp/view/employees/employee_settings/employee_settings.dart';

import 'package:sbterp/widgets/main_container.dart';
import 'package:sbterp/utils/navigation.dart';
import 'package:sbterp/theme/appthrmr.dart';
import 'package:provider/provider.dart';
import '../../utils/navigation.dart';

import '../../widgets/service_widget.dart';
import '../../widgets/snackbar.dart';

class EmployeesHome extends StatelessWidget {
  const EmployeesHome({Key? key}) : super(key: key);

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
                        imahePath: "assets/fset.png",
                        name: "",
                        action: () {},
                      ),
                      ServiceWidget(
                        imahePath: "assets/empabs.png",
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
                        imahePath: "assets/emphafez.png",
                        name: "",
                        action: () {},
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ServiceWidget(
                        imahePath: "assets/empgza.png",
                        name: "",
                        action: () {},
                      ),
                      ServiceWidget(
                        imahePath: "assets/empazn.png",
                        name: "",
                        action: () {},
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ServiceWidget(
                        imahePath: "assets/empholidaytran.png",
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
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ServiceWidget(
                        imahePath: "assets/setbl.png",
                        name: "",
                        action: () {
                          Navigation.puchNav(EmployeeSettings(), context);
                        },
                      ),
                      ServiceWidget(
                        imahePath: "assets/report.png",
                        name: "",
                        action: () {
                          Navigation.puchNav(EmployeesReport(), context);
                        },
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
