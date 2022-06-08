import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/routes.dart';

class NavBarController extends GetxController{
  var email = ''.obs;
  var name = ''.obs;

  void setUserInfo() async{
    String? e;
    String? n;
    await SharedPreferences.getInstance().then((prefs) {
      e = prefs.getString('email');
      n = prefs.getString('name');
    });

    email.value = e.toString();
    name.value = n.toString();
  }

  void logout(){
    // await SharedPreferences.getInstance().then((prefs) {
    //   prefs.remove('name');
    //   prefs.remove('email');
    //   prefs.remove('password');
    //   prefs.remove('mobile');
    // });
    Get.toNamed(Routes.SIGN_IN);
  }
}