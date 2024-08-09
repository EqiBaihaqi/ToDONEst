import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todonest/constant/color_constant.dart';
import 'package:todonest/controllers/home_controller.dart';
import 'package:todonest/page/home_page/home_alert_dialog_logout.dart';
import 'package:todonest/page/home_page/home_selection.dart';
import 'package:todonest/page/home_page/toolbar_selection.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return Scaffold(
      backgroundColor: ColorGeneral.background,
      appBar: AppBar(
        backgroundColor: ColorGeneral.background,
        foregroundColor: Colors.white,
        toolbarHeight: 80,
        title: const Row(
          children: [
            Text(
              'ToDO',
              style: TextStyle(
                  color: Color(0xFFB2EBF2), fontWeight: FontWeight.bold),
            ),
            Text(
              'NEst',
              style: TextStyle(
                  color: Color(0xFFFFD700), fontWeight: FontWeight.bold),
            )
          ],
        ),
        actions: [
          IconButton(
              onPressed: () {
                showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return const AlertDialogLogout();
                    });
              },
              icon: const Icon(CupertinoIcons.square_arrow_right))
        ],
      ),
      body: const Padding(
        padding: EdgeInsets.all(4.0),
        child: Column(
          children: [
            SizedBox(
              height: 20,
            ),
            ToolbarSelection(),
            SizedBox(
              height: 20,
            ),
            HomeSelection(),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.white,
        child: Icon(
          Icons.format_list_bulleted_add,
          color: ColorGeneral.primary,
        ),
        onPressed: () {
          homeController.showAddTaskDialog(context);
        },
      ),
    );
  }
}
