import 'package:playground/src/features/todo/domain/entities/todo.dart';

abstract class ITodoRepository {
  Future<List<Todo>> getTodos();
  Future<void> saveTodos(List<Todo> todos);
}
