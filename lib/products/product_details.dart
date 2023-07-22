import 'package:emart_seller/const/images.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:velocity_x/velocity_x.dart';

class ProductDetails extends StatelessWidget {
  final dynamic data;

  const ProductDetails({Key? key, this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //backgroundColor: Colors.purple,
      appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: const Icon(Icons.arrow_back, color: Colors.black87),
        ),
        title: boldText(
            text: "${data['p_name']}", color: Colors.black87, size: 16.0),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            VxSwiper.builder(
                enlargeCenterPage: true,
                viewportFraction: 1.0,
                autoPlay: true,
                height: 202,
                itemCount: data['p_imgs'].length,
                itemBuilder: (context, index) {
                  return Image.network(
                    //productimg,
                    data['p_imgs'][index],
                    // 'assets/images/boyglass1.jpg',
                    width: double.infinity,
                    fit: BoxFit.cover,
                  );
                }),
            10.heightBox,
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  boldText(
                      text: '${data['p_titel']}',
                      color: Colors.black87,
                      size: 16.0),
                  // title!.text.size(16).black.make(),
                  15.heightBox,
                  Row(
                    children: [
                      boldText(
                          text: "${data['p_category']}",
                          color: Colors.grey,
                          size: 16.0),
                      10.widthBox,
                      boldText(
                          text: "${data['p_subcategory']}",
                          color: Colors.grey,
                          size: 16.0),
                    ],
                  ),
                  10.heightBox,
                  VxRating(
                    // isSelectable: false,
                    // value: double.parse(user['p_rating']),
                    value: double.parse(data['p_rating']),
                    onRatingUpdate: (value) {},
                    normalColor: Vx.white,
                    selectionColor: Colors.yellow,
                    count: 5,
                    size: 25,
                    maxRating: 5,
                    //  stepInt: true,
                  ),
                  10.heightBox,
                  boldText(
                      text: "\$ ${data['p_price']}",
                      color: Colors.red,
                      size: 16.0),
                  // '${user['p_price']}'
                  //   .numCurrency
                  //     .text
                  //     .red500
                  //     .fontWeight(FontWeight.bold)
                  //     .make(),
                  20.heightBox,

                  Column(
                    children: [
                      Row(children: [
                        SizedBox(
                            width: 100,
                            child:
                                boldText(text: 'color', color: Colors.black)),
                        Row(
                            children: List.generate(
                          data['p_colors'].length,
                          (index) => VxBox()
                              .size(40, 40)
                              .roundedFull
                             .color(Color(data['p_colors'][index]))
                              // .color(Vx.randomPrimaryColor)
                              // .withOpacity(1.0))
                              .margin(const EdgeInsets.symmetric(horizontal: 4))
                              .make()
                              .onTap(() {
                            // controller.colorIndex.value = index;
                          }),
                        ))
                      ])
                          .box
                          .padding(const EdgeInsets.symmetric(horizontal: 8))
                          .make(),
                    ],
                  ),
                  5.heightBox,
                  Row(children: [
                    SizedBox(
                        width: 100,
                        child: boldText(text: 'Quantity', color: Colors.black)),
                    boldText(text: '${data['p_quantity']}', color: Colors.black)
                  ])
                      .box
                      .padding(const EdgeInsets.symmetric(horizontal: 8))
                      .make(),
                  const Divider(),
                  10.heightBox,
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: boldText(
                        text: 'Description ', color: Colors.black),

                  ),
                  10.heightBox,
                  boldText(text: '${data['p_description']}',color: Colors.black),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
