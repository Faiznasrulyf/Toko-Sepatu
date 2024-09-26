import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:sepatuv5/helpers/auth_helper.dart';
import 'package:sepatuv5/main.dart';
import 'package:sepatuv5/models/todo_model.dart';

class DatabaseHelper {
  DatabaseHelper._privateConstructor();
  static final DatabaseHelper _instance = DatabaseHelper._privateConstructor();
  static DatabaseHelper get instance => _instance;

  static Databases? databases;

  init() {
    databases = Databases(client);
  }

  createTodo({
    required String namalengkap,
    required String nomortelepon,
    required String alamat1,
    required String alamat2,
    required String alamat3,
  }) async {
    databases ?? init();
    try {
      String? userId = await AuthHelper.instance.getUserId();
      await databases!.createDocument(
          databaseId: "6570c5124004b45a3357",
          collectionId: "6570c51891e6accb243b",
          documentId: ID.unique(),
          data: {
            "namalengkap": namalengkap,
            "nomortelepon": nomortelepon,
            "alamat1": alamat1,
            "alamat2": alamat2,
            "alamat3": alamat3,
            "createdAt": DateTime.now().toIso8601String(),
            "userId": userId,
          });
      return true;
    } catch (e) {
      rethrow;
    }
  }

  getTodos() async {
    databases ?? init();
    try {
      String userId = await AuthHelper.instance.getUserId() ?? "";
      DocumentList response = await databases!.listDocuments(
        databaseId: "6570c5124004b45a3357",
        collectionId: "6570c51891e6accb243b",
        queries: [
          Query.equal("userId", userId),
        ],
      );
      return response.documents
          .map(
            (e) => TodoModel.fromJson(e.data, e.$id),
          )
          .toList();
    } catch (e) {
      rethrow;
    }
  }

  void updateTodo(TodoModel todo) async {
    databases ?? init();
    try {
      await databases!.updateDocument(
        databaseId: "6570c5124004b45a3357",
        collectionId: "6570c51891e6accb243b",
        documentId: todo.id,
        data: {
          "namalengkap": todo.namalengkap,
          "nomortelepon": todo.nomortelepon,
          "alamat1": todo.alamat1,
          "alamat2": todo.alamat2,
          "alamat3": todo.alamat3,
          "createdAt": todo.createdAt.toIso8601String(),
          "userId": todo.userId,
        },
      );
    } catch (e) {
      rethrow;
    }
  }

  void deleteTodo(String id) async {
    databases ?? init();
    try {
      await databases!.deleteDocument(
        databaseId: "6570c5124004b45a3357",
        collectionId: "6570c51891e6accb243b",
        documentId: id,
      );
    } catch (e) {
      rethrow;
    }
  }
}
