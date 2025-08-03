import 'package:playground/src/features/todo/data/datasources/i_todo_local_data_source.dart';
import 'package:playground/src/features/todo/data/models/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TodoLocalDataSourceImpl implements ITodoLocalDatasource {
  static const key = 'todo_list';

  final SharedPreferences prefs;

  TodoLocalDataSourceImpl(this.prefs);

  @override
  Future<List<TodoModel>> getTodos() async {
    final jsonString = prefs.getString(key);
    if (jsonString == null) return [];
    return TodoModel.fromJsonList(jsonString);
  }

  @override
  Future<void> saveTodos(List<TodoModel> todos) async {
    final json = TodoModel.toJsonList(todos);
    await prefs.setString(key, json);
  }
}
