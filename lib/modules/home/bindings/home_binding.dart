import 'package:get/get.dart';
import 'package:getx_new_demo/modules/home/controllers/home_controller.dart';

class HomeBinging extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<HomeController>(
          () => HomeController(),
    );
  }
}