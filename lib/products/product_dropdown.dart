import 'dart:core';
import 'dart:core';

import 'package:emart_seller/controller/products_controller.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:velocity_x/velocity_x.dart';

Widget productDropdown(
    hint, List<String> List, dropvalue, ProductsController controller) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: Obx(()=>
       DropdownButtonHideUnderline(
          child: DropdownButton(
        hint: boldText(text: '$hint', color: Colors.black),
        value: dropvalue.value == '' ? null : dropvalue.value,
        isExpanded: true,
        items: List.map((e) {
          return DropdownMenuItem(
            child: e.toString().text.make(),
            value: e,
          );
        }).toList(),
        onChanged: (newValue) {
          if (hint == 'Category') {
            controller.subcategoryvalue.value = '';
            controller.populateSubCategory(newValue.toString());
          }
          dropvalue.value = newValue.toString();
                                              
        },
      )).box.white.rounded.make(),
    ),
  );
}
