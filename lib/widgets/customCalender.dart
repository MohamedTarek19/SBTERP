import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;
import 'dart:io';

Directionality CustomInputCalender({required IconData? Icn,required DateTime? controller,required String name,TextInputType? type,Function()? onTap,Function(TapDownDetails)? onTapDown,Color? color}){
  //Color? color = Color.fromRGBO(240, 240, 240, 1);

  return Directionality(
    textDirection: ui.TextDirection.rtl,
    child: GestureDetector(
      onTapDown: onTapDown,
      onTap: onTap,
      child: Container(
        margin: EdgeInsets.only(top: 10,bottom: 10,left: 10,right: 10),
        padding: EdgeInsets.only(right: 10),
        decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(10)
        ),
        child: SizedBox(
          height: 45,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(child: Icon(Icn,size: 30,color: color,)),
              Expanded(
                child: Center(
                  child: Container(
                      margin:EdgeInsets.only(right: 20),
                      child: SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Text(name,style: TextStyle(fontSize: 20), textDirection:  ui.TextDirection.rtl,),
                      )
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    ),
  );
}