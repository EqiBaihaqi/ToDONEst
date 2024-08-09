import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:todonest/controllers/home_controller.dart';
import 'package:todonest/page/home_page/completed_widget.dart';
import 'package:todonest/page/home_page/pending_widget.dart';

class HomeSelection extends StatelessWidget {
  const HomeSelection({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Obx(() => homeController.buttonPending.value
        ? const PendingWidget()
        : const CompletedWidget());
  }
}
