import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:playground/src/features/todo/data/datasources/todo_local_data_source_impl.dart';
import 'package:playground/src/features/todo/data/models/todo_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MockSharedPreferences extends Mock implements SharedPreferences {}

void main() {
  late TodoLocalDataSourceImpl datasource;
  late MockSharedPreferences mockPrefs;
  const String todosKey = 'todo_list';

  setUp(() {
    mockPrefs = MockSharedPreferences();
    datasource = TodoLocalDataSourceImpl(mockPrefs);
  });

  final todoList = [
    TodoModel(title: 'Test', isDone: false),
    TodoModel(title: 'Do homework', isDone: true),
  ];

  test('should save everyone\'s list in SharedPreferences', () async {
    final todos = [TodoModel(title: 'test', isDone: false)];

    when(() => mockPrefs.setString(any(), any())).thenAnswer((_) async => true);

    await datasource.saveTodos(todos);

    final expectedJson = jsonEncode(todos.map((e) => e.toMap()).toList());

    verify(() => mockPrefs.setString(todosKey, expectedJson)).called(1);
  });

  test('should return list of all Todos in SharedPreferences', () async {
    final todosMap = [
      {'title': 'test', 'isDone': false},
    ];
    final jsonString = jsonEncode(todosMap);

    when(() => mockPrefs.getString(todosKey)).thenReturn(jsonString);

    final result = await datasource.getTodos();

    expect(result.length, 1);
    expect(result.first.title, 'test');
  });

  test('should return empty list if there is no data', () async {
    when(() => mockPrefs.getString(todosKey)).thenReturn(null);

    final result = await datasource.getTodos();

    expect(result, []);
  });

  test('Should throw exception when invalid JSON is returned', () async {
    when(() => mockPrefs.getString(todosKey)).thenReturn('string inválida');

    expect(() => datasource.getTodos(), throwsA(isA<FormatException>()));
  });

  test('Should throw an exception if setString returns false', () async {
    when(
      () => mockPrefs.setString(todosKey, any()),
    ).thenAnswer((_) async => false);

    expect(() => datasource.saveTodos(todoList), throwsException);
  });
}
