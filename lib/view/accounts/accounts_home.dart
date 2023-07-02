import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/view/accounts/account_assets/account_assets.dart';
import 'package:sbterp/view/accounts/account_banks/account_banks.dart';
import 'package:sbterp/view/accounts/account_daily/account_daily.dart';
import 'package:sbterp/view/accounts/account_settings/account_settings.dart';
import 'package:sbterp/view/accounts/account_stock/account_stock.dart';

import 'package:sbterp/widgets/main_container.dart';
import 'package:sbterp/utils/navigation.dart';
import 'package:sbterp/theme/appthrmr.dart';
import 'package:provider/provider.dart';
import '../../utils/navigation.dart';

import '../../widgets/service_widget.dart';
import '../../widgets/snackbar.dart';

class AccountsHome extends StatelessWidget {
  const AccountsHome({Key? key}) : super(key: key);

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
                        imahePath: "assets/Accountssetup.png",
                        name: "",
                        action: () {
                          Navigation.puchNav(AccountsSettings(), context);
                        },
                      ),
                      ServiceWidget(
                        imahePath: "assets/AccountAssests.png",
                        name: "",
                        action: () {
                          Navigation.puchNav(AccountsAssets(), context);
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ServiceWidget(
                        imahePath: "assets/AccountDaily.png",
                        name: "",
                        action: () {
                          Navigation.puchNav(AccountsDaily(), context);

                        },
                      ),
                      ServiceWidget(
                        imahePath: "assets/Stor (1).png",
                        name: "",
                        action: () {
                          Navigation.puchNav(AccountsStock(), context);

                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        flex: 1,
                        child: GestureDetector(
                          onTap: (){
                            Navigation.puchNav(AccountsBanks(), context);
                          },
                          child: Container(
                            margin: AppTheme.marginall,
                            padding: AppTheme.paddingall,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(AppTheme.borderradiu3),
                                border: Border.all(color: AppTheme.mainColor, width: 1)),
                            child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                              Image.asset(
                                "assets/AccountBank.png",
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
