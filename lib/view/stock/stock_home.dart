import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/view_model/groubitemsetups_vm.dart';
import 'package:sbterp/business_logic/view_model/groubitsubs_vm.dart';
import 'package:sbterp/business_logic/view_model/itstor_vm.dart';
import 'package:sbterp/business_logic/view_model/stortype_vm.dart';
import 'package:sbterp/view/stock/add_permission.dart';
import 'package:sbterp/view/stock/deffict_permission.dart';
import 'package:sbterp/view/stock/main_group_selection.dart';
import 'package:sbterp/view/stock/main_groups.dart';
import 'package:sbterp/view/stock/reports/reports.dart';
import 'package:sbterp/view/stock/sell_permission.dart';
import 'package:sbterp/view/stock/stock_transfer.dart';
import 'package:sbterp/view/stock/store_setting.dart';
import 'package:sbterp/view/stock/store_type_helper.dart';
import 'package:sbterp/view/stock/sub_groups.dart';
import 'package:sbterp/view/stock/types_stock.dart';

import 'package:sbterp/widgets/main_container.dart';
import 'package:sbterp/utils/navigation.dart';
import 'package:sbterp/theme/appthrmr.dart';
import 'package:provider/provider.dart';
import '../../utils/navigation.dart';

import '../../widgets/service_widget.dart';
import '../../widgets/snackbar.dart';

class StockHome extends StatelessWidget {
  const StockHome({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var _StorType_Vm = Provider.of<StortypeVM>(context,listen: false);
    var _GroupSet_Vm = Provider.of<GroupItemSetupsVM>(context,listen: false);
    var _GroupSubs_Vm = Provider.of<GroubItSubsVM>(context,listen: false);
    var _Itstor_Vm = Provider.of<ItstorVM>(context,listen: false);
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
                    imahePath: "assets/poin.png",
                    name: "",
                    action: () {

                      Navigation.puchNav(AddingPermission(), context);
                    },
                  ),
                  ServiceWidget(
                    imahePath: "assets/soin.png",
                    name: "",
                    action: () {

                      Navigation.puchNav(SellingPermission(), context);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ServiceWidget(
                    imahePath: "assets/Sttrans.png",
                    name: "",
                    action: () {
                      Navigation.puchNav(StockTransfer(), context);
                    },
                  ),
                  ServiceWidget(
                    imahePath: "assets/dmg.png",
                    name: "",
                    action: () {
                      Navigation.puchNav(DeffictPermission(), context);
                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ServiceWidget(
                    imahePath: "assets/Ststor.png",
                    name: "",
                    action: () async {
                      showDialog(context: context, builder: (context) {return const Center(child: CircularProgressIndicator());});
                      await _StorType_Vm.GetAllStores();
                      StorTypeHelper.stores = _StorType_Vm.stores;
                      Navigator.pop(context);
                      Navigation.puchNav(StoreSettings(), context);

                    },
                  ),
                  ServiceWidget(
                    imahePath: "assets/Stgroub.png",
                    name: "",
                    action: () async {
                      showDialog(context: context, builder: (context) {return const Center(child: CircularProgressIndicator());});
                      await _GroupSet_Vm.GetAllGroups();
                      StorTypeHelper.MainGroups = _GroupSet_Vm.groups;
                      Navigator.pop(context);
                      Navigation.puchNav(MainGroups(), context);

                    },
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ServiceWidget(
                    imahePath: "assets/Stsub.png",
                    name: "",
                    action: () async {
                      showDialog(context: context, builder: (context) {return const Center(child: CircularProgressIndicator());});
                      await _GroupSet_Vm.GetAllGroups();
                      StorTypeHelper.MainGroups = _GroupSet_Vm.groups;
                      await _GroupSubs_Vm.GetAllGroups();
                      Navigator.pop(context);
                      Navigation.puchNav(MainGroupSelection(), context);
                    },
                  ),
                  ServiceWidget(
                    imahePath: "assets/Stitem.png",
                    name: "",
                    action: () async {
                      showDialog(context: context, builder: (context) {return const Center(child: CircularProgressIndicator());});
                      await _StorType_Vm.GetAllStores();
                      StorTypeHelper.stores = _StorType_Vm.stores;
                      await _Itstor_Vm.GetAllItems();
                      StorTypeHelper.StoreItems = _Itstor_Vm.items;
                      await _GroupSet_Vm.GetAllGroups();
                      StorTypeHelper.MainGroups = _GroupSet_Vm.groups;
                      Navigator.pop(context);
                      Navigation.puchNav(TypesStock(), context);
                    },
                  ),
                ],
              ),
              Container(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [

                    Expanded(
                      flex: 1,
                      child: GestureDetector(
                        onTap: (){
                          Navigation.puchNav(StockReports(), context);
                        },
                        child: Container(
                          margin: AppTheme.marginall,
                          padding: AppTheme.paddingall,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(AppTheme.borderradiu3),
                              border: Border.all(color: AppTheme.mainColor, width: 1)),
                          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                            Image.asset(
                              "assets/report.png",
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
              ),
            ],
          ),
        ),
      ],
    ));
  }
}
