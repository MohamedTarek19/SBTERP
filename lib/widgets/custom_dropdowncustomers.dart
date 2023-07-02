import 'dart:ui' as ui;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:sbterp/business_logic/model/customer_m.dart';


Container CustomDropDownMenuCustomers({required double Width, String? name,required CustomerM? value,required double Left,required double Right,
  required fun(CustomerM? va),
  required List<DropdownMenuItem<CustomerM?>>? items,double? circularity}){
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
            child: DropdownButton<CustomerM?>(
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