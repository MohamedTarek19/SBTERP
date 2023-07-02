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
import 'package:sbterp/widgets/custom_appbar2.dart';
import 'package:sbterp/widgets/custom_appbar3.dart';
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

class SubGroups extends StatefulWidget {
  const SubGroups({Key? key}) : super(key: key);

  @override
  State<SubGroups> createState() => _SubGroupsState();
}

class _SubGroupsState extends State<SubGroups> {
  var landingInex = 0;
  var currentAppBarText = ['اقسام فرعية'];
  TextEditingController TController = TextEditingController();
  String? MainGroupName;
  String? val = StorTypeHelper.MainGroups![0].gitemdisc;

  AddingMessage(var _groupItem_Vm) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            title: Container(
                child: Text(
                  'إضافة قسم فرعي',
                  style: TextStyle(color: Colors.black, fontSize: 17),
                  textDirection: TextDirection.rtl,
                )),
            content: TextField(
              controller: TController,
              textDirection: TextDirection.rtl,
            ),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    GroubItSubsM newGroups = GroubItSubsM();
                    showDialog(context: context, builder: (context) {return const Center(child: CircularProgressIndicator());});
                    newGroups.gitemsub = TController.text;
                    newGroups.gitemmain = StorTypeHelper.mainGroupVal;
                    await _groupItem_Vm.AddGroup(newGroups);
                    setState(() {
                      StorTypeHelper.TempSubGroups?.add(newGroups);
                    });
                    TController.text = '';
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text('حفظ')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('إلغاء'))
            ],
          );
        });
  }
  RemovingRecord(var _groupItem_Vm,GroubItSubsM item) async {
    return showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(20.0)),
            ),
            title: Container(
                child: Text(
                  'هل تريد حذف هذا القسم',
                  style: TextStyle(color: Colors.black, fontSize: 17),
                  textDirection: TextDirection.rtl,
                )),
            actions: [
              ElevatedButton(
                  onPressed: () async {
                    showDialog(context: context, builder: (context) {return const Center(child: CircularProgressIndicator());});
                    await _groupItem_Vm.deleteGroup(item.gitemid??0);
                    setState(() {
                      StorTypeHelper.TempSubGroups?.remove(item);
                    });
                    Navigator.of(context).pop();
                    Navigator.of(context).pop();
                  },
                  child: Text('حذف')),
              ElevatedButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text('رجوع'))
            ],
          );
        });
  }

  @override
  Widget build(BuildContext context) {
    var _groupItem_Vm = Provider.of<GroupItemSetupsVM>(context,listen: false);
    var _groupSub_Vm = Provider.of<GroubItSubsVM>(context,listen: false);
    return MainContainer(
        widget: Scaffold(
          resizeToAvoidBottomInset: false,
          appBar: CustomAppBar3(currentAppBarText[landingInex], context, [
            IconButton(
                onPressed: () async {
                  await AddingMessage(_groupSub_Vm);
                },
                icon: Icon(Icons.add)),
            IconButton(onPressed: () {}, icon: Icon(Icons.search)),
          ]),
          body: Scaffold(
              resizeToAvoidBottomInset: false,
              body: Stack(children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height,
                  child: SingleChildScrollView(
                    child: Container(
                      width: MediaQuery.of(context).size.width,
                      child: Column(
                        children: [
                          Container(
                            color: Colors.grey,
                            height: 40,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  "اسم القسم الفرعي",
                                  textDirection: TextDirection.rtl,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 19,
                                      fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: MediaQuery.of(context).size.height * 0.8,
                            child: ListView.builder(
                              itemCount: StorTypeHelper.TempSubGroups?.length ?? 0,
                              itemBuilder: (BuildContext context, int index) {
                                return Column(
                                  children: [
                                    ListTile(
                                      title: Row(
                                        mainAxisAlignment: MainAxisAlignment.center,
                                        children: [
                                          Text(StorTypeHelper.TempSubGroups![index].gitemsub ??
                                              'فارغ'),
                                        ],
                                      ),
                                      trailing: Icon(Icons.list),
                                      leading: IconButton(
                                        onPressed: () async {
                                          await RemovingRecord(_groupSub_Vm,StorTypeHelper.TempSubGroups![index]);
                                        },
                                        icon: Icon(Icons.cancel_outlined),
                                        color: Colors.red,
                                      ),
                                    ),
                                    Divider(
                                      height: 2,
                                      indent: 1,
                                      endIndent: 1,
                                      thickness: 1,
                                    )
                                  ],
                                );
                              },
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ])),
        ));
  }
}
