import 'package:emart_seller/const/colors.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget normalText({text,color = Colors.white,size =14.0}){
  return '$text'.text.white.make();
}
Widget boldText({text,color=Colors.white,size=(14.0)}){
  return '$text'.text.fontWeight(FontWeight.bold).color(color).size(size).make();
}