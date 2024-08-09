import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:todonest/model/todo_model.dart';

class DatabaseService {
  final CollectionReference todoCollection =
      FirebaseFirestore.instance.collection("todos");

  User? user = FirebaseAuth.instance.currentUser;

  //Add ToDo Task
  Future<DocumentReference> addToDoTask(
      String title, String description) async {
    return await todoCollection.add({
      'uid': user!.uid,
      'title': title,
      'description': description,
      'completed': false,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  //Update ToDo Task
  Future<void> updateToDoTask(
      String id, String title, String description) async {
    final updateToDoCollection =
        FirebaseFirestore.instance.collection('todos').doc(id);
    return await updateToDoCollection.update({
      'title': title,
      'description': description,
    });
  }

  //Update ToDo Status
  Future<void> updateToDoStatus(String id, bool completed) async {
    return await todoCollection.doc(id).update({'completed': completed});
  }

  //Delete ToDo Task
  Future<void> deleteTodoTask(
    String id,
  ) async {
    return await todoCollection.doc(id).delete();
  }

  //Get Pending Task
  Stream<List<TodoModel>> get todos {
    return todoCollection
        .where('uid', isEqualTo: user!.uid)
        .where('completed', isEqualTo: false)
        .snapshots()
        .map(_todoListFromSnapshot);
  }

  //Get Complete Task
  Stream<List<TodoModel>> get completedtodos {
    return todoCollection
        .where('uid', isEqualTo: user!.uid)
        .where('completed', isEqualTo: true)
        .snapshots()
        .map(_todoListFromSnapshot);
  }

  List<TodoModel> _todoListFromSnapshot(QuerySnapshot snapshot) {
    return snapshot.docs.map((doc) {
      return TodoModel(
        id: doc.id,
        title: doc['title'] ?? '',
        description: doc['description'] ?? '',
        completed: doc['completed'] ?? false,
        timestamp: doc['createdAt'] ?? '',
      );
    }).toList();
  }
}
