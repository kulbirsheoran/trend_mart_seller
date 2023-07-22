import 'package:emart_seller/const/strings.dart';
import 'package:emart_seller/controller/home_controller.dart';
import 'package:emart_seller/orders/orders_screen.dart';
import 'package:emart_seller/products/products_screen.dart';
import 'package:emart_seller/profile/profile_screen.dart';
import 'package:emart_seller/ui/home_screen/home_screen.dart';
import 'package:emart_seller/widget/text_style.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

class Home extends StatelessWidget {
  const Home({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var controller = Get.put(HomeController());

    var navScreens = [
      HomeScreen(),
      ProductsScreen(),
      OrdersScreen(),
      ProfileScreen(),
    ];
    var bottomNavbar = [
      const BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
          color: Colors.black87,
        ),
        label: dashboard,
      ),
      const BottomNavigationBarItem(
          icon: Icon(Icons.production_quantity_limits, color: Colors.black87),
          label: product),
      const BottomNavigationBarItem(
          icon: Icon(Icons.cases_rounded, color: Colors.black87),
          label: orders),
      const BottomNavigationBarItem(
          icon: Icon(Icons.person, color: Colors.black87), label: setting),
    ];
    return Scaffold(
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          items: bottomNavbar,
          selectedItemColor: Colors.purple,
          unselectedItemColor: Colors.black87,
          type: BottomNavigationBarType.fixed,
          onTap: (index) {
            controller.navIndex.value = index;
          },
          currentIndex: controller.navIndex.value,
        ),
      ),
      body: Obx(
        () => Column(
          children: [
            Expanded(
                child: navScreens.elementAt(
                    controller.navIndex.value))
          ],
        ),
      ),
    );
  }
}
