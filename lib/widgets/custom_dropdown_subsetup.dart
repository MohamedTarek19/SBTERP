import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/customer_m.dart';
import 'package:sbterp/business_logic/model/supsetups_m.dart';


Container CustomDropDownMenuSuppliers({required double Width, String? name,required SubSetupsM? value,required double Left,required double Right,
  required fun(SubSetupsM? va),
  required List<DropdownMenuItem<SubSetupsM?>>? items,double? circularity}){
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
            child: DropdownButton<SubSetupsM?>(
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