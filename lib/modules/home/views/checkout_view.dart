import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_new_demo/models/order.dart';
import 'package:getx_new_demo/modules/home/controllers/home_controller.dart';
import 'package:getx_new_demo/routes/routes.dart';

class CheckoutScreen extends GetView<HomeController> {
  bool isBuyNow = false;

  CheckoutScreen(this.isBuyNow, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Checkout'),
          backgroundColor: Colors.black,
        ),
        bottomNavigationBar: ListView(
          padding: EdgeInsets.zero,
          shrinkWrap: true,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "No. of Item: ${isBuyNow ? '1' : controller.cartProducts.length.toString()}",
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Total price: \$${isBuyNow ? controller.productBuyNow.price : controller.getTotal()}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.only(top: 10),
              height: 55,
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  Get.snackbar(
                    'Order',
                    'Order Placed Successfully',
                    snackPosition: SnackPosition.BOTTOM,
                    icon: const Icon(Icons.done_rounded),
                    isDismissible: false,
                  );
                  var rng = Random();

                  if (isBuyNow) {
                    controller.orders.add(
                      Order(
                        rng.nextInt(50000).toString(),
                        DateTime.now(),
                        [controller.productBuyNow],
                      ),
                    );
                  } else {
                    controller.orders.add(
                      Order(
                        rng.nextInt(50000).toString(),
                        DateTime.now(),
                        controller.cartProducts.toList(),
                      ),
                    );
                    controller.cartProducts.clear();
                  }

                  Get.until((route) => Get.currentRoute == Routes.HOME);
                },
                style: ElevatedButton.styleFrom(
                  primary: Colors.green,
                ),
                child: const Text(
                  "Checkout",
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            )
          ],
        ),
        body: isBuyNow
            ? Container(
                height: Get.width * 0.5,
                width: Get.width * 0.5,
                child: Card(
                  child: Column(
                    children: [
                      Expanded(
                        child: Container(
                          width: double.infinity,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(2),
                            child: Image.network(
                                controller.productBuyNow.image ?? '',
                                fit: BoxFit.fitWidth),
                          ),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 12, vertical: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Text(
                                controller.productBuyNow.name ?? '',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            Text(
                              '\$${controller.productBuyNow.price}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              )
            : GridView.builder(
                physics: const ScrollPhysics(),
                shrinkWrap: true,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: (3 / 3),
                ),
                itemCount: controller.cartProducts.length,
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
                                  controller.cartProducts[index].image,
                                  fit: BoxFit.fitWidth),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                child: Text(
                                  controller.cartProducts[index].name,
                                  style: const TextStyle(
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                              Text(
                                '\$${controller.cartProducts[index].price}',
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                            ],
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
