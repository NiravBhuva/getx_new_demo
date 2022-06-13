import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/helpers.dart';
import '../../../helper/validator.dart';
import '../../../routes/routes.dart';
import '../controllers/sign_up_controller.dart';

class SignUpScreen extends GetView<SignUpController> {
  SignUpScreen({Key? key}) : super(key: key);
  var faker = Faker();

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _numController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 50, left: 20),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  icon: const Icon(
                    Icons.arrow_back_ios_new,
                    color: Colors.black,
                    size: 30,
                  ),
                ),
              ),
            ),
            ClipRRect(
              borderRadius: BorderRadius.circular(150),
              child: Image.network(
                faker.image.image(keywords: ['logo']),
                fit: BoxFit.fill,
                height: 150,
                width: 150,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Center(
              // heightFactor: 1.5,
              child: Form(
                key: formkey,
                child: cardForm(),
              ),
            ),
            const SizedBox(
              height: 70,
            ),
          ],
        ),
      ),
    );
  }

  Widget cardForm() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      // shape:ShapeBorder.,
      elevation: 30,
      child: Container(
        margin: const EdgeInsets.all(20),
        // height: 500,
        width: 300,
        color: Colors.white,
        child: Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return validateName(value!);
              },
              controller: _nameController,
              decoration: const InputDecoration(
                label: Text('NAME'),
                prefixIcon: Icon(Icons.person),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.5)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              keyboardType: TextInputType.number,
              controller: _numController,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              decoration: const InputDecoration(
                label: Text("Contact number"),
                prefixIcon: Icon(Icons.quick_contacts_dialer),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.5)),
              ),
              validator: (value) {
                if (value!.isEmpty) {
                  return "* Required";
                }else if (value.length < 10) {
                  return "Number should be at least 10 characters";
                }
              },
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              validator: (value) {
                return validateEmail(value!);
              },
              decoration: const InputDecoration(
                label: Text("Email"),
                prefixIcon: Icon(Icons.email),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.5)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              controller: _passController,
              validator: (value) {
                if (value!.isEmpty) {
                  return "* Required";
                } else if (value.trim().contains(" ")) {
                  return "no space allowed";
                } else if (value.length < 6) {
                  return "Password should be atleast 6 characters";
                }
              },
              decoration: const InputDecoration(
                label: Text("Password"),
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.5)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                if (value!.isEmpty) {
                  return "* Required";
                }
                if (value.length < 6) {
                  return "Password should be atleast 6 characters";
                }
                if (value != _passController.text) {
                  return "Password does not match";
                }
              },
              decoration: const InputDecoration(
                label: Text("Conform Password"),
                prefixIcon: Icon(Icons.lock),
                border: OutlineInputBorder(),
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange)),
                focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.5)),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              onPressed: () async{
                if (formkey.currentState!.validate()) {
                  await SharedPreferences.getInstance().then((prefs) {
                    prefs.setString('email', _emailController.text.toString());
                    prefs.setString('password', _passController.text.toString());
                    prefs.setString('mobile', _numController.text.toString());
                    prefs.setString('name', _nameController.text.toString());
                  });

                  Get.offAllNamed(Routes.HOME);
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
              ),
              child: !controller.showLoader.value
                  ? const Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 20, color: Colors.white),
                    )
                  : const SizedBox(
                      width: 20,
                      height: 20,
                      child: CircularProgressIndicator(
                        color: Colors.black,
                        strokeWidth: 1,
                      ),
                    ),
            )
          ],
        ),
      ),
    );
  }
}
