import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/firebase_const.dart';
import 'package:emart_seller/const/images.dart';
import 'package:emart_seller/const/strings.dart';
import 'package:emart_seller/products/product_details.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/widget/appbar_widget.dart';
import 'package:emart_seller/widget/dashboard_button.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart' as intl;
import 'package:velocity_x/velocity_x.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: AppBarWidget(dashboard),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: dashboard,color: Colors.grey),
        actions: [Center(child: boldText(text:intl.DateFormat().format(DateTime.now()),color: Colors.grey))],
      ),
    body: StreamBuilder(
      stream: StoreServices.getProducts(currentUser!.uid),

      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if(!snapshot.hasData){
          return Center(child: CircularProgressIndicator());
        }
        else{
          var data = snapshot.data!.docs;
          
         data = data!.sortedBy((a, b) => b['p_whishlist'].length.compareTo(a['p_whishlist'].length));
          print(data);
          
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    dashboardButton(
                        context,title: product,count: '${data.length}',icon: product1,
                    ),
                    Card(
                      child: dashboardButton(
                          context,title: orders,count: '24',icon: orderimg
                      ),
                    ),
                  ],
                ),
                10.heightBox,
                Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    dashboardButton(
                        context,title: rating,count: '50',icon: starimg
                    ),
                    dashboardButton(
                        context,title: total,count: '24',icon: totalimg
                    ),
                  ],
                ),
                10.heightBox,
                Divider(),
                10.heightBox,
                boldText(text: popular,color: Colors.grey,size: 16.0),

                20.heightBox,
                ListView(
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  children: List.generate(data.length, (index) =>data[index]['p_whishlist'].length ==0?SizedBox():
                      ListTile(
                    onTap: (){
                      Get.to(()=>ProductDetails(data: data[index],));
                    },
                    leading: Image.network(data[index]['p_imgs'][0],width: 100,height: 100,fit: BoxFit.cover,),
                    title: boldText(text:'${data[index]['p_name']}',color: Colors.black ),
                    subtitle: boldText(text: '\$${data[index]['p_price']}',color: Colors.grey),
                  )),
                )

              ],
            ),
          );
        }

      },
    ),

    // body: Padding(
    //   padding: const EdgeInsets.all(8.0),
    //   child: Column(crossAxisAlignment: CrossAxisAlignment.start,
    //     children: [
    //       Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         children: [
    //           dashboardButton(
    //             context,title: product,count: '50',icon: product1
    //           ),
    //           dashboardButton(
    //               context,title: orders,count: '24',icon: orderimg
    //           ),
    //         ],
    //       ),
    //       10.heightBox,
    //       Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
    //         children: [
    //           dashboardButton(
    //               context,title: orders,count: '50',icon: starimg
    //           ),
    //           dashboardButton(
    //               context,title: total,count: '24',icon: totalimg
    //           ),
    //         ],
    //       ),
    //       10.heightBox,
    //       Divider(),
    //       10.heightBox,
    //       boldText(text: popular,color: Colors.grey,size: 16.0),
    //
    //       20.heightBox,
    //       ListView(
    //         physics: BouncingScrollPhysics(),
    //         shrinkWrap: true,
    //         children: List.generate(3, (index) =>ListTile(
    //           onTap: (){},
    //           leading: Image.asset(productimg,width: 100,height: 100,fit: BoxFit.cover,),
    //           title: boldText(text:'Product title',color: Colors.black ),
    //           subtitle: boldText(text: '\$50.0',color: Colors.grey),
    //         )),
    //       )
    //
    //     ],
    //   ),
    // ),
    );
  }
}
