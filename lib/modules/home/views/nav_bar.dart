import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_new_demo/modules/home/controllers/nav_bar_controller.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../routes/routes.dart';

class NavBar extends GetView<NavBarController> {
  var faker = Faker();

  @override
  Widget build(BuildContext context) {
    controller.setUserInfo();
    return Obx(()=> Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('${controller.name}'),
            accountEmail: Text('${controller.email}'),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  faker.image.image(keywords: ['user']),
                  fit: BoxFit.cover,
                  width: 90,
                  height: 90,
                ),
              ),
            ),
            decoration: const BoxDecoration(
              color: Colors.blue,
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: NetworkImage(
                      'https://oflutter.com/wp-content/uploads/2021/02/profile-bg3.jpg')),
            ),
          ),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => controller.logout(),
          ),
        ],
      ),
    ));
  }
}