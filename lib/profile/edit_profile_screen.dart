// import 'dart:html';
// import 'dart:io';
// import 'package:emart_seller/const/images.dart';
// import 'package:emart_seller/const/strings.dart';
// import 'package:emart_seller/controller/profile_controller.dart';
// import 'package:emart_seller/widget/custom_textfield.dart';
// import 'package:emart_seller/widget/text_style.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:get/get_core/src/get_main.dart';
// import 'package:velocity_x/velocity_x.dart';
//
// class EditProfileScreen extends StatefulWidget {
//   final String? username;
//
//   const EditProfileScreen({Key? key, this.username}) : super(key: key);
//
//   @override
//   State<EditProfileScreen> createState() => _EditProfileScreenState();
// }
//
// class _EditProfileScreenState extends State<EditProfileScreen> {
//   var controller = Get.find<ProfileController>();
//
//   @override
//   void initState() {
//     controller.nameController.text = widget.username!;
//     super.initState();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.purple,
//       appBar: AppBar(
//         // backgroundColor: Colors.purple,
//         automaticallyImplyLeading: false,
//         title: boldText(text: editprofile, color: Colors.white),
//         actions: [
//           //  IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
//           TextButton(
//               onPressed: () {},
//               child: Text(
//                 save,
//                 style:
//                     TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
//               ))
//         ],
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: ListView(
//           children: [
//             Column(
//               children: [
//
//                  controller.snapshotData['imageUrl'] == '' && controller.profileImgPath.isEmpty ?
//                  Image.asset(
//                    productimg,
//                    width: 150,
//                  )
//                 .box.roundedFull.clip(Clip.antiAlias).make()
//         //if data is not empty but controller path is empty
//             : controller.snapshotData['imageUrl'] != '' &&
//         controller.profileImgPath.isEmpty
//         ? Image.network(controller.snapshotData['imageUrl'], width: 80,
//         fit: BoxFit.cover,).box.roundedFull.clip(Clip.antiAlias).make()
//         // if both are empty
//             : Image.file(
//     File(controller.profileImgPath.value),
//     width: 100,
//     fit: BoxFit.cover,
//     ).box.roundedFull.clip(Clip.antiAlias).make(),
//                 10.heightBox,
//                 ElevatedButton(
//                     style:
//                         ElevatedButton.styleFrom(backgroundColor: Colors.red),
//                     onPressed: () {
//                       controller.changeImage(context);
//                     },
//                     child: normalText(text: 'Change Image')),
//                 10.heightBox,
//                 Align(
//                     alignment: Alignment.centerLeft,
//                     child: boldText(text: 'Change your password')),
//                 10.heightBox,
//                 Divider(
//                   color: Colors.white,
//                 ),
//                 CustomTextField(label: name,controller: controller.nameController),
//                 5.heightBox,
//                 CustomTextField(label: password,controller: controller.oldpassController),
//                 5.heightBox,
//                 CustomTextField(label: confirmpassword,controller: controller.newpassController),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
import 'dart:io'; // Add this import statement

import 'package:emart_seller/const/images.dart';
import 'package:emart_seller/const/strings.dart';
import 'package:emart_seller/controller/profile_controller.dart';
import 'package:emart_seller/widget/custom_textfield.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';

class EditProfileScreen extends StatefulWidget {
  final String? username;

  const EditProfileScreen({Key? key, this.username}) : super(key: key);

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
   var controller = Get.find<ProfileController>();

  @override
  void initState() {
    controller.nameController.text = widget.username!;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        resizeToAvoidBottomInset: false,
        backgroundColor: Colors.purple,
        appBar: AppBar(
          leading: IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.black87,
              ),
              onPressed: () {
                Get.back();
              }),
          // backgroundColor: Colors.purple,
          automaticallyImplyLeading: false,
          title: boldText(text: editprofile, color: Colors.white),
          actions: [
            //  IconButton(onPressed: (){}, icon: Icon(Icons.edit)),
            controller.isLoading.value
                ? const Center(child: CircularProgressIndicator())
                : TextButton(
                    onPressed: () async {
                      controller.isLoading(true);

                      //if image is not selected
                      if (controller.profileImgPath.value.isNotEmpty) {
                        controller.uploadProfileImage();
                      } else {
                        controller.profileImageLink =
                            controller.snapshotData['imageUrl'];
                      }
                      //if old password matches database
                      if (controller.snapshotData['password'] ==
                          controller.oldpassController.text) {
                        await controller.changeAuthPassword(
                          email: controller.snapshotData['email'],
                          password: controller.oldpassController.text,
                          newpassword: controller.newpassController.text,
                        );
                        controller.updateProfile(
                            name: controller.nameController.text,
                            password: controller.newpassController.text,
                            imgUrl: controller.profileImageLink);
                        VxToast.show(context, msg: 'Updated');
                      } else if (controller
                              .oldpassController.text.isEmptyOrNull &&
                          controller.newpassController.text.isEmptyOrNull) {
                        await controller.updateProfile(
                            name: controller.nameController.text,
                            password: controller.snapshotData['password'],
                            // password: controller.newpassController.text,
                            imgUrl: controller.profileImageLink);
                        VxToast.show(context, msg: 'Updated');
                      } else {
                        VxToast.show(context, msg: 'Some error occured');
                        controller.isLoading(false);
                      }
                    },
                    child: const Text(
                      save,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView(
            children: [
              Column(
                children: [
                  controller.snapshotData['imageUrl'] == '' &&
                          controller.profileImgPath.isEmpty
                      ? Image.asset(
                          productimg,
                          width: 150,
                        ).box.roundedFull.clip(Clip.antiAlias).make()
                      : controller.snapshotData['imageUrl'] != '' &&
                              controller.profileImgPath.isEmpty
                          ? Image.network(
                            //  controller.snapshotData != null
                                   controller.snapshotData['imageUrl'],
                                 // : 'https://www.nicepng.com/png/detail/933-9332131_profile-picture-default-png.png',
                              width: 80,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make()
                          : Image.file(
                              File(controller.profileImgPath.value),
                              // Use .value to access the string value
                              width: 100,
                              fit: BoxFit.cover,
                            ).box.roundedFull.clip(Clip.antiAlias).make(),
                  10.heightBox,
                  ElevatedButton(
                    style:
                        ElevatedButton.styleFrom(backgroundColor: Colors.red),
                    onPressed: () {
                      controller.changeImage(context);
                    },
                    child: normalText(text: 'Change Image'),
                  ),
                  10.heightBox,
                  Align(
                    alignment: Alignment.centerLeft,
                    child: boldText(text: 'Change your password'),
                  ),
                  10.heightBox,
                  const Divider(
                    color: Colors.white,
                  ),
                  CustomTextField(
                    label: name,
                    controller: controller.nameController,
                  ),
                  5.heightBox,
                  CustomTextField(
                    label: password,
                    controller: controller.oldpassController,
                  ),
                  5.heightBox,
                  CustomTextField(
                    label: confirmpassword,
                    controller: controller.newpassController,
                  ),
                ],
              ),
              //),
            ],
          ),
        ),
      ),
    );
  }
}
