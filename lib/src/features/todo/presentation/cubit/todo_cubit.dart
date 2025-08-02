import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playground/src/features/todo/domain/entities/todo.dart';
import 'package:playground/src/features/todo/domain/repositories/i_todo_repository.dart';
import 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final ITodoRepository repository;

  TodoCubit(this.repository) : super(const TodoState([])) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    final todos = await repository.getTodos();
    emit(TodoState(todos));
  }

  Future<void> addTodo(String title) async {
    final newList = List<Todo>.from(state.todos)..add(Todo(title: title));
    await repository.saveTodos(newList);
    emit(TodoState(newList));
  }

  Future<void> toggleTodo(int index) async {
    final updated = state.todos[index];
    final newList = List<Todo>.from(state.todos)
      ..[index] = Todo(title: updated.title, isDone: !updated.isDone);
    await repository.saveTodos(newList);
    emit(TodoState(newList));
  }

  Future<void> removeTodo(int index) async {
    final newList = List<Todo>.from(state.todos)..removeAt(index);
    await repository.saveTodos(newList);
    emit(TodoState(newList));
  }
}
