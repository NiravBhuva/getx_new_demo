import 'package:getx_new_demo/models/product.dart';

class Order {
  String? id;
  DateTime? date;
  List<dynamic>? products = [];

  Order(this.id, this.date, this.products);
}