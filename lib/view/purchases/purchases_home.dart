import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/itstor_m.dart';
import 'package:sbterp/business_logic/model/stortype_m.dart';
import 'package:sbterp/business_logic/view_model/account_vm.dart';
import 'package:sbterp/business_logic/view_model/itstor_vm.dart';
import 'package:sbterp/business_logic/view_model/porefdets_vm.dart';
import 'package:sbterp/business_logic/view_model/porefhdrs_vm.dart';
import 'package:sbterp/business_logic/view_model/stortype_vm.dart';
import 'package:sbterp/business_logic/view_model/subsetups_vm.dart';
import 'package:sbterp/view/invoice_helper.dart';
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
    var account_vm = Provider.of<AccountVM>(context,listen: false);
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
                        action: () async {
                          showDialog(context: context, builder: (
                              context) {
                            InvoiceHelper.items?.clear();

                            return const Center(
                                child: CircularProgressIndicator());
                          });
                          var _itstorVm = Provider.of<ItstorVM>(context,listen: false);
                          var _storTypes = Provider.of<StortypeVM>(context,listen: false);
                          InvoiceHelper.user = account_vm.user;
                          await _subSetup_Vm.getSuppliers();
                          PurchasesHelper.Sppliers = _subSetup_Vm.Suppliers;
                          var _poRefhdrVm = Provider.of<PoRefhdrVM>(context,listen: false);
                          await _poRefhdrVm.GetPohdrs();
                          await _itstorVm.GetAllItems();
                          print(_itstorVm.items?.length);
                          StortypeM? storid = await _storTypes.findstorbyname(InvoiceHelper.user?.storid??'');
                          InvoiceHelper.storid = storid?.id??0;
                          print(InvoiceHelper.storid);

                          await _itstorVm.GetItemsByStoreId(InvoiceHelper.storid);
                          InvoiceHelper.items = _itstorVm.items;

                          Navigator.pop(context);
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
