import 'package:emart_seller/const/strings.dart';
import 'package:emart_seller/ui/auth_screen/login_screen.dart';
import 'package:emart_seller/ui/home_screen/home.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';

import 'const/firebase_const.dart';

void main()async {
  WidgetsFlutterBinding.ensureInitialized();
  await  Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkUser();
  }
  var isLoggedIn = false;

  checkUser()async{
    auth.authStateChanges().listen((User? user){
      if(user == null && mounted){
        isLoggedIn = false;
      }else{
        isLoggedIn = true;
      }
      setState(() {

      });
      });
  }

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: appname,
      debugShowCheckedModeBanner: false,
      home: isLoggedIn ? Home():const LoginScreen(),
      theme: ThemeData(
         appBarTheme: const AppBarTheme(
           backgroundColor: Colors.transparent,
               elevation: 0.0
         ),

      ),

    );
  }
}




