import 'package:get/get.dart';
import 'package:getx_new_demo/modules/home/bindings/home_binding.dart';
import 'package:getx_new_demo/modules/home/views/cart_view.dart';
import 'package:getx_new_demo/modules/home/views/checkout_view.dart';
import 'package:getx_new_demo/modules/home/views/home_view.dart';
import 'package:getx_new_demo/modules/home/views/orders_view.dart';
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
  static const CART = '/cart';
  static const CHECKOUT = '/checkout';
  static const ORDERS = '/orders';

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
    GetPage(
      name: CART,
      page: () => CartScreen(),
    ),
    GetPage(
      name: CHECKOUT,
      page: () => CheckoutScreen(Get.arguments as bool),
    ),
    GetPage(
      name: ORDERS,
      page: () => OrdersScreen(),
    ),
  ];
}
