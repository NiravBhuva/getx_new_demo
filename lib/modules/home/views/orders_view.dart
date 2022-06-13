import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_new_demo/modules/home/controllers/home_controller.dart';

class OrdersScreen extends GetView<HomeController> {
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Orders'),
          backgroundColor: Colors.black,
        ),
        body: controller.orders.isEmpty
            ? const Center(
                child: Text('No Orders'),
              )
            : ListView.builder(
                physics: const BouncingScrollPhysics(),
                shrinkWrap: true,
                itemCount: controller.orders.length,
                itemBuilder: (BuildContext context, int index) {
                  return Container(
                    height: 100,
                    margin: EdgeInsets.all(8),
                    child: Row(
                      children: [
                        Expanded(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(5),
                            child: Image.network(
                                controller.orders[index].products?[0].image ??
                                    '',
                                fit: BoxFit.fitWidth),
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Order id: ${controller.orders[index].id}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      "Date: ${controller.orders[index].date?.day.toString()}-${controller.orders[index].date?.month.toString().padLeft(2, '0')}-${controller.orders[index].date?.year.toString().padLeft(2, '0')} ${controller.orders[index].date?.hour.toString().padLeft(2, '0')}:${controller.orders[index].date?.minute.toString().padLeft(2, '0')}",
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                Spacer(),
                                Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        'Total items: ${controller.orders[index].products?.length}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ),
                                    Text(
                                      'Total price: \$${controller.getTotalPriceOfOrders(controller.orders[index].products)}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
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
