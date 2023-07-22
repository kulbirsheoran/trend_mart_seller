import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:emart_seller/const/firebase_const.dart';
import 'package:emart_seller/const/strings.dart';
import 'package:emart_seller/services/store_services.dart';
import 'package:emart_seller/ui/chat/chat_screen.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart' as intl;

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(backgroundColor: Colors.purple,
      appBar: AppBar( leading: IconButton(icon: const Icon(Icons.arrow_back,color: Colors.black87,),onPressed: (){
        Get.back();
      },),
        automaticallyImplyLeading: false,
        title: boldText(text:message,color: Colors.black87,size: 16.0),
      ),
     body: StreamBuilder(
       stream:  StoreServices.getMessages(currentUser!.uid),
       builder: (BuildContext context,AsyncSnapshot<QuerySnapshot>snapshot){
         if(!snapshot.hasData){
           return const CircularProgressIndicator();
         }else{
           var data = snapshot.data!.docs;
           return Padding(
             padding: const EdgeInsets.all(8.0),
             child: SingleChildScrollView(
               physics: const BouncingScrollPhysics(),
               child: Column(
                 children: List.generate(data.length, (index) {
                   var t = data[index]['created_on'] == null ? DateTime.now():data[index]['created_on'].toDate();
                   var time = intl.DateFormat('h:mma').format(t);
                   return ListTile(
                     onTap: (){
                       Get.to(()=>const ChatScreen());
                     },
                     leading: const CircleAvatar(backgroundColor: Colors.white,
                       child: Icon(Icons.person,color: Colors.black87,),
                     ),
                     // title: boldText(text: username,color: Colors.white),
                     title: boldText(text: '${data[index]['sender_name']}',color: Colors.black),
                     // subtitle: normalText(text: 'last message...'),
                     subtitle: normalText(text: '${data[index]['last_msg']}',color: Colors.black),
                     trailing: normalText(text: time,color: Colors.black),
                   );
                 })

                 ,
               ),
             ),
           );
         }
       },
     ),

    );
  }
}
