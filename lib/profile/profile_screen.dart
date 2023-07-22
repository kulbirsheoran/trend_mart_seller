// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:emart_seller/const/constant.dart';
// import 'package:emart_seller/const/firebase_const.dart';
// import 'package:emart_seller/const/images.dart';
// import 'package:emart_seller/const/strings.dart';
// import 'package:emart_seller/controller/auth_controller.dart';
// import 'package:emart_seller/controller/profile_controller.dart';
// import 'package:emart_seller/profile/edit_profile_screen.dart';
// import 'package:emart_seller/profile/message.dart';
// import 'package:emart_seller/profile/shop_setting.dart';
// import 'package:emart_seller/services/store_services.dart';
// import 'package:emart_seller/ui/auth_screen/login_screen.dart';
// import 'package:emart_seller/widget/text_style.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:velocity_x/velocity_x.dart';
// import 'package:intl/intl.dart' as intl;
//
// class ProfileScreen extends StatelessWidget {
//   const ProfileScreen({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     var controller = Get.put(ProfileController());
//     return Scaffold(
//       backgroundColor: Colors.purple,
//       appBar: AppBar(
//         automaticallyImplyLeading: false,
//         title: boldText(text: setting, color: Colors.grey),
//         actions: [
//           IconButton(
//               onPressed: () {
//                 Get.to(() => EditProfileScreen(
//                       username: controller.snapshotData != null
//                           ? controller.snapshotData!['vendor_name']
//                           : '',
//                     ));
//               },
//               icon: const Icon(Icons.edit)),
//           TextButton(
//               onPressed: () async {
//                 await Get.find<AuthController>().signOutMethod(context);
//                 Get.offAll(() => LoginScreen());
//               },
//               child: const Text(
//                 logout,
//                 style: TextStyle(color: Colors.white),
//               ))
//         ],
//       ),
//       // body: future builder ayga yaha p jo niche comment h
//       body: FutureBuilder<DocumentSnapshot>(
//       future: StoreServices.getProfile(auth.currentUser!.uid),
//         builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot){
//         if(!snapshot.hasData){
//           return const Center(
//             child: CircularProgressIndicator(),
//           )
//         }else{
//           controller.snapshotData = snapshot.data!.docs[0];
//           return
//         }
//         },
//         //mail aa rhi h uuid bi is mail verified false
//       //   stream: StoreServices.getProfile(auth.currentUser!.uid),
//       //   //snapshot null
//       //   builder: (BuildContext context,
//       //       AsyncSnapshot<DocumentSnapshot> snapshot) {
//       //     if (snapshot.hasData && (snapshot.data?.exists ?? false)) {
//       //       DocumentSnapshot document = snapshot.data!;
//       //       Map<String, dynamic> data =
//       //           document.data() as Map<String, dynamic>;
//       //       return body(
//       //         context,
//       //         controller,
//       //         data,
//       //       );
//       //       //has data false
//       //     } else if (snapshot.hasData &&
//       //         !(snapshot.data?.exists ?? false)) {
//       //       return const Center(child: Text('Document does not exist'));
//       //       //snapshot null has error false
//       //     } else if (snapshot.hasError) {
//       //       return Center(child: Text('Error: ${snapshot.error}'));
//       //     } else {
//       //       return const Center(child: CircularProgressIndicator());
//       //     }
//       //   },
//       ),
//     );
//   }
//
//   Column body(context, controller, data) {
//     return Column(
//       children: [
//         ListTile(
//           leading: controller.snapshotData['imageUrl'] ?? ''
//           ?Image.asset(productimg)
//               .box
//               .roundedFull
//               .clip(Clip.antiAlias)
//               .make()
//      :Image.network(controller.snapshotData['imageUrl'],width: 100,fit: BoxFit.cover,).box.make(),
//           leading: controller.snapshotData != null && controller.snapshotData['imgUrl'] != null
//               ? Image.network(controller.snapshotData['imgUrl'], width: 100, fit: BoxFit.cover,).box.make()
//               : Image.asset(productimg).box.roundedFull.clip(Clip.antiAlias).make(),
//
//           title: boldText(
//               //text:'${controller.snapshotData['vendor_name']}'
//               text: data['vendor_name']),
//           subtitle: boldText(
//               //'${controller.snapshotData['email']}'
//
//               text: data['email'],
//               color: Colors.white),
//         ),
//         Divider(),
//         10.heightBox,
//         Padding(
//           padding: EdgeInsets.all(8.0),
//           child: Column(
//               children: List.generate(
//                   profileButtonsIcons.length,
//                   (index) => ListTile(
//                         leading: profileButtonsIcons[index],
//                         title: normalText(text: profilesButtonTitles[index]),
//                         onTap: () {
//                           switch (index) {
//                             case 0:
//                               Get.to(() => const ShopSettings());
//                               break;
//                             case 1:
//                               Get.to(() => MessagesScreen());
//                               break;
//                             default:
//                           }
//                         },
//                       ))),
//         )
//       ],
//     );
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/constant.dart';
import 'package:emart_seller/const/firebase_const.dart';
import 'package:emart_seller/const/images.dart';
import 'package:emart_seller/const/strings.dart';
import 'package:emart_seller/controller/auth_controller.dart';
import 'package:emart_seller/controller/profile_controller.dart';
import 'package:emart_seller/profile/edit_profile_screen.dart';
import 'package:emart_seller/profile/message.dart';
import 'package:emart_seller/profile/shop_setting.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/ui/auth_screen/login_screen.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:intl/intl.dart' as intl;

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(ProfileController());
    return Scaffold(
        backgroundColor: Colors.purple,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: boldText(text: setting, color: Colors.grey),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => EditProfileScreen(
                        username: controller.snapshotData['vendor_name'],
                      ));
                },
                icon: const Icon(Icons.edit)),
            TextButton(
                onPressed: () async {
                  await Get.find<AuthController>().signOutMethod(context);
                  Get.offAll(() => LoginScreen());
                },
                child: const Text(
                  logout,
                  style: TextStyle(color: Colors.white),
                ))
          ],
        ),
         body:FutureBuilder(
        future: StoreServices.getProfile(auth.currentUser!.uid),
    builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if(!snapshot.hasData){
            return CircularProgressIndicator();
          }else{
       // var data = snapshot.data!.docs[0];
            controller.snapshotData = snapshot.data!.docs[0];
            return Column(

              children: [
                ListTile(
                  leading: controller.snapshotData['imageUrl'] == ''
                      ? Image.asset(productimg,width: 80,fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
                      :Image.network(
                    controller.snapshotData['imageUrl'],
                    width: 80,
                    fit: BoxFit.cover,
                  ).box.roundedFull.clip(Clip.antiAlias).make(),
                  title: boldText(text: '${controller.snapshotData['vendor_name']}'),
                  subtitle: boldText(text: '${controller.snapshotData['email']}'),
                ),
                  // leading: Image.asset(productimg).box.roundedFull.clip(Clip.antiAlias).make(),
                  // title: boldText(text:'${controller.snapshotData['vendor_name']}'),
                  // subtitle: boldText(text: '${controller.snapshotData['email']}'),


                Divider(),
                10.heightBox,
                Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Column(
                      children: List.generate(
                          profileButtonsIcons.length,
                              (index) => ListTile(
                            leading: profileButtonsIcons[index],
                            title: normalText(
                                text: profilesButtonTitles[index]),
                            onTap: () {
                              switch (index) {
                                case 0:
                                  Get.to(() => const ShopSettings());
                                  break;
                                case 1:
                                  Get.to(() => MessagesScreen());
                                  break;
                                default:
                              }
                            },
                          ))),
                )
              ],
            );
          }
    }
    )
    );
              }
            }



            //coloum

