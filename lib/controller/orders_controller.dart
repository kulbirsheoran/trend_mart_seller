
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/firebase_const.dart';
import 'package:get/get.dart';

class OrdersController extends GetxController{
 var orders =[];

 var confirmed = false.obs;
 var ondelivery = false.obs;
 var delivered = false.obs;

  getOrders(data){
    orders.clear();
    for(var item in data['orders']) {
     // if(item ['vendor_id'] == currentUser!.uid){
      if(item ['vendor_id'] == 'w0J5ZmutgXbIE7e2hWNNJrl1kDh1'){
    orders.add(item);
  }
    }
  //  print(orders);
  }
  
  changeStatus({title,status,docID})async{
    var store = fireStore.collection(ordersCollection).doc(docID);
    await store.set({
     title:status
    },SetOptions(merge:true));
  }
  

}