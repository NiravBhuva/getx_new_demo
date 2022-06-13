import 'dart:convert';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_new_demo/modules/home/controllers/home_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/routes.dart';
import '../../../widgets/nav_bar.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);

  //HomeController homeController = Get.find<HomeController>();
  // NavBarController navController = Get.find<NavBarController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Obx(
        () => NavBar(
          controller.name.value,
          controller.email.value,
          faker.image.image(keywords: ['user']),
          () => controller.logout(),
          () {
            Get.toNamed(Routes.ORDERS);
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.getData();
        },
        child: Icon(Icons.add),
      ),
      appBar: AppBar(
        title: const Text('Home'),
        backgroundColor: Colors.black,
        actions: [
          Obx(
            () => IconButton(
              onPressed: () {
                Get.toNamed(Routes.CART);
              },
              icon: Stack(
                alignment: Alignment.topRight,
                children: [
                  const Icon(Icons.shopping_cart),
                  Visibility(
                    visible: controller.cartProducts.isNotEmpty,
                    child: Container(
                      height: 15,
                      width: 15,
                      transform: Matrix4.translationValues(7, -10, 0),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10)),
                      child: Center(
                        child: Text(
                          controller.cartProducts.length.toString(),
                          style: TextStyle(color: Colors.black, fontSize: 9),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ],
      ),
      body: Obx(
        () => GridView.builder(
          physics: const ScrollPhysics(),
          shrinkWrap: true,
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            childAspectRatio: (3 / 3),
          ),
          itemCount: controller.products.length,
          itemBuilder: (BuildContext context, int index) {
            return Card(
              child: Column(
                children: [
                  Expanded(
                    child: Container(
                      width: double.infinity,
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(2),
                        child: Image.network(controller.products[index].image,
                            fit: BoxFit.fitWidth),
                      ),
                    ),
                  ),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Expanded(
                          child: Text(
                            controller.products[index].name,
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ),
                        Text(
                          '\$${controller.products[index].price}',
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                        child: SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () {
                              controller.productBuyNow =
                                  controller.products[index];
                              Get.toNamed(Routes.CHECKOUT, arguments: true);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orangeAccent,
                            ),
                            child: const Text(
                              "Buy Now",
                              style:
                                  TextStyle(fontSize: 9, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: 5),
                      Expanded(
                        child: SizedBox(
                          height: 30,
                          child: ElevatedButton(
                            onPressed: () async{
                              controller.addToCart(controller.products[index]);
                            },
                            style: ElevatedButton.styleFrom(
                              primary: Colors.orangeAccent,
                            ),
                            child: const Text(
                              "Add to cart",
                              style:
                                  TextStyle(fontSize: 9, color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
