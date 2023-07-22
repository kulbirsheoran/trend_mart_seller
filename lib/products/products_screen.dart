import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/colors.dart';
import 'package:emart_seller/const/firebase_const.dart';
import 'package:emart_seller/const/images.dart';
import 'package:emart_seller/const/strings.dart';
import 'package:emart_seller/controller/products_controller.dart';
import 'package:emart_seller/lists.dart';
import 'package:emart_seller/products/add_product.dart';
import 'package:emart_seller/products/product_details.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

class ProductsScreen extends StatelessWidget {
  const ProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProductsController());

    return Scaffold(
      floatingActionButton: FloatingActionButton(
      //  backgroundColor: Colors.purple,
        onPressed: () async{

          await controller.getCategories();
          controller.populateCategoryList();

          Get.to(()=>const AddProduct());
        },
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: boldText(text: product, color: Colors.grey),
        actions: [
          Center(
              child: boldText(
                  text: intl.DateFormat().format(DateTime.now()),
                  color: Colors.grey))
        ],
      ),

      body:  StreamBuilder(
        stream: StoreServices.getProducts(currentUser!.uid),
        builder: (BuildContext context,AsyncSnapshot<QuerySnapshot> snapshot){
          if(!snapshot.hasData){
            return const CircularProgressIndicator();
          }
          else{
            var  data = snapshot.data!.docs;
            return  Padding(
              padding: const EdgeInsets.all(8.0),
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                    children: List.generate(
                        data.length,
                        (index) => Card(
                          child: ListTile(
                                onTap: () {
                                  Get.to(()=>ProductDetails(data: data[index],));

                                },
                                leading: Image.network(
                                  '${data[index]['p_imgs'][0]}',
                                  width: 100,
                                  height: 100,
                                  fit: BoxFit.cover,
                                ),
                                title: boldText(
                                    text: '${data[index]['p_name']}', color: Colors.black),
                                subtitle: Row(
                                  children: [
                                    boldText(text:'\$${data[index]['p_price']}',color: Colors.grey),
                                    10.widthBox,
                                    boldText(text: '${data[index]['is_featured']}'== true? 'Featured':'',color: Colors.purple)
                                  ],
                                ),
                                trailing: VxPopupMenu(
                                  arrowSize: 0.0,
                                    menuBuilder: () => Column(
                                          children:
                                            List.generate(popupMenuTitles.length, (i) => SizedBox(
                                              child: Padding(
                                                padding: const EdgeInsets.all(12.0),
                                                child: Row(
                                                  children: [
                                                  Icon(
                                                 popupMenuIcons[i] ,

                                                    color:data[index]['featured_id']== 'MOvGZTfOm7R1yC2VWNoi && i==0 ' ? Colors.green:Colors.grey,
                                                ),
                                                    10.widthBox,
                                                    boldText(text:data[index]['featured_id'] == 'MOvGZTfOm7R1yC2VWNoi' && i==0 ?'Remove featured' :popupMenuTitles[i],color:Colors.black)
                                                  ],
                                                ).onTap(() {
                                                  if(data[index]['is_featured']==true){
                                                    controller.removeFeatured(data[index].id);
                                                    VxToast.show(context, msg: 'Remove');
                                                  }else{
                                                    controller.addFeatured(data[index].id);
                                                    VxToast.show(context, msg: 'Added');
                                                  }

                                                }),
                                              ),
                                            ))

                                        ).box.white.rounded.width(200).make(),
                                    clickType: VxClickType.singleClick,
                                  child: const Icon(Icons.more_vert_rounded)),
                              ),
                        ))),
              ),
            );
          }
        },
      ),


    );
  }
}
