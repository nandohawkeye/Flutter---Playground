import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playground/src/features/todo/domain/entities/todo.dart';
import 'package:playground/src/features/todo/domain/repositories/i_todo_repository.dart';
import 'todo_state.dart';

class TodoCubit extends Cubit<TodoState> {
  final ITodoRepository repository;

  TodoCubit(this.repository) : super(const TodoLoading()) {
    loadTodos();
  }

  Future<void> loadTodos() async {
    try {
      final todos = await repository.getTodos();
      emit(TodoSuccess(todos));
    } catch (e) {
      emit(TodoFailure('Não foi possível buscar as tarefas', []));
    }
  }

  Future<void> addTodo(String title) async {
    final oldTodos = (state as TodoSuccess).todos;
    try {
      final newList = List<Todo>.from((state as TodoSuccess).todos)
        ..add(Todo(title: title));
      await repository.saveTodos(newList);
      emit(TodoSuccess(newList));
    } catch (e) {
      emit(TodoFailure('Não foi possível adicionar a tarefa', oldTodos));
    }
  }

  Future<void> toggleTodo(int index) async {
    final oldTodos = (state as TodoSuccess).todos;
    try {
      final updated = (state as TodoSuccess).todos[index];
      final newList = List<Todo>.from((state as TodoSuccess).todos)
        ..[index] = Todo(title: updated.title, isDone: !updated.isDone);
      await repository.saveTodos(newList);
      emit(TodoSuccess(newList));
    } catch (e) {
      emit(TodoFailure('Não foi possível salvar a tarefa', oldTodos));
    }
  }

  Future<void> removeTodo(int index) async {
    final oldTodos = (state as TodoSuccess).todos;
    try {
      final newList = List<Todo>.from((state as TodoSuccess).todos)
        ..removeAt(index);
      await repository.saveTodos(newList);
      emit(TodoSuccess(newList));
    } catch (e) {
      emit(TodoFailure('Não foi possível remover a tarefa', oldTodos));
    }
  }
}
