import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget ChatBubble(){
  return   Directionality(
    textDirection:TextDirection.ltr,
    //textDirection: data['uid'] == currentUser!.uid? TextDirection.rtl:TextDirection.ltr,
    child: Container(
      padding: EdgeInsets.all(12),
      margin: EdgeInsets.only(bottom: 8),
      decoration: BoxDecoration(
          //color: data['uid'] == currentUser!.uid? Colors.red:Colors.grey,
color: Colors.purple,
          borderRadius: BorderRadius.only(topLeft: Radius.circular(20),topRight: Radius.circular(20),bottomLeft:Radius.circular(20),)
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
         // '${data['msg']}'.text.white.size(16).make(),
          boldText(text: 'Your messages here...'),
          10.heightBox,
         // time.text.color(Colors.white.withOpacity(0.5)).make()
          boldText(text: '10:45 Pm')
        ],
      ),
    ),
  );
}