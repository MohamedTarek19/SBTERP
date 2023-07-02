import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Directionality CustomTextField({required IconData icon,required TextEditingController controller,required String name,TextInputType? type}){
  return Directionality(
    textDirection: TextDirection.rtl,
    child: Container(
      margin: EdgeInsets.only(top: 10,bottom: 10),
      decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20)
      ),
      child: TextField(
        keyboardType: type,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
            prefixIcon: Icon(icon),
            border: InputBorder.none,
            hintStyle: TextStyle(),
            hintText: name
        ),
        controller: controller,
        textDirection: TextDirection.rtl,
      ),
    ),
  );
}