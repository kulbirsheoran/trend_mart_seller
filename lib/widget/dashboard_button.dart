import 'package:emart_seller/const/images.dart';
import 'package:emart_seller/const/strings.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget dashboardButton(context,{title,count,icon}){
  var size = MediaQuery.of(context).size;
  return     Row(
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 2.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            boldText(text: title),
            boldText(text: count),
          ],
        ),
      ),

      SizedBox( width: 25,),
      Image.asset(icon,width: 40,)
    ],

  ).box.color(Colors.purple).rounded.size(size.width*0.4, 80).make();

}