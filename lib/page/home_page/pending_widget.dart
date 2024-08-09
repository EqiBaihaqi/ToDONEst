import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:todonest/controllers/home_controller.dart';
import 'package:todonest/model/todo_model.dart';

class PendingWidget extends StatelessWidget {
  const PendingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final homeController = Get.put(HomeController());
    return StreamBuilder<List<TodoModel>>(
        stream: homeController.databaseService.todos,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            List<TodoModel> todos = snapshot.data!;
            return ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: todos.length,
                itemBuilder: (context, index) {
                  TodoModel todo = todos[index];
                  final DateTime dt = todo.timestamp.toDate();
                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Slidable(
                      key: ValueKey(todo.id),
                      endActionPane: ActionPane(
                        motion: DrawerMotion(),
                        children: [
                          SlidableAction(
                            backgroundColor: Colors.green,
                            foregroundColor: Colors.white,
                            icon: CupertinoIcons.check_mark_circled,
                            label: 'Done',
                            onPressed: (context) {
                              homeController.databaseService
                                  .updateToDoStatus(todo.id, true);
                            },
                          ),
                        ],
                      ),
                      startActionPane: ActionPane(
                        motion: const DrawerMotion(),
                        children: [
                          SlidableAction(
                            backgroundColor: Colors.amber,
                            foregroundColor: Colors.white,
                            icon: Icons.edit,
                            label: 'Edit',
                            onPressed: (context) {
                              homeController.showAddTaskDialog(context,
                                  todo: todo);
                            },
                          ),
                          SlidableAction(
                            backgroundColor: Colors.red,
                            foregroundColor: Colors.white,
                            icon: CupertinoIcons.trash,
                            label: 'Delete',
                            onPressed: (context) async {
                              await homeController.databaseService
                                  .deleteTodoTask(todo.id);
                            },
                          ),
                        ],
                      ),
                      child: ListTile(
                        title: Text(
                          todo.title.toUpperCase(),
                          style: const TextStyle(fontWeight: FontWeight.bold),
                        ),
                        subtitle: Text(todo.description),
                        trailing: Text('${dt.day}/${dt.month}/${dt.year}'),
                      ),
                    ),
                  );
                });
          } else {
            return const Center(
              child: CircularProgressIndicator(
                color: Colors.white,
              ),
            );
          }
        });
  }
}
