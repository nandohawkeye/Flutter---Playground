import 'dart:convert';
import 'package:playground/src/features/todo/domain/entities/todo.dart';

class TodoModel extends Todo {
  TodoModel({required super.title, super.isDone = false});

  factory TodoModel.fromMap(Map<String, dynamic> json) {
    return TodoModel(title: json['title'], isDone: json['isDone']);
  }

  Map<String, dynamic> toMap() => {'title': title, 'isDone': isDone};

  static List<TodoModel> fromJsonList(String source) {
    final list = (source.isEmpty)
        ? []
        : List<Map<String, dynamic>>.from(json.decode(source));
    return list.map((e) => TodoModel.fromMap(e)).toList();
  }

  static String toJsonList(List<TodoModel> todos) {
    return json.encode(todos.map((e) => e.toMap()).toList());
  }

  static TodoModel fromEntity(Todo todo) =>
      TodoModel(title: todo.title, isDone: todo.isDone);
}
