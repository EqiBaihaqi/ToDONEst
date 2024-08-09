import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:todonest/constant/color_constant.dart';
import 'package:todonest/page/home_page/home_page.dart';
import 'package:todonest/page/sigin_in_page/sign_in_page.dart';
import 'package:todonest/utils/shared_preferences_login.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  void checkToken() async {
    String? token = await SharedPrefLogin.getToken();

    Future.delayed(const Duration(seconds: 3), () {
      if (token != null) {
        Get.off(const HomePage());
      } else {
        Get.off(const SignInPage());
      }
    });
  }

  @override
  void initState() {
    super.initState();
    checkToken();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorGeneral.background,
      body: Center(
        child: Lottie.asset(
          'assets/lottie/splash_animation.json',
          width: 250,
          height: 250,
        ),
      ),
    );
  }
}
