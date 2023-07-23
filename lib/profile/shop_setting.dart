import 'package:emart_seller/const/strings.dart';
import 'package:emart_seller/controller/profile_controller.dart';
import 'package:emart_seller/widget/custom_textfield.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';

class ShopSettings extends StatelessWidget {
  const ShopSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProfileController>();
    return Obx(()=>
     Scaffold(
        backgroundColor: Colors.blueGrey,
        appBar: AppBar(
           backgroundColor: Colors.red,
          automaticallyImplyLeading: false,
          title: boldText(text: shopsetting, color: Colors.white),
          actions: [
            controller.isLoading.value? CircularProgressIndicator():
            //  IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
            TextButton(
                onPressed: ()async{
                  controller.isLoading(true);
                  await controller.updateShop(
                     shopaddress: controller.shopAddressController.text,
                      shopname: controller.shopNameController.text,
                  shopmobile: controller.shopMobileController.text,
                  shopwebsite: controller.shopWebsiteController.text,
                 shopdesc: controller.shopDescController.text,
                  ) ;
                  VxToast.show(context, msg: 'Shop updated');
                  },
                child: const Text(
                  save,
                  style:
                      TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
                ))
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Column(
                children: [
                  CustomTextField(
                      label: shopname, controller: controller.shopNameController),
                  5.heightBox,
                  CustomTextField(
                      label: address,
                      controller: controller.shopAddressController),
                  5.heightBox,
                  CustomTextField(
                      label: mobile, controller: controller.shopMobileController),
                  5.heightBox,
                  CustomTextField(
                      label: website,
                      controller: controller.shopWebsiteController),
                  5.heightBox,
                  CustomTextField(
                      label: description,
                      isDesc: true,
                      controller: controller.shopDescController),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
