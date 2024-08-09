import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todonest/page/home_page/home_page.dart';
import 'package:todonest/page/sigin_in_page/sign_in_page.dart';
import 'package:todonest/services/auth_service.dart';
import 'package:todonest/utils/shared_preferences_login.dart';

class SignInController extends GetxController {
  final errorMessageEmail = Rxn<String>();
  final errorMessagePassword = Rxn<String>();
  RxBool isFormValid = false.obs;

  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    emailController.dispose();
    passwordController.dispose();
  }

  void _validateForm() {
    isFormValid.value = errorMessageEmail.value == null &&
        errorMessagePassword.value == null &&
        emailController.text.isNotEmpty &&
        passwordController.text.isNotEmpty;
  }

  void validatorEmail(String value) {
    if (value.isEmpty) {
      errorMessageEmail.value = "Email tidak boleh kosong";
    } else if (!value.contains('@')) {
      errorMessageEmail.value = "Format email tidak valid";
    } else {
      errorMessageEmail.value = null;
    }
    _validateForm();
  }

  void validatorPassword(String value) {
    if (value.isEmpty) {
      errorMessagePassword.value = "Kata sandi tidak boleh kosong";
    } else if (value.length < 8) {
      errorMessagePassword.value = "Kata sandi harus lebih dari 8 huruf";
    } else {
      errorMessagePassword.value = null;
    }
    _validateForm();
  }

  void signinAccount() async {
    try {
      await AuthService().signInWithEmailAndPassword(
          emailController.text, passwordController.text);

      SharedPrefLogin.saveToken(email: emailController.text);
      Get.snackbar(
        "Berhasil",
        "Sign in berhasil",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.offAll(const HomePage());
    } catch (e) {
      print(e.toString());
      Get.snackbar(
        "Gagal",
        "Sign in gagal: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

  void signOutAccount() async {
    try {
      await AuthService().logOut();
      SharedPrefLogin.logOut();
      Get.offAll(const SignInPage());
      Get.snackbar(
        "Berhasil",
        "Log out berhasil",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar(
        "Gagal",
        "Sign out gagal: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }
}
