import 'dart:ffi';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/groubitemsetups_m.dart';
import 'package:sbterp/business_logic/model/groubitsubs_m.dart';
import 'package:sbterp/business_logic/model/stortype_m.dart';
import 'package:sbterp/business_logic/view_model/groubitemsetups_vm.dart';
import 'package:sbterp/business_logic/view_model/groubitsubs_vm.dart';
import 'package:sbterp/business_logic/view_model/stortype_vm.dart';
import 'package:sbterp/theme/appthrmr.dart';
import 'package:sbterp/view/accounts/account_daily/daily_reports.dart';
import 'package:sbterp/view/solds/sold_home.dart';
import 'package:sbterp/view/stock/stock_home.dart';
import 'package:sbterp/view/stock/store_type_helper.dart';
import 'package:sbterp/view/stock/sub_groups.dart';
import 'package:sbterp/widgets/custom_appbar2.dart';
import 'package:sbterp/widgets/custom_appbar3.dart';
import 'package:sbterp/widgets/custom_dropdown.dart';
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

class MainGroupSelection extends StatefulWidget {
  const MainGroupSelection({Key? key}) : super(key: key);

  @override
  State<MainGroupSelection> createState() => _MainGroupSelectionState();
}

class _MainGroupSelectionState extends State<MainGroupSelection> {
  var landingInex = 0;
  var currentAppBarText = ['اقسام فرعية'];
  TextEditingController TController = TextEditingController();
  String? MainGroupName;
  String? val; //= StorTypeHelper.MainGroups![0].gitemdisc;

  @override
  Widget build(BuildContext context) {
    var _groupSub_Vm = Provider.of<GroubItSubsVM>(context,listen: false);
    return MainContainer(
        widget: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar3(currentAppBarText[landingInex], context, []),
          body: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(children: [
                Container(
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage("assets/Backkground.jpg"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
                CustomDropDownMenu(
                  Left:5,
                  Right:5,
                  value: null,
                  name: "إختر قسم رئيسي",
                  Width: MediaQuery.of(context).size.width,
                  fun: (String? newValue) {
                    setState(() {
                      print(newValue);
                      MainGroupName = newValue.toString();
                      StorTypeHelper.TempSubGroups = [];
                      StorTypeHelper.mainGroupVal = newValue;
                      for(GroubItSubsM v in _groupSub_Vm.groups??[]){
                        if(v.gitemmain == newValue){
                          StorTypeHelper.TempSubGroups?.add(v);
                        }
                      }
                    });
                    Navigation.puchNav(SubGroups(), context);
                   },
                  items: StorTypeHelper.MainGroups?.map((item) {
                      return DropdownMenuItem(
                        value: item.gitemdisc??'',
                        child: Container(
                            width: MediaQuery.of(context).size.width, // for example
                            child: Text(item.gitemdisc??'', textAlign: TextAlign.center,textDirection: TextDirection.rtl,
                              style: TextStyle(fontSize: 17),)
                        ),
                      );
                    }).toList(),),
              ])),
        ));
  }
}
