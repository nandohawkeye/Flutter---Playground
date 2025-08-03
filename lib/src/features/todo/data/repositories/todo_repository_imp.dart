import 'package:playground/src/features/todo/data/datasources/todo_local_data_source_impl.dart';
import 'package:playground/src/features/todo/data/models/todo_model.dart';
import 'package:playground/src/features/todo/domain/entities/todo.dart';
import 'package:playground/src/features/todo/domain/repositories/i_todo_repository.dart';

class TodoRepositoryImpl implements ITodoRepository {
  final TodoLocalDataSourceImpl local;

  TodoRepositoryImpl(this.local);

  @override
  Future<List<Todo>> getTodos() async {
    return await local.getTodos();
  }

  @override
  Future<void> saveTodos(List<Todo> todos) async {
    final models = todos.map((t) => TodoModel.fromEntity(t)).toList();
    await local.saveTodos(models);
  }
}
