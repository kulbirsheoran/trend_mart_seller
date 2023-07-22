import 'package:emart_seller/const/colors.dart';
import 'package:emart_seller/const/images.dart';
import 'package:emart_seller/const/strings.dart';
import 'package:emart_seller/controller/auth_controller.dart';
import 'package:emart_seller/ui/home_screen/home.dart';
import 'package:emart_seller/widget/out_button.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/material.dart';
import 'package:velocity_x/velocity_x.dart';
import 'package:get/get.dart';
class LoginScreen extends StatelessWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(AuthController());
    return  Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.purple,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                30.heightBox,
                normalText(text: welcome,size: 18),
                20.heightBox,
                Row(
                  children: [
                    Image.asset(logo,
                    width: 80,
                      height:  80,
                    ).box.border(color: white).rounded.padding(EdgeInsets.all(8)).make(),
                    10.widthBox,
                    boldText(text: appname,size: 18.0)
                  ],
                ),
                60.heightBox,
                normalText(text: loginTO,size: 16.0),
               10.heightBox,
                Obx(()=>
                   Column(
                    children: [
                      TextFormField(controller:controller.emailController,
                        decoration: const InputDecoration(
                          fillColor: Colors.grey,
                          filled: true,
                          prefixIcon: Icon(Icons.email,color: Colors.purple,),
                          border: InputBorder.none,
                          hintText: emaillHint,
                        ),

                      ),
                      10.heightBox,
                      TextFormField(
                        obscureText: true,
                        controller: controller.passwordController,
                        decoration: const InputDecoration(
                          fillColor: Colors.grey,
                          filled: true,
                          prefixIcon: Icon(Icons.lock,color: Colors.purple,),
                          border: InputBorder.none,
                          hintText: passwordHint,
                        ),
                      ),
                      10.heightBox,
                    Align(alignment: Alignment.centerRight,
                      child: TextButton(onPressed: () {  },
                      child: Text(forgotPassword),),
                    ),
                    //  SizedBox(child: TextButton(onPressed: (){}, child: normalText(text: forgotPassword,))),
                      20.heightBox,
                      SizedBox(
                        width: context.screenWidth-60,
                        child: controller.isLoading.value ? const Center(
                          child: CircularProgressIndicator(
                            valueColor: AlwaysStoppedAnimation(Colors.red),
                          ),
                        ) :ourButton(
                          title: login,
                          //color: Colors.purple
                          onPress: ()async{
                           // Get.to(()=>const Home());
                            controller.isLoading(true);
                            await controller.loginMethod(context: context).then((value){
                              if(value!= null){
                                VxToast.show(context, msg: 'Login Successfully');
                                controller.isLoading(false);
                                Get.offAll(()=>Home());
                              }else{
                                controller.isLoading(false);
                              }
                            });
                          }
                        ),
                      )
                    ],
                  )).box.white.rounded.outerShadowSm.padding(EdgeInsets.all(8)).make(),

               Center(child: normalText(text: anyProblem,color: Colors.grey)),
                Spacer(),
                Center(child: boldText(text: credit)),
                20.heightBox,
              ],
          ),
        ),
      ),
    );
  }
}
