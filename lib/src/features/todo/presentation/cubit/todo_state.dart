import '../../domain/entities/todo.dart';

sealed class TodoState {
  const TodoState();
}

class TodoLoading extends TodoState {
  const TodoLoading();
}

class TodoSuccess extends TodoState {
  final List<Todo> todos;

  const TodoSuccess(this.todos);
}

class TodoFailure extends TodoState {
  final String message;
  final List<Todo> previousTodos;

  const TodoFailure(this.message, this.previousTodos);
}
