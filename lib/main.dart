import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:intl/intl.dart';
import 'package:intl/intl_standalone.dart';
import 'package:magistr_code/feature/presentation/bloc/login_cubit/login_cubit.dart';
import 'package:magistr_code/feature/presentation/bloc/salary_cubit/salary_cubit.dart';
import 'package:magistr_code/feature/presentation/bloc/teacher_group_cubut/teacher_group_cubit.dart';
import 'package:magistr_code/feature/presentation/bloc/teacher_groups_cubut/teacher_groups_cubit.dart';
import 'package:magistr_code/feature/presentation/bloc/teacher_lessons_cubit/teacher_lessons_cubit.dart';
import 'package:magistr_code/feature/presentation/pages/group_screen.dart';
import 'package:magistr_code/feature/presentation/pages/login_screen.dart';
import 'package:magistr_code/feature/presentation/pages/main_screen.dart';
import 'package:magistr_code/feature/presentation/pages/profile_screen.dart';
import 'package:magistr_code/feature/presentation/pages/salary_screen.dart';
import 'package:magistr_code/locator_service.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  await initializeDateFormatting("ru");
  Intl.systemLocale = await findSystemLocale();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<UserLoginCubit>(create: (context) {
          return di.sl<UserLoginCubit>();
        }),
        BlocProvider<TeacherLessonsCubit>(
            create: (context) => di.sl<TeacherLessonsCubit>()),
        BlocProvider<TeacherGroupsCubit>(
            create: (context) => di.sl<TeacherGroupsCubit>()),
        BlocProvider<TeacherGroupCubit>(
            create: (context) => di.sl<TeacherGroupCubit>()),
        BlocProvider<SalaryCubit>(create: (context) => di.sl<SalaryCubit>()),
      ],
      child: MaterialApp(
        title: 'Flutter Magistr code',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.purpleAccent),
          useMaterial3: true,
          primaryColor: Colors.deepPurple,
          fontFamily: "Montserrat",
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              padding: const EdgeInsets.only(
                  left: 60, right: 60, top: 15, bottom: 15),
              textStyle: const TextStyle(
                color: Colors.white,
                fontSize: 20,
              ),
              backgroundColor: const Color.fromRGBO(144, 64, 245, 1.0),
            ),
          ),
        ),
        home: const LoginPage(),
        routes: {
          '/login': (context) => const LoginPage(),
          '/main': (context) => const MainPage(),
          '/group': (context) => const GroupPage(),
          '/profile': (context) => const ProfilePage(),
          '/salary': (context) => const SalaryPage(),
        },
      ),
    );
  }
}
