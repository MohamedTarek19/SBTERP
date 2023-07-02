import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/view/accounts/accounts_landing.dart';
import 'package:sbterp/view/backline/backline_landing.dart';
import 'package:sbterp/view/employees/employees_landing.dart';
import 'package:sbterp/view/purchases/purchases_landing.dart';
import 'package:sbterp/view/solds/sold_landing.dart';
import 'package:sbterp/view/stock/stock_landing.dart';

import 'package:sbterp/widgets/main_container.dart';
import 'package:sbterp/utils/navigation.dart';
import 'package:sbterp/theme/appthrmr.dart';
import 'package:provider/provider.dart';
import '../../utils/navigation.dart';
import '../../widgets/service_widget.dart';


import '../business_logic/view_model/account_vm.dart';
import '../business_logic/view_model/boxtrans_vm.dart';
import '../business_logic/view_model/cashboxset_vm.dart';
import '../widgets/snackbar.dart';

import 'loginscreen.dart';

class Homescreen extends StatelessWidget {
  const Homescreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var account_vm = Provider.of<AccountVM>(context);
    var _boxtraVm = Provider.of<BoxtransVM>(context,listen: false);
    var _boxsetVm = Provider.of<CashboxsetVM>(context,listen: false);
    return   Scaffold(
        body: Stack(children: [
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage("assets/Backkground.jpg"),
                fit: BoxFit.cover,
              ),
            ),
          ),

        SingleChildScrollView(

      padding: EdgeInsets.only(top:30.0),

        child: Column(

        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children:   [
              ServiceWidget(
                imahePath: "assets/So.png",
                //   name: "Hi,${account_vm.userDetails ?? '...'}",
                name: "",
                action: (){
                  Navigation.puchNav(const SoldLanding(), context);



                },
              ),
              ServiceWidget(
                imahePath: "assets/Po.png",
                name: "",
                action: (){
                  Navigation.puchNav(const PurchasesLanding(), context);

                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ServiceWidget(
                imahePath: "assets/St.png",
                name: "",
                action: () {
                  Navigation.puchNav(StockLanding(), context);

                },
              ),
              ServiceWidget(
                imahePath: "assets/Emp.png",
                name: "",
                action: () {
                 Navigation.puchNav(const EmployeesLanding(), context);

                },
              ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              ServiceWidget(
                imahePath: "assets/Acc.png",
                name: "",
                action: () {
                 Navigation.puchNav(const AccountsLanding(), context);

                },
              ),
              ServiceWidget(
                imahePath: "assets/blackline.png",
                name: "",
                action: () async {
                  Navigation.puchNav(BackLineLanding(), context);
                  // var cashboxsetM = await _boxsetVm
                  //     .findboxbyname(
                  //     account_vm.userCash
                  //         .toString());
                  // if (cashboxsetM != null) {
                  //   var boxtrlastb = await _boxtraVm.losttSearchBySerial(cashboxsetM.id!);
                  // }
             //     Navigation.puchNav(const Boxtransfer(), context);
                },
              ),
            ],
          ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     // ServiceWidget(
          //     //   imahePath: "assets/Mandop.png",
          //     //   name: "",
          //     //   action: () {
          //     //
          //     //  //   Navigation.puchNav(const Stock(), context);
          //     //
          //     //   },
          //     // ),
          //     // ServiceWidget(
          //     //   imahePath: "assets/prem.png",
          //     //   name: "",
          //     //   action: () {
          //     //  //   Navigation.puchNav(const Searcrec(), context);
          //     //
          //     //   },
          //     // ),
          //   ],
          // ),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     ServiceWidget(
          //       imahePath: "assets/about.png",
          //       name: "عن الشركة",
          //       action: () {
          //         // CSnackBar.showSnackBar(
          //         //     context, "تم اغلاق الجولة بنجاح");
          //         Navigation.puchNav(const LoginScreen(), context);
          //
          //       },
          //     ),
          //
          //   ],
          // ),
        ],
      ),


          ),
        ],)
        );
  }
}
