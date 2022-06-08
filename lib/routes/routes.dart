import 'package:get/get.dart';
import 'package:getx_new_demo/modules/home/bindings/home_binding.dart';
import 'package:getx_new_demo/modules/home/views/home_view.dart';
import 'package:getx_new_demo/modules/login/bindings/sign_in_binding.dart';
import 'package:getx_new_demo/modules/splash/splash_screen.dart';

import '../modules/login/bindings/sign_up_binding.dart';
import '../modules/login/views/sign_in_view.dart';
import '../modules/login/views/sign_up_view.dart';

class Routes {
  static const SPLASH = '/splash';
  static const SIGN_IN = '/sign_in';
  static const SIGN_UP = '/sign_up';
  static const HOME = '/home';

  static List<GetPage<dynamic>> pages = [
    GetPage(
      name: SPLASH,
      page: () => const SplashScreen(),
    ),
    GetPage(
      name: SIGN_IN,
      page: () => SignInScreen(),
      binding: SignInBinging(),
    ),
    GetPage(
      name: SIGN_UP,
      page: () => SignUpScreen(),
      binding: SignUpBinging(),
    ),
    GetPage(
      name: HOME,
      page: () => HomeScreen(),
      binding: HomeBinging(),
    ),
  ];
}
