import 'package:faker/faker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../helper/helpers.dart';
import '../../../helper/validator.dart';
import '../../../routes/routes.dart';
import '../controllers/sign_in_controller.dart';

class SignInScreen extends GetView<SignInController> {
  SignInScreen({Key? key}) : super(key: key);

  GlobalKey<FormState> formkey = GlobalKey<FormState>();
  final TextEditingController _passController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  var faker = Faker();

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.only(top: 80),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(150),
                  child: Image.network(
                    faker.image.image(keywords: ['logo']),
                    fit: BoxFit.fill,
                    height: 150,
                    width: 150,
                  ),
                ),
              ),
              Center(
                heightFactor: 1.5,
                child: Form(
                  key: formkey,
                  child: cardForm(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Card cardForm() {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      borderOnForeground: false,
      color: Colors.white,
      shadowColor: Colors.blueGrey,
      elevation: 20,
      child: Container(
        margin: const EdgeInsets.all(20),
        width: getDeviceWidth() * .80,
        child: Column(
          children: [
            TextFormField(
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (value) {
                return validateEmail(value!);
              },
              controller: _emailController,
              keyboardType: TextInputType.emailAddress,
              decoration: const InputDecoration(
                  enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.orange)),
                  focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.green, width: 2.5)),
                  border: OutlineInputBorder(),
                  prefixIcon: Icon(
                    Icons.mail,
                    color: Colors.grey,
                  ),
                  label: Text(
                    'Email',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold),
                  )),
            ),
            const SizedBox(
              height: 20,
            ),
            TextFormField(
              controller: _passController,
              obscureText: controller.show.value,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Please, enter the password";
                } else if (value.trim().isEmpty) {
                  return "No space allowed";
                } else if (value.length < 6) {
                  return "Password should be atleast 6 characters";
                }
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(
                  Icons.lock,
                  color: Colors.grey,
                ),
                suffixIcon: IconButton(
                  onPressed: () {
                    controller.show.toggle();
                  },
                  icon: Icon(controller.show.value == true
                      ? Icons.no_cell
                      : Icons.remove_red_eye),
                  color: Colors.grey,
                ),
                border: const OutlineInputBorder(),
                enabledBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.orange)),
                focusedBorder: const OutlineInputBorder(
                    borderSide: BorderSide(color: Colors.green, width: 2.5)),
                label: const Text(
                  "Password",
                  style: TextStyle(
                      fontSize: 20,
                      color: Colors.grey,
                      fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (formkey.currentState!.validate()) {
                  String? email;
                  String? password;
                  await SharedPreferences.getInstance().then((prefs) {
                    email = prefs.getString('email');
                    password = prefs.getString('password');
                  });
                  print(email);
                  print(_emailController.text);

                  if(email != null && password != null){
                    if((_emailController.text.toString() == email) && (_passController.text.toString() == password)){
                      Get.offAllNamed(Routes.HOME);
                    }else{
                      Get.dialog(
                        AlertDialog(
                          title: const Text('Invalid Credentials'),
                          actions: [
                            TextButton(
                              child: const Text("Close"),
                              onPressed: () => Get.back(),
                            ),
                          ],
                        ),
                      );
                    }
                  }else{
                    Get.dialog(
                      AlertDialog(
                        title: const Text('Please SignUp'),
                        actions: [
                          TextButton(
                            child: const Text("Close"),
                            onPressed: () => Get.back(),
                          ),
                        ],
                      ),
                    );
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                primary: Colors.orange,
              ),
              child: !controller.showLoader.value
                  ? const Text(
                      "Sign In",
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
            ),
            const SizedBox(
              height: 12,
            ),
            _bottomSignUp(),
          ],
        ),
      ),
    );
  }

  Widget _bottomSignUp() {
    return Wrap(
      children: [
        const Text(
          "Don't have account! create new, ",
          style: TextStyle(
            fontSize: 15,
            color: Colors.grey,
          ),
        ),
        InkWell(
          onTap: () => Get.toNamed(Routes.SIGN_UP),
          child: const Text(
            "Sign Up",
            style: TextStyle(
              fontSize: 15,
              color: Colors.black,
              fontWeight: FontWeight.bold,
              decoration: TextDecoration.underline,
            ),
          ),
        ),
      ],
    );
  }
}
