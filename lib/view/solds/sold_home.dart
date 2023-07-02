import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/customer_m.dart';
import 'package:sbterp/business_logic/model/itstor_m.dart';
import 'package:sbterp/business_logic/model/stortype_m.dart';
import 'package:sbterp/business_logic/view_model/Sorefhdrs_vm.dart';
import 'package:sbterp/business_logic/view_model/account_vm.dart';
import 'package:sbterp/business_logic/view_model/citysets_vm.dart';
import 'package:sbterp/business_logic/view_model/customer_vm.dart';
import 'package:sbterp/business_logic/view_model/empsetup_vm.dart';
import 'package:sbterp/business_logic/view_model/itstor_vm.dart';
import 'package:sbterp/business_logic/view_model/sohdr_vm.dart';
import 'package:sbterp/business_logic/view_model/stortype_vm.dart';
import 'package:sbterp/view/invoice_helper.dart';
import 'package:sbterp/view/solds/cust_settings.dart';
import 'package:sbterp/view/solds/reports/reports.dart';
import 'package:sbterp/view/solds/sold_invoice.dart';
import 'package:sbterp/view/solds/sold_return_invoice.dart';
import 'package:sbterp/view/solds/solds_helper.dart';

import 'package:sbterp/widgets/main_container.dart';
import 'package:sbterp/utils/navigation.dart';
import 'package:sbterp/theme/appthrmr.dart';
import 'package:provider/provider.dart';
import '../../utils/navigation.dart';

import '../../widgets/service_widget.dart';
import '../../widgets/snackbar.dart';

class SoldHome extends StatelessWidget {
  const SoldHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _Emp_Vm = Provider.of<EmpVM>(context,listen: false);
    var _CitySets_Vm = Provider.of<CitySetsVM>(context,listen: false);
    final _customerVm = Provider.of<CustomerVM>(context, listen: false);
    var account_vm = Provider.of<AccountVM>(context,listen: false);

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
                        imahePath: "assets/Soinv.png",
                        name: "",
                        action: () async {
                          showDialog(context: context, builder: (
                              context) {
                            return const Center(
                                child: CircularProgressIndicator());
                          });
                          InvoiceHelper.custs?.clear();
                          InvoiceHelper.items?.clear();
                          var customerVm = Provider.of<CustomerVM>(context, listen: false);
                          var _itstorVm = Provider.of<ItstorVM>(context,listen: false);
                          var _storTypes = Provider.of<StortypeVM>(context,listen: false);
                          InvoiceHelper.user = account_vm.user;
                          print(InvoiceHelper.user?.username);
                          await customerVm.getCustomers();
                          await _itstorVm.GetAllItems();
                          print(_itstorVm.items?.length);
                          for(CustomerM c in customerVm.Customers??[]){
                            if(c.mandob == InvoiceHelper.user?.username){
                              print(1);
                              InvoiceHelper.custs?.add(c);
                            }
                          }
                          StortypeM? storid = await _storTypes.findstorbyname(InvoiceHelper.user?.storid??'');
                          InvoiceHelper.storid = storid?.id??0;
                          print(InvoiceHelper.storid);
                          for(ItstorM s in _itstorVm.items??[]){
                            //print("${s.storid.toString().trim()} , ${storid?.id}");
                            if(s.storid == storid?.id){
                              InvoiceHelper.items?.add(s);
                            }
                          }
                          var _sohdrVm = Provider.of<SohdrVM>(context,listen: false);
                          await _sohdrVm.GetSohdrs();
                          print(InvoiceHelper.items?.length);
                          Navigator.pop(context);
                          Navigation.puchNav(SoldInvoice(), context);
                        },
                      ),
                      ServiceWidget(
                        imahePath: "assets/soref.png",
                        name: "",
                        action: () async {
                          showDialog(context: context, builder: (
                              context) {
                            return const Center(
                                child: CircularProgressIndicator());
                          });
                          InvoiceHelper.custs?.clear();
                          InvoiceHelper.items?.clear();
                          var customerVm = Provider.of<CustomerVM>(context, listen: false);
                          var _itstorVm = Provider.of<ItstorVM>(context,listen: false);
                          var _storTypes = Provider.of<StortypeVM>(context,listen: false);
                          InvoiceHelper.user = account_vm.user;
                          print(InvoiceHelper.user?.username);
                          await customerVm.getCustomers();
                          await _itstorVm.GetAllItems();
                          print(_itstorVm.items?.length);
                          for(CustomerM c in customerVm.Customers??[]){
                            if(c.mandob == InvoiceHelper.user?.username){
                              print(1);
                              InvoiceHelper.custs?.add(c);
                            }
                          }
                          StortypeM? storid = await _storTypes.findstorbyname(InvoiceHelper.user?.storid??'');
                          InvoiceHelper.storid = storid?.id??0;
                          print(InvoiceHelper.storid);
                          for(ItstorM s in _itstorVm.items??[]){
                            //print("${s.storid.toString().trim()} , ${storid?.id}");
                            if(s.storid == storid?.id){
                              InvoiceHelper.items?.add(s);
                            }
                          }
                          var _soRefhdrVm = Provider.of<SoRefhdrVM>(context,listen: false);
                          await _soRefhdrVm.GetSohdrs();
                          print(InvoiceHelper.items?.length);
                          Navigator.pop(context);
                          Navigation.puchNav(SoldReturnInvoice(), context);
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ServiceWidget(
                        imahePath: "assets/cust.png",
                        name: "",
                        action: () async {
                          showDialog(context: context, builder: (context) {return const Center(child: CircularProgressIndicator());});
                          await _Emp_Vm.getEmps();
                          await _CitySets_Vm.GetAllCities();
                          await _customerVm.getCustomers();
                          SoldsHelper.cities = _CitySets_Vm.cities;
                          SoldsHelper.employees =_Emp_Vm.Emps;
                          SoldsHelper.Customers = _customerVm.Customers;
                          Navigator.of(context).pop();
                          Navigation.puchNav(CustSettings(), context);
                        },
                      ),
                      ServiceWidget(
                        imahePath: "assets/report.png",
                        name: "",
                        action: () {
                          Navigation.puchNav(SoldReports(), context);
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
