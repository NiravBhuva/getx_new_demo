import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/src/rx_typedefs/rx_typedefs.dart';

class NavBar extends StatelessWidget {
  NavBar(this.name, this.email, this.image, this.logout, this.ordersBtn, {Key? key}) : super(key: key);
  var faker = Faker();
  String name;
  String email;
  String image;
  Callback logout;
  Callback ordersBtn;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // Remove padding
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text(name),
            accountEmail: Text(email),
            currentAccountPicture: CircleAvatar(
              child: ClipOval(
                child: Image.network(
                  image,
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
            title: Text('Orders'),
            leading: Icon(Icons.shopping_bag_outlined),
            onTap: () => ordersBtn(),
          ),
          ListTile(
            title: Text('Logout'),
            leading: Icon(Icons.exit_to_app),
            onTap: () => logout(),
          ),
        ],
      ),
    );
  }
}