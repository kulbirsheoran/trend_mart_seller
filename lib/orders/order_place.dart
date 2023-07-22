import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';

Widget orderPlaceDetails({ d2, d1,  title1,   title2}){
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 8.0,vertical: 8),
    child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            boldText(text: '$title1',color: Colors.purple),
            boldText(text: '$d1',color: Colors.red),

          ],
        ),
        SizedBox(
          width: 130,
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              boldText(text: '$title2',color: Colors.purple),
              boldText(text: '$d2',color: Colors.red),



            ],
          ),
        )
      ],
    ),
  );
}