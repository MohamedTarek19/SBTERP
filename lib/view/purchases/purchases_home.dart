import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/view_model/subsetups_vm.dart';
import 'package:sbterp/view/purchases/purchases_helper.dart';
import 'package:sbterp/view/purchases/purchases_invoice.dart';
import 'package:sbterp/view/purchases/reports/reports.dart';
import 'package:sbterp/view/purchases/return_invoice.dart';
import 'package:sbterp/view/purchases/supplier_settings.dart';

import 'package:sbterp/widgets/main_container.dart';
import 'package:sbterp/utils/navigation.dart';
import 'package:sbterp/theme/appthrmr.dart';
import 'package:provider/provider.dart';
import '../../utils/navigation.dart';

import '../../widgets/service_widget.dart';
import '../../widgets/snackbar.dart';

class PurchasesHome extends StatelessWidget {
  const PurchasesHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _subSetup_Vm = Provider.of<SupSetupsVM>(context,listen: false);
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
                        imahePath: "assets/poinv.png",
                        name: "",
                        action: () {
                          Navigation.puchNav(PurchasesInvoice(), context);
                        },
                      ),
                      ServiceWidget(
                        imahePath: "assets/soref.png",
                        name: "",
                        action: () {
                          Navigation.puchNav(ReturnInvoice(), context);
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ServiceWidget(
                        imahePath: "assets/sup.png",
                        name: "",
                        action: () async {
                          showDialog(context: context, builder: (context) {return const Center(child: CircularProgressIndicator());});
                          await _subSetup_Vm.getSuppliers();
                          PurchasesHelper.Sppliers = _subSetup_Vm.Suppliers;
                          Navigator.pop(context);
                          Navigation.puchNav(SuppliersSettings(), context);

                        },
                      ),
                      ServiceWidget(
                        imahePath: "assets/report.png",
                        name: "",
                        action: () {
                          Navigation.puchNav(PurchasedReports(), context);
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
