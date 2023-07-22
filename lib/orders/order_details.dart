import 'package:emart_seller/const/strings.dart';
import 'package:emart_seller/controller/orders_controller.dart';
import 'package:emart_seller/widget/out_button.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;
import 'order_place.dart';

class OrderDetails extends StatefulWidget {
  final dynamic data;

  const OrderDetails({Key? key, this.data}) : super(key: key);

  @override
  State<OrderDetails> createState() => _OrderDetailsState();
}

class _OrderDetailsState extends State<OrderDetails> {
  var controller = Get.find<OrdersController>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.getOrders(widget.data);
    controller.confirmed.value = widget.data['order_confirmed'];
    controller.ondelivery.value = widget.data['order_on_delivery'];
    controller.delivered.value = widget.data['order_delivered'];
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black87,
              ),
              onPressed: () {
                Get.back();
              }),
          title: boldText(text: 'Order details', color: Colors.black87),
        ),
        bottomNavigationBar: SizedBox(
          height: 50,
          width: context.screenWidth,
          child: Visibility(
            visible: !controller.confirmed.value,
            child: ourButton(
                title: confirmorder,
                color: Colors.purple,
                onPress: () {
                  controller.confirmed(true);
                  controller.changeStatus(
                      title: 'order_confirmed',
                      status: true,
                      docID: widget.data.id);
                }),
          ),
        ),
        body: ListView(
          children: [
            Column(
              children: [
                Visibility(
                  visible: controller.confirmed.value,
                  child: Column(
                    children: [
                      boldText(text: 'Order Status', color: Colors.black87),
                      SwitchListTile(
                        activeColor: Colors.purple,
                        value: true,
                        onChanged: (value) {},
                        title: boldText(text: 'Placed', color: Colors.grey),
                      ),
                      SwitchListTile(
                        activeColor: Colors.purple,
                        value: controller.confirmed.value,
                        onChanged: (value) {
                          controller.confirmed.value = value;
                        },
                        title: boldText(text: 'Confirmed', color: Colors.grey),
                      ),
                      SwitchListTile(
                        activeColor: Colors.purple,
                        value: controller.ondelivery.value,
                        onChanged: (value) {
                          controller.ondelivery.value = value;
                         // controller.confirmed(true);
                          controller.changeStatus(
                              title: 'order_on_delivery',
                              status: value,
                              docID: widget.data.id);
                        },
                        title:
                            boldText(text: 'on Delivery', color: Colors.grey),
                      ),
                      SwitchListTile(
                        activeColor: Colors.purple,
                        value: controller.delivered.value,
                        onChanged: (value) {
                          controller.delivered.value = value;
                         // controller.confirmed(true);
                          controller.changeStatus(
                              title: 'order_delivered',
                              status: value,
                              docID: widget.data.id);
                        },
                        title: boldText(text: 'Delivered', color: Colors.grey),
                      )
                    ],
                  )
                      .box
                      .rounded
                      .padding(const EdgeInsets.all(8))
                      .make()
                      .color(Colors.white)
                      .card
                      .make(),
                ),
                const Divider(),
                10.heightBox,
                Column(
                  children: [
                    orderPlaceDetails(
                      d1: "${widget.data['order_code']}",
                      d2: "${widget.data['shipping_method']}",
                      title1: 'Order Code',
                      title2: 'Shipping Method',
                    ),
                    orderPlaceDetails(
                      //d1: DateTime.now(),
                      // d1:data['order_date'].toDate(),
                      d1: intl.DateFormat()
                          .add_yMd()
                          .format((widget.data['order_date'].toDate())),
                      d2: "${widget.data['payment_method']}",
                      title1: 'Order Date',
                      title2: 'Payment Method',
                    ),
                    orderPlaceDetails(
                      d1: 'Unpaid',
                      d2: 'Order Placed',
                      title1: 'Payment Status',
                      title2: 'Delivery Status',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                'Shipping Address'
                                    .text
                                    .fontWeight(FontWeight.bold)
                                    .make(),
                                "${widget.data['order_by_name']}"
                                    .text
                                    .color(Colors.red)
                                    .make(),
                                "${widget.data['order_by_email']}"
                                    .text
                                    .color(Colors.red)
                                    .make(),
                                "${widget.data['order_by_address']}"
                                    .text
                                    .color(Colors.red)
                                    .make(),
                                "${widget.data['order_by_city']}"
                                    .text
                                    .color(Colors.red)
                                    .make(),
                                "${widget.data['order_by_state']}"
                                    .text
                                    .color(Colors.red)
                                    .make(),
                                "${widget.data['order_by_phone']}"
                                    .text
                                    .color(Colors.red)
                                    .make(),
                                "${widget.data['order_by_postalCode']}"
                                    .text
                                    .color(Colors.red)
                                    .make(),
                              ],
                            ).box.rounded.make().card.make()),

                        //Divider(thickness: 3,color: Colors.black87),
                        SizedBox(
                          width: 130,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              'Total Amount'
                                  .text
                                  .color(Colors.black)
                                  .fontWeight(FontWeight.bold)
                                  .make(),
                              "\$${widget.data['total_amount']}"
                                  .text
                                  .color(Colors.red)
                                  .make(),
                            ],
                          ),
                        ),
                      ],
                    )
                  ],
                ).box.outerShadowSm.white.make().card.make(),
                const Divider(),
                10.heightBox,
                'Ordered Product'
                    .text
                    .fontWeight(FontWeight.bold)
                    .size(16)
                    .make()
                    .card
                    .white
                    .make(),
                10.heightBox,
                ListView(
                  shrinkWrap: true,
                  children: List.generate(controller.orders.length, (index) {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        orderPlaceDetails(
                          title1: "${controller.orders[index]['titel']}",
                          title2: "\$${controller.orders[index]['tprice']}",
                          d1: "Quantity ${controller.orders[index]['qty']}",
                          d2: 'Refundable',
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Container(
                            width: 30,
                            height: 10,
                            color: Color(controller.orders[index]['color']),
                          ),
                        ),
                        const Divider()
                      ],
                    );
                  }).toList(),
                )
                    .box
                    .outerShadowSm
                    .white
                    .margin(const EdgeInsets.only(bottom: 4))
                    .make(),
                10.heightBox,
              ],
            ),
          ],
        ),
      ),
    );
  }
}
