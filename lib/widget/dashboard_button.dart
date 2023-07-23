import 'package:emart_seller/const/images.dart';
import 'package:emart_seller/const/strings.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget dashboardButton(context,{title,count,icon}){
  var size = MediaQuery.of(context).size;
  return     Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
      Padding(
        padding: const EdgeInsets.only(left: 8.0),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            boldText(text: title,),
            boldText(text: count,),
          ],
        ),
      ),

     // SizedBox( width: 30,),
      Image.asset(icon,color: Colors.white ,width: 40,height: 40,fit:BoxFit.fill).box.roundedSM.clip(Clip.antiAlias).make()
    ],

  ).box.color(Colors.purple).rounded.p8.size(size.width*0.4, 70).make();

}