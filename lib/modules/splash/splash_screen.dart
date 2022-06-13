import 'dart:async';

import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../routes/routes.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  var faker = Faker();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    checkLogin();
  }

  void checkLogin() async{
    String? email;
    await SharedPreferences.getInstance().then((prefs) {
      email = prefs.getString('email');
    });

    Future.delayed(
      const Duration(seconds: 5),
          () {
            if(email != null){
              Get.offAllNamed(Routes.HOME);
            }else{
              Get.offAllNamed(Routes.SIGN_IN);
            }
          },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: Center(
          child: ClipRRect(
            borderRadius: BorderRadius.circular(200),
            child: Image.network(
              faker.image.image(keywords: ['hill']),
              fit: BoxFit.fill,
              height: 200,
              width: 200,
            ),
          ),
        ),
      ),
    );
  }
}
