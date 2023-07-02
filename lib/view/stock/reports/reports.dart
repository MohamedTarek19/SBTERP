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

class StockReports extends StatefulWidget {

  const StockReports({Key? key}) : super(key: key);
  @override
  State<StockReports> createState() => _StockReportsState();
}

class _StockReportsState extends State<StockReports> {

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
                        imahePath: "assets/stgard.png",
                        name: "",
                        action: () {},
                      ),
                      ServiceWidget(
                        imahePath: "assets/stcatgrd.png",
                        name: "",
                        action: () {},
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ServiceWidget(
                        imahePath: "assets/sttakiim.png",
                        name: "",
                        action: () {},
                      ),
                      ServiceWidget(
                        imahePath: "assets/stpo.png",
                        name: "",
                        action: () {},
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ServiceWidget(
                        imahePath: "assets/stso.png",
                        name: "",
                        action: () {},
                      ),
                      ServiceWidget(
                        imahePath: "assets/sttranrep.png",
                        name: "",
                        action: () {},
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){},
                          child: Container(
                            margin: AppTheme.marginall,
                            padding: AppTheme.paddingall,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppTheme.borderradiu3),
                                border: Border.all(color: AppTheme.mainColor, width: 1)),
                            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Image.asset(
                                "assets/repdmg.png",
                                height: 125,
                                width: 600,
                                fit: BoxFit.scaleDown,
                              ),

                            ]),
                          ),
                        ),
                      )
                    ],
                  ),

                ],
              ),
            ),
          ],
        ));
  }
}



