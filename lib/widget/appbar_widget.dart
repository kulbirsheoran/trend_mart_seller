import 'package:emart_seller/const/strings.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart' as intl;


Widget AppBarWidget( dashboard, { title}){
  return   AppBar(
  automaticallyImplyLeading: false,
  title: boldText(text: title,color: Colors.grey),
  actions: [Center(child: boldText(text:intl.DateFormat().format(DateTime.now()),color: Colors.grey))],
  );
}
