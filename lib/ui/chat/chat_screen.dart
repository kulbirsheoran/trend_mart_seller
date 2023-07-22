import 'package:emart_seller/const/strings.dart';
import 'package:emart_seller/ui/chat/chat_bubble.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:velocity_x/velocity_x.dart';

class ChatScreen extends StatelessWidget {
  const ChatScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(icon: const Icon(Icons.arrow_back,color: Colors.black87,),onPressed: (){
          Get.back();
        },),
        automaticallyImplyLeading: false,
        title: boldText(text:chat,color: Colors.black87,size: 16.0),
      ),
    body: Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
         Expanded(
           child: ListView.builder(itemCount: 20,
               itemBuilder: (context,index){
               return ChatBubble();
           }),
         ) ,
          10.heightBox,
          SizedBox(
            height: 56,
            child: Row(
              children: [
                Expanded(child: TextFormField(
                  decoration: const InputDecoration(
                    isDense: true,
                    hintText: 'Enter Message',fillColor: Colors.white,filled: true,
                    border: OutlineInputBorder(
                      borderSide: BorderSide(
                        color: Colors.purple
                      ),

                    ),
                    focusedBorder:  OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.purple
                        )
                    )
                  ),
                )),
                IconButton(onPressed: (){}, icon: Icon(Icons.send))
              ],
            )//.box.padding(EdgeInsets.all(12)).make()
          ),

        ],
      ),
    ),
    );
  }
}
