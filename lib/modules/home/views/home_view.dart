import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_new_demo/modules/home/controllers/home_controller.dart';
import 'package:getx_new_demo/modules/home/controllers/nav_bar_controller.dart';

import 'nav_bar.dart';

class HomeScreen extends GetView<HomeController> {
  HomeScreen({Key? key}) : super(key: key);
  //HomeController homeController = Get.find<HomeController>();
  // NavBarController navController = Get.find<NavBarController>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavBar(),
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
          IconButton(
            onPressed: () {},
            icon: Icon(Icons.shopping_cart),
          )
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
                        child: Image.network(
                            controller.products[index].image,
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
                  SizedBox(
                    height: 30,
                    width: double.infinity,
                    child: ElevatedButton(
                      onPressed: () {
                        controller
                            .addToCart(controller.products[index]);
                      },
                      style: ElevatedButton.styleFrom(
                        primary: Colors.orangeAccent,
                      ),
                      child: const Text(
                        "Add to cart",
                        style: TextStyle(fontSize: 15, color: Colors.white),
                      ),
                    ),
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
