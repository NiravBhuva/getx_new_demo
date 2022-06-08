import 'package:get/get.dart';
import 'package:getx_new_demo/modules/login/controllers/sign_in_controller.dart';

class SignInBinging extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<SignInController>(
          () => SignInController(),
    );
  }
}