import 'package:emart_seller/const/firebase_const.dart';
import 'package:get/get.dart';

class HomeController extends GetxController {

  @override
  void onInit() {

    super.onInit();
    getUsername();
  }

  var navIndex = 0.obs;
  var username = '';

  getUsername() async {
    var n = await fireStore
        .collection(vendorsCollection)
        .where('id', isEqualTo: 'MOvGZTfOm7R1yC2VWNoi')
        .get()
        .then((value) {
          if(value.docs.isEmpty){
            return value.docs.single['vendor_name'];
          }

    });

    username = n ;
  print(username);
  }
}
