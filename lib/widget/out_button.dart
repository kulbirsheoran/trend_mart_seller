import 'package:emart_seller/const/colors.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget ourButton({title, color = purple, onPress}) {
  return ElevatedButton(style: ElevatedButton.styleFrom(
    primary: color
  ),
      onPressed: onPress, child: boldText(text: title, size: 16.0));
}
