//import 'package:cloud_firestore/cloud_firestore.dart';

//import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:emart_seller/const/firebase_const.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:velocity_x/velocity_x.dart';

class AuthController extends GetxController {
  var emailController = TextEditingController();
  var passwordController = TextEditingController();
  var isLoading = false.obs;


  Future<UserCredential?> loginMethod({context}) async {

    UserCredential? userCredential;
    try {
      userCredential = await auth.signInWithEmailAndPassword(
          email: emailController.text, password: passwordController.text);
      //  userCredential = userCredential.credential;
    } on FirebaseAuthException catch (e) {
      VxToast.show(context, msg: e.toString());
    }
    return userCredential;
  }

  // Future<UserCredential?> signUpMethod({ email, password, context}) async {
  //   UserCredential? userCredential;
  //   try {
  //     userCredential = await auth.createUserWithEmailAndPassword(
  //         email: email, password: password);
  //   } on FirebaseAuthException catch (e) {
  //     VxToast.show(context, msg: e.toString());
  //   }
  //   return userCredential;
  // }

  // storeUserData(
  //     name,
  //     password,
  //     email,
  //     imageUrl,
  //     ) async {
  //  // DocumentReference store =fireStore.collection(vendorsCollection).doc(auth.currentUser!.uid);//await FirebaseFirestore.instance
  //   DocumentReference store =fireStore.collection(vendorsCollection).doc('MOvGZTfOm7R1yC2VWNoi');
  //   // .collection(userCollection)
  //   // .doc(currentUser!.uid);
  //   store.set({
  //     'name': name,
  //     'password': password,
  //     'email': email,
  //     'imageUrl': '',
  //     'id': 'MOvGZTfOm7R1yC2VWNoi',
  //     'cart_count':'00',
  //     'wishlist_count':'00',
  //     'order_count':'00',
  //   });
  // }

  signOutMethod(context) async {
    try {
      await auth.signOut();

    } catch (e) {

      VxToast.show(context, msg: e.toString());
    }
  }
}
