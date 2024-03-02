import 'package:get_it/get_it.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:magistr_code/core/platform/network_info.dart';
import 'package:magistr_code/feature/data/datasources/teacher_remote_datasource.dart';
import 'package:magistr_code/feature/data/datasources/user_local_datasource.dart';
import 'package:magistr_code/feature/data/datasources/user_remote_datasource.dart';
import 'package:magistr_code/feature/data/repositories/teacher_repository_impl.dart';
import 'package:magistr_code/feature/data/repositories/user_repository_impl.dart';
import 'package:magistr_code/feature/domain/repositories/teacher_repository.dart';
import 'package:magistr_code/feature/domain/repositories/user_repository.dart';
import 'package:magistr_code/feature/domain/usecases/get_salary.dart';
import 'package:magistr_code/feature/domain/usecases/get_teacher_group.dart';
import 'package:magistr_code/feature/domain/usecases/get_teacher_groups.dart';
import 'package:magistr_code/feature/domain/usecases/get_teacher_lessons.dart';
import 'package:magistr_code/feature/domain/usecases/user.dart';
import 'package:magistr_code/feature/presentation/bloc/login_cubit/login_cubit.dart';

import 'package:http/http.dart' as http;
import 'package:magistr_code/feature/presentation/bloc/salary_cubit/salary_cubit.dart';
import 'package:magistr_code/feature/presentation/bloc/teacher_group_cubut/teacher_group_cubit.dart';
import 'package:magistr_code/feature/presentation/bloc/teacher_groups_cubut/teacher_groups_cubit.dart';
import 'package:magistr_code/feature/presentation/bloc/teacher_lessons_cubit/teacher_lessons_cubit.dart';
import 'package:shared_preferences/shared_preferences.dart';

final sl = GetIt.instance;

Future<void> init() async {
  // Bloc / Cubit
  sl.registerFactory(() => UserLoginCubit(login: sl()));
  sl.registerFactory(() => SalaryCubit(getSalary: sl()));
  sl.registerFactory(() => TeacherLessonsCubit(getTeacherLessons: sl()));
  sl.registerFactory(() => TeacherGroupsCubit(getTeacherGroups: sl()));
  sl.registerFactory(() => TeacherGroupCubit(
        getTeacherGroup: sl(),
        setStudentGrade: sl(),
        setLessonFinished: sl(),
      ));

  // UseCases
  sl.registerLazySingleton(() => Login(userRepository: sl()));
  sl.registerLazySingleton(() => Exit(userRepository: sl()));
  sl.registerLazySingleton(() => GetTeacherLessons(teacherRepository: sl()));
  sl.registerLazySingleton(() => GetTeacherGroups(teacherRepository: sl()));
  sl.registerLazySingleton(() => GetTeacherGroup(teacherRepository: sl()));
  sl.registerLazySingleton(() => SetStudentGrade(teacherRepository: sl()));
  sl.registerLazySingleton(() => SetLessonFinished(teacherRepository: sl()));
  sl.registerLazySingleton(() => GetSalary(teacherRepository: sl()));

  // Repositories
  sl.registerLazySingleton<UserRepository>(() => UserRepositoryImpl(
        remoteDataSource: sl(),
        localDataSource: sl(),
        networkInfo: sl(),
      ));

  sl.registerLazySingleton<TeacherRepository>(
      () => TeacherRepositoryImpl(networkInfo: sl(), remoteDataSource: sl()));

  sl.registerLazySingleton<UserRemoteDataSource>(
      () => UserRemoteDataSourceImpl(client: sl()));

  sl.registerLazySingleton<UserLocalDataSource>(
      () => UserLocalDataSourceImpl(sharedPreferences: sl()));

  sl.registerLazySingleton<TeacherRemoteDataSource>(
      () => TeacherRemoteDataSourceImpl(client: sl()));

  // Core

  sl.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(
        connectionChecker: sl(),
      ));

  // External
  final sharedPreferences = await SharedPreferences.getInstance();
  sl.registerLazySingleton(() => sharedPreferences);
  sl.registerLazySingleton(() => http.Client());
  sl.registerLazySingleton(() => InternetConnectionChecker());
}
