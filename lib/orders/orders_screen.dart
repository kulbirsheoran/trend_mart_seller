
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/firebase_const.dart';
import 'package:emart_seller/const/images.dart';
import 'package:emart_seller/const/strings.dart';
import 'package:emart_seller/controller/orders_controller.dart';
import 'package:emart_seller/orders/order_details.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;



class OrdersScreen extends StatelessWidget {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller =Get.put(OrdersController()) ;
    return  Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: orders,color: Colors.grey),
        actions: [Center(child: boldText(text:intl.DateFormat().format(DateTime.now()),color: Colors.grey))],
      ),
      body: StreamBuilder(
        stream: StoreServices.getOrders(auth.currentUser!.uid),

        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
         if(!snapshot.hasData){
           return CircularProgressIndicator();
         }else{
           var data = snapshot.data!.docs;

        return  Padding(
             padding: const EdgeInsets.all(8.0),
             child: SingleChildScrollView(
               physics: BouncingScrollPhysics(),
               child: Column(
                   children:List.generate(data.length, (index)  {
                     var time = data[index]['order_date'].toDate();
                  return ListTile(
                   onTap: (){
                   Get.to(()=>OrderDetails(data: data[index]));
                   },
                     tileColor: Colors.grey,
                     shape: RoundedRectangleBorder(
                       borderRadius: BorderRadius.circular(12),
                     ),
                     //  leading: Image.asset(productimg,width: 100,height: 100,fit: BoxFit.cover,),
                     title: boldText(text:'${data[index]['order_code']}',color: Colors.purple),
                     subtitle: Column(
                       children: [
                         Row(
                           children: [
                             Icon(Icons.calendar_month),
                             5.widthBox,
                             boldText(text: intl.DateFormat().add_yMd().format(DateTime.now()),color: Colors.black87),

                           ],
                         ),
                         Row(
                           children: [
                             Icon(Icons.payment),
                             5.widthBox,
                             boldText(text: unpaid,color: Colors.red),

                           ],
                         ),
                       ],
                     ),
                     trailing: boldText(text: '${data[index]['total_amount']}',color: Colors.purple,size: 16.0),
                   ).box.margin(EdgeInsets.only(bottom: 4)).make();
                   }
          )


               ),
             ),
           );}
         }
    )
    );
  }
}