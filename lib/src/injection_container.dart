import 'package:get_it/get_it.dart';
import 'package:playground/src/features/todo/data/datasources/todo_local_data_source_impl.dart';
import 'package:playground/src/features/todo/data/repositories/todo_repository_imp.dart';
import 'package:playground/src/features/todo/domain/repositories/i_todo_repository.dart';
import 'package:playground/src/features/todo/presentation/cubit/todo_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

class InjectionContainer {
  final sl = GetIt.instance;
  Future<void> init() async {
    final prefs = await SharedPreferences.getInstance();
    sl.registerLazySingleton(() => prefs);
    sl.registerLazySingleton(() => TodoLocalDataSourceImpl(sl()));
    sl.registerLazySingleton<ITodoRepository>(() => TodoRepositoryImpl(sl()));
    sl.registerFactory(() => TodoCubit(sl()));
  }
}
