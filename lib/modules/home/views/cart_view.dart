import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_new_demo/modules/home/controllers/home_controller.dart';

import '../../../routes/routes.dart';

class CartScreen extends GetView<HomeController> {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Cart'),
          backgroundColor: Colors.black,
        ),
        bottomNavigationBar: SizedBox(
          height: 55,
          width: double.infinity,
          child: ElevatedButton(
            onPressed: () {
              Get.toNamed(Routes.CHECKOUT, arguments: false);
            },
            style: ElevatedButton.styleFrom(
              primary: Colors.orange,
            ),
            child: const Text(
              "Go to Checkout",
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ),
        body: Obx(
              () => ListView.builder(
            physics: const BouncingScrollPhysics(),
            shrinkWrap: true,
            itemCount: controller.cartProducts.length,
            itemBuilder: (BuildContext context, int index) {
              return Container(
                height: 100,
                padding: EdgeInsets.all(8),
                child: Row(
                  children: [
                    Expanded(
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(4),
                        child: Image.network(controller.cartProducts[index].image,
                            fit: BoxFit.fill),
                      ),
                    ),
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  controller.cartProducts[index].name,
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  'Price: \$${controller.cartProducts[index].price}',
                                  style: const TextStyle(fontWeight: FontWeight.bold),
                                ),
                              ],
                            ),
                          ),
                          Spacer(),
                          SizedBox(
                            height: 30,
                            width: double.infinity,
                            child: ElevatedButton(
                              onPressed: () {
                                controller.removeFromCart(controller.cartProducts[index]);
                              },
                              style: ElevatedButton.styleFrom(
                                primary: Colors.black,
                              ),
                              child: const Text(
                                "Remove from cart",
                                style: TextStyle(fontSize: 15, color: Colors.white),
                              ),
                            ),
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
      ),
    );
  }
}
