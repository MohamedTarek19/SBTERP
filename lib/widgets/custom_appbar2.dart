import 'package:flutter/material.dart';

AppBar CustomAppBar2( String title,BuildContext context)
{
  return  AppBar(
    elevation: 0,
    title: Text(
      title,
      style: Theme.of(context).textTheme.headline2,
    ),
    flexibleSpace: Container(
      decoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: <Color>[Color.fromRGBO(41, 9, 12, 1.0)
                , Color.fromRGBO(60, 20, 12, 1.0)])),
    ),
    centerTitle: true,
  );
}