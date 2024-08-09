import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todonest/constant/color_constant.dart';
import 'package:todonest/controllers/sign_in_controller.dart';
import 'package:todonest/page/sign_up_page/sign_up_page.dart';
import 'package:todonest/widget/elevated_button_widget.dart';
import 'package:todonest/widget/text_field_widget.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});

  @override
  Widget build(BuildContext context) {
    final sigininCOntroller = Get.put(SignInController());
    return Scaffold(
      backgroundColor: ColorGeneral.background,
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: ColorGeneral.background,
        foregroundColor: Colors.white,
        title: const Text(
          'Sign in to your account',
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
                CupertinoIcons.person_solid,
                size: 65,
                color: Colors.white60,
              ),
              const SizedBox(
                height: 15,
              ),
              Obx(
                () => TextFieldCustomWidget(
                  controller: sigininCOntroller.emailController,
                  labelText: 'Email',
                  obsecure: false,
                  textInputType: TextInputType.emailAddress,
                  errorText: sigininCOntroller.errorMessageEmail.value,
                  onChange: (value) {
                    sigininCOntroller.validatorEmail(value);
                  },
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Obx(
                () => TextFieldCustomWidget(
                  controller: sigininCOntroller.passwordController,
                  labelText: 'Password',
                  obsecure: true,
                  textInputType: TextInputType.text,
                  errorText: sigininCOntroller.errorMessagePassword.value,
                  onChange: (value) {
                    sigininCOntroller.validatorPassword(value);
                  },
                ),
              ),
              const SizedBox(
                height: 40,
              ),
              Obx(
                () => ElevatedButtonCustomWidget(
                  isEnabled: sigininCOntroller.isFormValid.value,
                  labelText: 'Sign in',
                  onPressed: () {
                    sigininCOntroller.signinAccount();
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
                    'don\'t have an account ?',
                    style: TextStyle(color: Colors.white),
                  ),
                  const SizedBox(
                    width: 5,
                  ),
                  GestureDetector(
                    onTap: () {
                      Get.off(const SignUpPage());
                    },
                    child: const Text(
                      'sign up',
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
