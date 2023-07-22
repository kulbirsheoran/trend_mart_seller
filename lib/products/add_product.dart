import 'package:emart_seller/const/strings.dart';
import 'package:emart_seller/controller/products_controller.dart';
import 'package:emart_seller/products/product_dropdown.dart';
import 'package:emart_seller/products/product_images.dart';
import 'package:emart_seller/widget/custom_textfield.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.find<ProductsController>();

    //comment wala usne kiya tha
// var controller = Get.find<ProductsController>();
    return Obx(()=>
       Scaffold(
        backgroundColor: Colors.purple,
        appBar: AppBar(
          leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
              size: 16.0,
            ),
          ),
          title: boldText(text: 'Add product', color: Colors.black, size: 16.0),
          actions: [
            controller.isloading.value ? const Center(child: CircularProgressIndicator(valueColor:  AlwaysStoppedAnimation((Colors.cyan)),)):
            TextButton(
                onPressed: ()async {
                   controller.isloading(true);
                  await controller.uploadImges();
                  await controller.uploadProduct(context);
                  Get.back();

                },
                child: boldText(text: save, color: Colors.black, size: 16.0))
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextField(
                  label: 'Product name', controller: controller.pnameController),
              10.heightBox,
              CustomTextField(
                  label: description,
                  isDesc: true,
                  controller: controller.pdescController),
              10.heightBox,
              CustomTextField(
                  hint: '\$100',
                  label: 'Price',
                  controller: controller.ppriceController),
              10.heightBox,
              CustomTextField(
                  label: description, controller: controller.pdescController),
              10.heightBox,
              CustomTextField(
                  label: "Quantity", controller: controller.pquantityController),
              5.heightBox,
              productDropdown("Category", controller.categoryList.value,
                  controller.categoryvalue, controller),
              5.heightBox,
              productDropdown('Subcategory', controller.subcategoryList.value,
                  controller.subcategoryvalue, controller),
              5.heightBox,
              const Divider(
                color: Colors.white,
              ),
              boldText(text: 'Choose product images'),
              5.heightBox,
              Obx(
                () => Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: List.generate(
                      3,
                      (index) => controller.pImageList[index] != null
                          ? Image.file(controller.pImageList[index],width:100).onTap(() {controller.pickImage(index, context); })
                          : productImages(label: "${index + 1}").onTap(() {
                              controller.pickImage(index, context);
                            })),
                ),
              ),
              5.heightBox,
              boldText(text: 'First image will be your display image'),
              5.heightBox,
              const Divider(
                color: Colors.white,
              ),
              boldText(text: 'Choose product colors'),
              5.heightBox,
              Obx(
                () => Wrap(
                  spacing: 8.0,
                  runSpacing: 8.0,
                  children: List.generate(
                      9,
                      (index) => Stack(
                            alignment: Alignment.center,
                            children: [
                              VxBox()
                                  .color(Vx.randomPrimaryColor)
                                  .roundedFull
                                  .size(50, 50)
                                  .make()
                                  .onTap(() {
                                controller.selectedColorIndex.value =
                                    index.toString()  ;
                              }),
                              controller.selectedColorIndex.value == index
                                  ? const Icon(
                                      Icons.done,
                                      color: Colors.white,
                                    )
                                  : SizedBox()
                            ],
                          )),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
