import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/theme/appthrmr.dart';
import 'package:sbterp/view/accounts/account_banks/bank_reports.dart';
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

class AccountsBanks extends StatefulWidget {

  const AccountsBanks({Key? key}) : super(key: key);
  @override
  State<AccountsBanks> createState() => _AccountsBanksState();
}

class _AccountsBanksState extends State<AccountsBanks> {

  var landingInex = 0;
  var currentAppBarText = ['البنوك'];

  @override
  Widget build(BuildContext context) {

    return MainContainer(
        widget: Scaffold(
          appBar:CustomAppBar2(currentAppBarText[landingInex],context),
          body: StatelessScreen(),
        ));
  }
}

class StatelessScreen extends StatelessWidget {
  const StatelessScreen({Key? key}) : super(key: key);

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
                        imahePath: "assets/issuorder.png",
                        name: "",
                        action: () {},
                      ),
                      ServiceWidget(
                        imahePath: "assets/chkin.png",
                        name: "",
                        action: () {},
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ServiceWidget(
                        imahePath: "assets/chkout.png",
                        name: "",
                        action: () {},
                      ),
                      ServiceWidget(
                        imahePath: "assets/chktref.png",
                        name: "",
                        action: () {},
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ServiceWidget(
                        imahePath: "assets/ba.png",
                        name: "",
                        action: () {},
                      ),
                      ServiceWidget(
                        imahePath: "assets/report.png",
                        name: "",
                        action: () {
                          Navigation.puchNav(BankReports(), context);
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



