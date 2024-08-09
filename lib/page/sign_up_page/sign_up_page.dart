import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todonest/constant/color_constant.dart';
import 'package:todonest/controllers/sign_up_controller.dart';
import 'package:todonest/page/sigin_in_page/sign_in_page.dart';
import 'package:todonest/widget/elevated_button_widget.dart';
import 'package:todonest/widget/text_field_widget.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    final signupController = Get.put(SignUpController());
    return Scaffold(
      backgroundColor: ColorGeneral.background,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: ColorGeneral.background,
        foregroundColor: Colors.white,
        title: const Text(
          'Sign up new account',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              const SizedBox(
                height: 60,
              ),
              const Icon(
                CupertinoIcons.person_badge_plus_fill,
                size: 65,
                color: Colors.white60,
              ),
              const SizedBox(
                height: 15,
              ),
              Obx(
                () => TextFieldCustomWidget(
                  controller: signupController.emailController,
                  labelText: 'Email',
                  obsecure: false,
                  textInputType: TextInputType.emailAddress,
                  errorText: signupController.errorMessageEmail.value,
                  onChange: (value) {
                    signupController.validatorEmail(value);
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => TextFieldCustomWidget(
                  controller: signupController.passwordController,
                  labelText: 'Password',
                  obsecure: true,
                  textInputType: TextInputType.text,
                  errorText: signupController.errorMessagePassword.value,
                  onChange: (value) {
                    signupController.validatorPassword(value);
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Obx(
                () => ElevatedButtonCustomWidget(
                  isEnabled: signupController.isFormValid.value,
                  labelText: 'Sign up',
                  onPressed: () {
                    signupController.signupAccount();
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'already have an account ?',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.off(() => const SignInPage());
                    },
                    child: const Text(
                      'sign in',
                      style: TextStyle(color: Colors.blue),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
