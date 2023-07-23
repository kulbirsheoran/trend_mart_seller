// import 'package:emart_seller/models/category_model.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
//
// class ProductsController extends GetxController{
//
//   var pnameController = TextEditingController();
//   var pdescController = TextEditingController();
//   var ppriceController = TextEditingController();
//   var pquantityController = TextEditingController();
//
//   var categoryList = <String>[].obs;
//   var subcategoryList = <String>[].obs;
//   List<Category> category =[];
//   var pImageList = [].obs;
//
//   var categoryvalue = ''.obs;
//   var subcategoryvalue = ''.obs;
//   var selectedColorIndex = ''.obs;
//
//  getCategories()async{
//
//    var data = await rootBundle.loadString('lib/services/category_model.json');
//    var cat = categoryModelFromJson(data);
//    category = cat.categories;
//
//
//  }
//
//   populateCategoryList(){
//     categoryList.clear();
//     for (var item in category){
//        categoryList.add(item.name);
//
//     }
//   }
//
//   populateSubCategory(cat){
//    subcategoryList.clear();
//
//    var data = category.where((element) => element.name==cat).toList();
//
//    for(var i = 0;i<data.first.subcategory.length;i++){
//      subcategoryList.add(data.first.subcategory[i]);
//    }
//
//   }
// }



import 'dart:io';
//import 'dart:js';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/firebase_const.dart';
import 'package:emart_seller/models/category_model.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:path/path.dart';

import 'home_controller.dart';
class ProductsController extends GetxController {


  var isloading = false.obs;

  var pnameController = TextEditingController();
  var pdescController = TextEditingController();
  var ppriceController = TextEditingController();
  var pquantityController = TextEditingController();

  var categoryList = <String>[].obs;
  var subcategoryList = <String>[].obs;
  List<Category> category = [];
  var pImagesLinks = [];
  //var pImageList = <XFile>[].obs;
  var pImageList = RxList<dynamic>.generate(3, (index) => null);

  var categoryvalue = ''.obs;
  var subcategoryvalue = ''.obs;
  var selectedColorIndex = ''.obs;

  getCategories() async {
    var data = await rootBundle.loadString('lib/services/category_model.json');
    var cat = categoryModelFromJson(data);
    category = cat.categories;
  }

  populateCategoryList() {
    categoryList.clear();
    for (var item in category) {
      categoryList.add(item.name);
    }
  }

  populateSubCategory(cat) {
    subcategoryList.clear();

    var data = category.where((element) => element.name == cat).toList();

    for (var i = 0; i < data.first.subcategory.length; i++) {
      subcategoryList.add(data.first.subcategory[i]);
    }
  }

  pickImage(index,context)async{
   try{
     final img = await ImagePicker().pickImage(source: ImageSource.gallery,imageQuality: 80);

     if(img == null){
       return;
     }
       pImageList[index] = File(img.path);
   }catch(e){
     VxToast.show(context,msg:e.toString());
   }
  }

  uploadImges()async{
    pImagesLinks.clear();
    for(var item in pImageList){
      if(item!=null){
        var filename = basename(item.path);
        var destination = 'images/vendors${currentUser!.uid}/$filename';
        // var destination = 'images/${'Ft0mr3gXa5gzwWRHRpSW'}/$filename';
        Reference ref = FirebaseStorage.instance.ref().child(destination);
        await ref.putFile(item);
        var n = await ref.getDownloadURL();
        pImagesLinks.add(n);
      }
    }
  }

uploadProduct(context)async{
    var store = fireStore.collection(productsCollection).doc();
    await store.set({
      'is_featured' :true,
      'p_category':categoryvalue.value,
      'p_subcategory':subcategoryvalue.value,
    //  'p_colors':FieldValue.arrayUnion([Colors.purple,Colors.red]),
      'p_imgs':FieldValue.arrayUnion(pImagesLinks),
      'p_whishlist':FieldValue.arrayUnion([]),
      'p_description':pdescController.text,
      'p_name':pnameController.text,
      'p_price':ppriceController.text,
      'p_quantity':pquantityController.text,
      'p_seller':Get.find<HomeController>().username,
      'p_rating':'4.0',
      'vendor_id':'MOvGZTfOm7R1yC2VWNoi',
      'featured_id':'',
    });
 isloading(false);
    VxToast.show(context, msg: 'Product uploaded');
}
   addFeatured(docId)async{
   await fireStore.collection(productsCollection).doc(docId).set({

      'featured_id':currentUser!.uid,
      'is_featured':true,
    },SetOptions(merge:true)
    );
   }
  removeFeatured(docId)async{
   await  fireStore.collection(productsCollection).doc(docId).set({

      'featured_id':'',
      'is_featured':false,
    },SetOptions(merge:true)
    );
  }
  removeProduct(docId)async{
    await fireStore.collection(productsCollection).doc(docId).delete();
  }
}