// Column(
//
// children: [
// ListTile(
// leading: Image.asset(productimg).box.roundedFull.clip(Clip.antiAlias).make(),
// title: boldText(text: 'k'),
// subtitle: boldText(text: 'jhghgkj'),
//
// ),
// Divider(),
// 10.heightBox,
// Padding(
// padding: EdgeInsets.all(8.0),
// child: Column(
// children: List.generate(
// profileButtonsIcons.length,
// (index) => ListTile(
// leading: profileButtonsIcons[index],
// title: normalText(
// text: profilesButtonTitles[index]),
// onTap: () {
// switch (index) {
// case 0:
// Get.to(() => const ShopSettings());
// break;
// case 1:
// Get.to(() => MessagesScreen());
// break;
// default:
// }
// },
// ))),
// )
// ],
// )


           //column


//    title: boldText(
//       // text: '${controller.snapshotData['vendor_name']}'),
// text: boldText(text: '${data['vendor_name']}'),),
//   // text: 'jk',
//    subtitle: boldText(text: '${data['email']}'
//       ),

// FutureBuilder<QuerySnapshot>(
//     future: StoreServices.getProfile('MOvGZTfOm7R1yC2VWNoi'),
//     builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
//       // if (!snapshot.hasData) {
//       //   return const Center(
//       //     child: CircularProgressIndicator(
//       //       valueColor: AlwaysStoppedAnimation(Colors.red),
//       //     ),
//       //   );
//       print("Connection State: ${snapshot.connectionState}");
//
//       if (snapshot.connectionState == ConnectionState.waiting) {
//         return const Center(
//           child: CircularProgressIndicator(),
//         );
//       } else if (snapshot.hasError) {
//         return Center(
//           child: Text('Error: ${snapshot.error}'),
//         );
//       } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
//         print("No data available.");
//
//         return const Center(
//
//           child: Text('No data available'),
//         );
//       }
//         else {
//         print("Data available: ${snapshot.data!.docs[0].data()}");
//
//         var data = snapshot.data!.docs[0];
//         //controller.snapshotData = snapshot.data!.docs[0];
//         return Column(


// leading: controller.snapshotData['imageUrl'] ?? ''
//     ?Image.asset(productimg)
//     .box
//     .roundedFull
//     .clip(Clip.antiAlias)
//     .make()
//     :Image.network(controller.snapshotData['imageUrl'],width: 100,fit: BoxFit.cover,).box.make(),
// leading: controller.snapshotData != null && controller.snapshotData['imgUrl'] != null
//     ? Image.network(controller.snapshotData['imgUrl'], width: 100, fit: BoxFit.cover,).box.make()
//     : Image.asset(productimg).box.roundedFull.clip(Clip.antiAlias).make(),
// leading: Image.asset(productimg)
//     .box
//     .roundedFull
//     .clip(Clip.antiAlias)
//     .make(),

//  y niche wala uncomment krn h

// leading: controller.snapshotData['imgUrl'] == ''
//     ? Image.asset(productimg)
//         .box
//         .roundedFull
//         .clip(Clip.antiAlias)
//         .make()
//     : Image.network(
//         controller.snapshotData['imgUrl'],
//         width: 100,
//         fit: BoxFit.cover,
//       ).box.make(),
// leading: controller.snapshotData != null && controller.snapshotData['imgUrl'] != null
//  ? Image.network(controller.snapshotData['imgUrl'], width: 100, fit: BoxFit.cover,).box.make()
//     : Image.asset(productimg).box.roundedFull.clip(Clip.antiAlias).make(),