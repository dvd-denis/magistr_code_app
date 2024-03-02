import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magistr_code/feature/domain/entities/teacher_lessons_entity.dart';
import 'package:magistr_code/feature/domain/entities/user_entity.dart';
import 'package:magistr_code/feature/presentation/bloc/teacher_lessons_cubit/teacher_lessons_cubit.dart';
import 'package:magistr_code/feature/presentation/bloc/teacher_lessons_cubit/teacher_lessons_state.dart';
import 'package:magistr_code/feature/presentation/widgets/side_menu.dart';
import 'package:magistr_code/feature/presentation/widgets/teacher_lessons_widget.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  @override
  Widget build(BuildContext context) {
    final user = ModalRoute.of(context)!.settings.arguments as UserEntity;
    BlocProvider.of<TeacherLessonsCubit>(context).load(user.token);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(),
      drawer: SideMenu(user: user),
      body: Container(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              "Статистика",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 24),
            ),
            const SizedBox.square(
              dimension: 23,
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffd8c4f3),
              ),
              margin: const EdgeInsets.only(bottom: 15),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
              child: Text(
                "Кол-во групп: ${user.groupsCount}",
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: const Color(0xffd8c4f3),
              ),
              margin: const EdgeInsets.only(bottom: 23),
              width: double.infinity,
              padding: const EdgeInsets.symmetric(
                horizontal: 10,
                vertical: 12,
              ),
              child: Text(
                "Кол-во учеников: ${user.studentsCount}",
                style: const TextStyle(fontSize: 20),
              ),
            ),
            Expanded(
              child: BlocBuilder<TeacherLessonsCubit, TeacherLessonsState>(
                builder: (context, state) {
                  List<TeacherLessonsEntity> teacherLessons = [];

                  if (state is TeacherLessonsLoading && state.isFisrtFetch) {
                    return _loadingIndicator();
                  } else if (state is TeacherLessonsLoading) {
                    teacherLessons = state.oldTeacherLessons;
                  } else if (state is TeacherLessonsLoaded) {
                    teacherLessons = state.teacherLessons;
                  }

                  return TeacherLessonsWidget(
                      user: user, teacherGroups: teacherLessons);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _loadingIndicator() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
