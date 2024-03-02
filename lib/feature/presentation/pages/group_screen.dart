import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:magistr_code/feature/domain/entities/teacher_group_entity.dart';
import 'package:magistr_code/feature/domain/entities/teacher_lessons_entity.dart'
    as teacher_lessons;
import 'package:magistr_code/feature/domain/entities/user_entity.dart';
import 'package:magistr_code/feature/presentation/bloc/teacher_group_cubut/teacher_group_cubit.dart';
import 'package:magistr_code/feature/presentation/bloc/teacher_group_cubut/teacher_group_state.dart';
import 'package:magistr_code/feature/presentation/widgets/journal_widget.dart';
import 'package:magistr_code/feature/presentation/widgets/side_menu.dart';

class GroupPage extends StatelessWidget {
  const GroupPage({super.key});

  @override
  Widget build(BuildContext context) {
    final arg = ModalRoute.of(context)!.settings.arguments as GroupArguments;
    final user = arg.user;
    final lesson = arg.lesson;
    BlocProvider.of<TeacherGroupCubit>(context).load(user.token, arg.groupId);
    return Scaffold(
      appBar: AppBar(),
      drawer: lesson != null ? null : SideMenu(user: user),
      body: BlocBuilder<TeacherGroupCubit, TeacherGroupState>(
        builder: (context, state) {
          late TeacherGroupEntity teacherGroup;

          if (state is TeacherGroupLoading && state.isFisrtFetch) {
            return _loadingIndicator();
          } else if (state is TeacherGroupLoading) {
            if (state.oldTeacherGroup != null) {
              teacherGroup = state.oldTeacherGroup!;
            } else {
              return _loadingIndicator();
            }
          } else if (state is TeacherGroupLoaded) {
            teacherGroup = state.teacherGroup;
          }
          var lessons = teacherGroup.lessons;
          lessons.sort((lessonA, lessonB) {
            return DateFormat("yyyy-MM-dd")
                .parse(lessonA.date)
                .compareTo(DateFormat("yyyy-MM-dd").parse(lessonB.date));
          });

          return Container(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text(
                  teacherGroup.name,
                  textAlign: TextAlign.center,
                  style: const TextStyle(fontSize: 24),
                ),
                const SizedBox.square(
                  dimension: 23,
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: const Color(0xffd8c4f3), width: 2),
                  ),
                  margin: const EdgeInsets.only(bottom: 15),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 12,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        teacherGroup.directionName,
                        style: const TextStyle(fontSize: 14),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            textAlign: TextAlign.start,
                            "${DateFormat("HH:mm").format(DateFormat("HH:mm:ss").parse(teacherGroup.lessons.first.time))}-${DateFormat("HH:mm").format(
                              DateFormat("HH:mm:ss")
                                  .parse(teacherGroup.lessons.first.time)
                                  .add(
                                    Duration(
                                        minutes: teacherGroup
                                            .lessons.first.duration),
                                  ),
                            )}",
                          ),
                          Text(
                            "${teacherGroup.workPlaces} Мест",
                            style: const TextStyle(fontSize: 12),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border:
                        Border.all(color: const Color(0xffd8c4f3), width: 2),
                  ),
                  margin: const EdgeInsets.only(bottom: 23),
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 12,
                  ),
                  child: Text(
                    "Кол-во учеников: ${teacherGroup.journal.values.first.length}",
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
                Expanded(
                    child: ListView(
                  physics: const AlwaysScrollableScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  children: [
                    JournalWidget(
                      user: user,
                      group: teacherGroup,
                      lessonDate: lesson?.date,
                    ),
                    Theme(
                      data: Theme.of(context)
                          .copyWith(dividerColor: Colors.transparent),
                      child: ExpansionTile(
                        initiallyExpanded: true,
                        title: const Text(
                          "Лекции",
                          style: TextStyle(fontSize: 18),
                        ),
                        expandedCrossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Container(
                              margin: const EdgeInsets.only(top: 20),
                              child: const Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("Завершено: 0"),
                                  Text("Отменено: 0"),
                                  Text("Осталось: 0"),
                                  Text("Всего: 0"),
                                ],
                              ),
                            ),
                          ),
                          Container(
                            margin: const EdgeInsets.only(top: 20),
                            child: Column(
                              children: List.generate(
                                  teacherGroup.lessons.length, (index) {
                                final lesson = lessons[index];
                                return Container(
                                  padding: const EdgeInsets.all(5),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Checkbox(
                                        value: lesson.finished == 1,
                                        onChanged: (value) {
                                          if (value != null) {
                                            BlocProvider.of<TeacherGroupCubit>(
                                                    context)
                                                .setFinished(user.token,
                                                    lesson.id, value ? 1 : 0);
                                            BlocProvider.of<TeacherGroupCubit>(
                                                    context)
                                                .load(user.token, arg.groupId);
                                          }
                                        },
                                      ),
                                      Expanded(
                                        child: Container(
                                          padding: const EdgeInsets.all(10),
                                          margin: const EdgeInsets.all(10),
                                          decoration: BoxDecoration(
                                            shape: BoxShape.rectangle,
                                            border: Border.all(
                                              width: 2,
                                              color: const Color.fromRGBO(
                                                  144, 64, 245, 1.0),
                                            ),
                                            borderRadius:
                                                BorderRadius.circular(20),
                                          ),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    lesson.date,
                                                    textAlign: TextAlign.start,
                                                  ),
                                                  const Text(
                                                    "Редактировать",
                                                    textAlign: TextAlign.start,
                                                    style:
                                                        TextStyle(fontSize: 10),
                                                  ),
                                                ],
                                              ),
                                              Text(
                                                lesson.theme,
                                                textAlign: TextAlign.start,
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              }),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                )),
              ],
            ),
          );
        },
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

class GroupArguments {
  final UserEntity user;
  final String groupId;
  final teacher_lessons.LessonEntity? lesson;

  GroupArguments({required this.user, required this.groupId, this.lesson});
}
