import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/firebase_const.dart';

class StoreServices {
  static getProfile(uid) {
    return fireStore
        .collection(vendorsCollection)
        .where('id', isEqualTo: 'MOvGZTfOm7R1yC2VWNoi')
        .get();
  }

  static getMessages (uid){
    return fireStore.collection(chatsCollection).where('toId',isEqualTo:'w0J5ZmutgXbIE7e2hWNNJrl1kDh1' ).snapshots();
  }
 static getOrders(uid){
    return fireStore.collection(ordersCollection).where('vendors',arrayContains: 'w0J5ZmutgXbIE7e2hWNNJrl1kDh1').snapshots();
 }
 static getProducts(uid){
    return fireStore.collection(productsCollection).where('vendor_id',isEqualTo: 'MOvGZTfOm7R1yC2VWNoi').snapshots();
 }


 }

// class StoreServices {
//   static getProfile(uid) {
//     return FirebaseFirestore.instance
//         .collection(vendorsCollection)
//       // .doc(currentUser!.uid)
//       .doc('MOvGZTfOm7R1yC2VWNoi')
//          .snapshots();
//
//   }
// }
