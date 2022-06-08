import 'package:faker/faker.dart';
import 'package:get/get.dart';

import '../../../models/product.dart';

class HomeController extends GetxController {
  RxList products = [].obs;
  RxList cartProducts = [].obs;
  var faker = Faker();

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

  }
}
