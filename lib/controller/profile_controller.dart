// //
// //
// //
// //
// // import 'dart:io';
// //
// // import 'package:cloud_firestore/cloud_firestore.dart';
// // import 'package:emart_seller/const/firebase_const.dart';
// // import 'package:firebase_auth/firebase_auth.dart';
// // import 'package:firebase_storage/firebase_storage.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter/services.dart';
// // import 'package:get/get.dart';
// // import 'package:image_picker/image_picker.dart';
// // import 'package:velocity_x/velocity_x.dart';
// // import 'package:path/path.dart';
// //
// // class ProfileController extends GetxController{
// //  late DocumentSnapshot snapshotData;
// //  // var nameController = T
// //   var profileImgPath = ''.obs;
// //   var profileImageLink ='';
// //   var isLoading = false.obs;
// //
// //   var nameController = TextEditingController();
// // //var emailController = TextEditingController();
// //   var oldpassController = TextEditingController();
// //   var newpassController = TextEditingController();
// //
// //
// //   changeImage(context)async{
// //     try{
// //       final img = await ImagePicker().pickImage(source:ImageSource.gallery,imageQuality: 70);
// //       if(img == null)return;
// //       profileImgPath.value= img.path;
// //     }on PlatformException catch(e){
// //       VxToast.show(context, msg: (e.toString()));
// //     }
// //   }
// //   uploadProfileImage() async {
// //     var filename = basename(profileImgPath.value);
// //     var destination ='images/${currentUser!.uid}/$filename';
// //     Reference ref = FirebaseStorage.instance.ref().child(destination);
// //     await ref.putFile(File(profileImgPath.value));
// //     profileImageLink = await ref.getDownloadURL();
// //   }
// //   updateProfile({name,password,imgUrl})async{
// //     var store = fireStore.collection(vendorsCollection).doc(auth.currentUser!.uid);
// //     await store.set({
// //       'name':name,
// //       'password':password,
// //       'imageUrl':imgUrl
// //
// //     },SetOptions(merge: true));
// //     isLoading(false);
// //   }
// //   changeAuthPassword({email,password,newpassword})async{
// //     final cred = EmailAuthProvider.credential(email: email, password: password);
// //     await auth.currentUser!.reauthenticateWithCredential(cred).then((value){auth.currentUser!.updatePassword(newpassword);
// //     }).catchError((error){
// //       print(error.toString());
// //     });
// //
// //   }
// // }
// import 'dart:io';
//
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:emart_seller/const/firebase_const.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:firebase_storage/firebase_storage.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/services.dart';
// import 'package:get/get.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:velocity_x/velocity_x.dart';
// import 'package:path/path.dart';
//
// class ProfileController extends GetxController {
//   late QueryDocumentSnapshot snapshotData  ;  // Initialization added here
//   var profileImgPath = ''.obs;
//   var profileImageLink = '';
//   var isLoading = false.obs;
//
//   var nameController = TextEditingController();
//   var oldpassController = TextEditingController();
//   var newpassController = TextEditingController();
//
//   changeImage(context) async {
//     try {
//       final img =
//       await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
//       if (img == null) return;
//       profileImgPath.value = img.path;
//     } on PlatformException catch (e) {
//       VxToast.show(context, msg: (e.toString()));
//     }
//   }
//
//   uploadProfileImage() async {
//     var filename = basename(profileImgPath.value);
//     var destination = 'images/${currentUser!.uid}/$filename';
//     Reference ref = FirebaseStorage.instance.ref().child(destination);
//     await ref.putFile(File(profileImgPath.value));
//     profileImageLink = await ref.getDownloadURL();
//   }
//
//   updateProfile({name, password, imgUrl}) async {
//     var store = fireStore.collection(vendorsCollection).doc(auth.currentUser!.uid);
//     await store.set({
//       'name': name,
//       'password': password,
//       'imageUrl': imgUrl,
//     }, SetOptions(merge: true));
//     isLoading(false);
//   }
//
//   changeAuthPassword({email, password, newpassword}) async {
//     final cred = EmailAuthProvider.credential(email: email, password: password);
//     await auth.currentUser!
//         .reauthenticateWithCredential(cred)
//         .then((value) => auth.currentUser!.updatePassword(newpassword))
//         .catchError((error) {
//       print(error.toString());
//     });
//   }
// }

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/firebase_const.dart';
import 'package:emart_seller/const/strings.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:path/path.dart';

class ProfileController extends GetxController {
   late QueryDocumentSnapshot snapshotData;
  var profileImgPath = ''.obs;
  var profileImageLink = '';
  var isLoading = false.obs;


  var nameController = TextEditingController();
  var oldpassController = TextEditingController();
  var newpassController = TextEditingController();

  var shopNameController = TextEditingController();
  var shopAddressController = TextEditingController();
  var shopMobileController = TextEditingController();
  var shopWebsiteController = TextEditingController();
  var shopDescController = TextEditingController();

  // Future<void> fetchProfileData() async {
  //   try {
  //     final vendorDoc =
  //    // await fireStore.collection(vendorsCollection).doc(auth.currentUser!.uid).get();
  //    await fireStore.collection(vendorsCollection).doc('auth.currentUser!.uid').get();
  //     if (vendorDoc.exists) {
  //       snapshotData = vendorDoc;
  //       nameController.text = snapshotData?['vendor_name'] ?? '';
  //     }
  //   } catch (error) {
  //     print(error.toString());
  //   }
  // }

  changeImage(context) async {
    try {
      final img =
      await ImagePicker().pickImage(source: ImageSource.gallery, imageQuality: 70);
      if (img == null) return;
      profileImgPath.value = img.path;
    } on PlatformException catch (e) {
      VxToast.show(context, msg: (e.toString()));
    }
  }

  uploadProfileImage() async {
    var filename = basename(profileImgPath.value);
    var destination = 'images/${currentUser!.uid}/$filename';
   // var destination = 'images/${'Ft0mr3gXa5gzwWRHRpSW'}/$filename';
    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(profileImgPath.value));
    profileImageLink = await ref.getDownloadURL();
  }

  updateProfile({name, password, imgUrl}) async {
  // var store = fireStore.collection(vendorsCollection).doc(auth.currentUser!.uid);
    var store = fireStore.collection(vendorsCollection).doc('MOvGZTfOm7R1yC2VWNoi');
    await store.set(
      {
        'vendor_name': name,
        'password': password,
        'imageUrl': imgUrl,
      },
      SetOptions(merge: true),
    );
    isLoading(false);
  }

  changeAuthPassword({email, password, newpassword}) async {
    final cred = EmailAuthProvider.credential(email: email, password: password);
    //await auth.currentUser!
    await auth.currentUser!
        .reauthenticateWithCredential(cred)
        .then((value) => auth.currentUser!.updatePassword(newpassword))
        .catchError((error) {
      print(error.toString());
    });
  }

   updateShop({shopname,shopaddress,shopmobile,shopwebsite,shopdesc})async{
     var store = fireStore.collection(vendorsCollection).doc('MOvGZTfOm7R1yC2VWNoi');
     await store.set(
       {
        'shop_name':shopname,
        'shop_address':shopaddress,
        'shop_mobile':shopmobile,
        'shop_website':shopwebsite,
        'shop_desc':shopdesc,
       },
       SetOptions(merge: true),
     );
     isLoading(false);
   }

}
