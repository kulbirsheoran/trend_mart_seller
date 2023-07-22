import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget productImages({required label,onPress,}){
  return '$label'.text.bold.color(Colors.black).makeCentered().box.color(Colors.white).size(100, 100).roundedSM.make();
}