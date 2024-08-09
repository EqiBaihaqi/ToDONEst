import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todonest/page/sigin_in_page/sign_in_page.dart';
import 'package:todonest/services/auth_service.dart';

class SignUpController extends GetxController {
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

  void signupAccount() async {
    try {
      await AuthService().registerWithEmailAndPassword(
          emailController.text, passwordController.text);
      Get.snackbar(
        "Berhasil",
        "Akun berhasil didaftarkan",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
        colorText: Colors.white,
      );
      Get.off(const SignInPage());
    } catch (e) {
      e.toString();
      Get.snackbar(
        "Gagal",
        "Pendaftaran akun gagal: ${e.toString()}",
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
      );
    }
  }

}
