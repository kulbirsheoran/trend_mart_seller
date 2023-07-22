import 'package:emart_seller/const/strings.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

Widget CustomTextField({label,hint,controller,isDesc = false}){
  return TextFormField(
    maxLines: isDesc ? 4 : 1,controller: controller,
    decoration: InputDecoration(
      isDense: true,
      label: normalText(text: label),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(
          color: Colors.white
        )
      ),
      focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide(

              color: Colors.white
          ),
      ),
     // hintText: nameHint,
    ),
  );
}