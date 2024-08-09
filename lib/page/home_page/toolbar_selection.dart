import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todonest/constant/color_constant.dart';
import 'package:todonest/controllers/home_controller.dart';

class ToolbarSelection extends StatelessWidget {
  const ToolbarSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Container(
      width: 298,
      height: 40,
      margin: const EdgeInsets.symmetric(horizontal: 58),
      decoration: BoxDecoration(color: ColorGeneral.primary),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          GestureDetector(
            onTap: () {
              homeController.selectPending();
            },
            child: Obx(
              () => Container(
                width: 123,
                height: 32,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: homeController.buttonPending.value
                        ? Colors.black
                        : ColorGeneral.primary),
                child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Pending',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ),
          ),
          Obx(
            () => GestureDetector(
              onTap: () {
                homeController.selectCompleted();
              },
              child: Container(
                width: 123,
                height: 32,
                margin: const EdgeInsets.all(4),
                decoration: BoxDecoration(
                    color: homeController.buttonPending.value
                        ? ColorGeneral.primary
                        : Colors.black),
                child: const Align(
                    alignment: Alignment.center,
                    child: Text(
                      'Completed',
                      style: TextStyle(color: Colors.white),
                    )),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
