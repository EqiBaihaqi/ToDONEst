import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:todonest/constant/color_constant.dart';
import 'package:todonest/model/todo_model.dart';
import 'package:todonest/services/database_service.dart';

class HomeController extends GetxController {
  final RxBool buttonPending = true.obs;
  final DatabaseService databaseService = DatabaseService();
  User? user = FirebaseAuth.instance.currentUser;
  late String uid;

  @override
  void onInit() {
    uid = FirebaseAuth.instance.currentUser!.uid;
    super.onInit();
  }

  void selectPending() {
    buttonPending.value = true;
  }

  void selectCompleted() {
    buttonPending.value = false;
  }

  void showAddTaskDialog(BuildContext context, {TodoModel? todo}) {
    final TextEditingController titleController =
        TextEditingController(text: todo?.title);
    final TextEditingController descriptionController =
        TextEditingController(text: todo?.description);

    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            backgroundColor: Colors.white,
            title: Text(
              todo == null ? 'Add Task' : 'Edit Task',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            content: SingleChildScrollView(
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Column(
                  children: [
                    TextField(
                      controller: titleController,
                      decoration: const InputDecoration(
                          labelText: 'Title', border: OutlineInputBorder()),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextField(
                      controller: descriptionController,
                      decoration: const InputDecoration(
                          labelText: 'Description',
                          border: OutlineInputBorder()),
                    ),
                  ],
                ),
              ),
            ),
            actions: [
              TextButton(
                  onPressed: () {
                    Get.back();
                  },
                  child: const Text('Cancel')),
              ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: ColorGeneral.primary,
                    foregroundColor: Colors.white,
                  ),
                  onPressed: () async {
                    if (todo == null) {
                      await databaseService.addToDoTask(
                          titleController.text, descriptionController.text);
                    } else {
                      await databaseService.updateToDoTask(todo.id,
                          titleController.text, descriptionController.text);
                    }
                    Get.back();
                  },
                  child: Text(todo == null ? 'Add' : 'Update'))
            ],
          );
        });
  }
}
