import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:playground/src/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:playground/src/features/todo/presentation/pages/todo_page.dart';
import 'package:playground/src/injection_container.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await InjectionContainer().init();
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Playground',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
      ),
      home: BlocProvider(
        create: (_) => InjectionContainer().sl<TodoCubit>(),
        child: TodoPage(),
      ),
    );
  }
}
