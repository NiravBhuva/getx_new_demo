import 'package:get/get.dart';
import 'package:getx_new_demo/modules/home/controllers/home_controller.dart';
import 'package:getx_new_demo/modules/home/controllers/nav_bar_controller.dart';

class HomeBinging extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
    Get.lazyPut<NavBarController>(
          () => NavBarController(),
    );
  }
}