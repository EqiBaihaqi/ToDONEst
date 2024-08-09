import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todonest/constant/color_constant.dart';
import 'package:todonest/controllers/sign_in_controller.dart';

class AlertDialogLogout extends StatelessWidget {
  const AlertDialogLogout({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignInController());
    return AlertDialog(
      title: const Text("Log Out"),
      content: const Text("Apa Anda yakin ingin logout?"),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            GestureDetector(
              onTap: () {
                controller.signOutAccount();
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: ColorGeneral.background)),
                width: 100,
                height: 40,
                child: const Text('Iya'),
              ),
            ),
            GestureDetector(
              onTap: () {
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border.all(color: ColorGeneral.background)),
                width: 100,
                height: 40,
                child: const Text('Tidak'),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
