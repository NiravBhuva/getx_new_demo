import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../models/order.dart';
import '../../../models/product.dart';
import '../../../routes/routes.dart';

class HomeController extends GetxController {
  RxList products = [].obs;
  RxList cartProducts = [].obs;
  late Product productBuyNow;
  List<Order> orders = [];

  var faker = Faker();
  var email = ''.obs;
  var name = ''.obs;

  @override
  void onInit() async{
    // TODO: implement onInit
    super.onInit();
    setUserInfo();
  }

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

  void getData() {
    random.amount(
      (_) {
        products.add(
          Product(faker.food.dish(), faker.randomGenerator.decimal(min: 4, scale: 2).ceilToDouble().toString(), faker.image
              .image(random: true, keywords: ['product', 'food', 'item'])),
        );
      },
      5,
      min: 5,
    );
  }

  void addToCart(Product p){
    cartProducts.add(p);
  }

  void removeFromCart(Product p){
    cartProducts.remove(p);
  }

  double getTotal(){
    double totalPrice = 0.0;
    cartProducts.forEach((item){
      totalPrice += double.parse(item.price);
    });
    return totalPrice;
  }

  double getTotalPriceOfOrders(List<dynamic>? p){
    double totalPrice = 0.0;
    p?.forEach((item){
      totalPrice += double.parse(item.price);
    });
    return totalPrice;
  }
}
