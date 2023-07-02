 import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/groubitemsetups_m.dart';
import 'package:sbterp/view/stock/store_type_helper.dart';

Container CustomDropDownMenu({required double Width, String? name,required String? value,required double Left,required double Right,
  required fun(String? va),
  required List<DropdownMenuItem<String?>>? items,double? circularity}){
  return Container(
    width: Width,
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top:10,bottom: 10,left: Left,right: Right),
            decoration: BoxDecoration(
                color:Colors.white,
                borderRadius: BorderRadius.circular(circularity??20)
            ),
            child: DropdownButton<String?>(
              hint: Center(child: Text(name??'')),
              underline: SizedBox(),
              elevation: 10,
              isExpanded: true,
              value: value,
              icon: const Icon(Icons.arrow_drop_down),
              items: items,
              onChanged: fun,
            ),
          ),
        ],
      ),
    ),
  );
}