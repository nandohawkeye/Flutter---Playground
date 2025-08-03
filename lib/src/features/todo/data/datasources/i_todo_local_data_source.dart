import 'package:playground/src/features/todo/data/models/todo_model.dart';

abstract class ITodoLocalDatasource {
  Future<void> saveTodos(List<TodoModel> todos);
  Future<List<TodoModel>> getTodos();
}
