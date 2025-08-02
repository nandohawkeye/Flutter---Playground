import 'package:playground/src/features/todo/data/models/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoLocalDataSource {
  static const key = 'todo_list';

  final SharedPreferences prefs;

  TodoLocalDataSource(this.prefs);

  Future<List<TodoModel>> getTodos() async {
    final jsonString = prefs.getString(key);
    if (jsonString == null) return [];
    return TodoModel.fromJsonList(jsonString);
  }

  Future<void> saveTodos(List<TodoModel> todos) async {
    final json = TodoModel.toJsonList(todos);
    await prefs.setString(key, json);
  }
}
