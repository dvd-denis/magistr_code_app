import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:magistr_code/feature/domain/entities/teacher_lessons_entity.dart';
import 'package:magistr_code/feature/domain/entities/user_entity.dart';
import 'package:magistr_code/feature/presentation/pages/group_screen.dart';

class TeacherLessonsWidget extends StatefulWidget {
  final UserEntity user;
  final List<TeacherLessonsEntity> teacherGroups;

  const TeacherLessonsWidget(
      {super.key, required this.user, required this.teacherGroups});

  @override
  State<TeacherLessonsWidget> createState() => _TeacherLessonsWidgetState();
}

class _TeacherLessonsWidgetState extends State<TeacherLessonsWidget>
    with TickerProviderStateMixin {
  late List<TabController> _tabControllers;

  @override
  void initState() {
    super.initState();
    _tabControllers = [];
  }

  _handleTabSelection(index) {
    if (_tabControllers[index].indexIsChanging) {
      setState(() {});
    }
  }

  @override
  void dispose() {
    for (final controller in _tabControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        physics: const AlwaysScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          final teacherGroup = widget.teacherGroups[index];
          int currentLessonIndex = 0;
          for (var element in teacherGroup.lessons.entries) {
            if (DateFormat("yyyy-MM-dd")
                .parse(element.key)
                .isBefore(DateTime.now())) {
              currentLessonIndex++;
            }
          }

          _tabControllers.add(
            TabController(
              length: teacherGroup.lessons.length,
              initialIndex: currentLessonIndex,
              vsync: this,
            ),
          );
          _tabControllers[index].addListener(
            () => _handleTabSelection(
              index,
            ),
          );

          return Container(
            margin: const EdgeInsets.only(bottom: 23),
            width: double.infinity,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      teacherGroup.name,
                      style: const TextStyle(fontSize: 22),
                    ),
                    Text(
                      DateFormat.MMMM().format(DateFormat("yyyy-MM-dd").parse(
                          teacherGroup.lessons.entries
                              .elementAt(_tabControllers[index].index)
                              .key)),
                      style: const TextStyle(fontSize: 18),
                    ),
                  ],
                ),
                TabBar(
                  isScrollable: true,
                  controller: _tabControllers[index],
                  indicatorSize: TabBarIndicatorSize.label,
                  overlayColor: MaterialStateProperty.all(Colors.transparent),
                  indicator: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(
                      color: const Color.fromRGBO(144, 64, 245, 1.0),
                    ),
                  ),
                  padding: const EdgeInsets.all(10),
                  dividerHeight: 0,
                  tabs: teacherGroup.lessons.entries
                      .map(
                        (e) => Tab(
                          height: 80,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            child: Align(
                              alignment: Alignment.center,
                              child: Text(
                                "${DateFormat.d().format(DateFormat("yyyy-MM-dd").parse(e.key))}\n`${DateFormat.E().format(DateFormat("yyyy-MM-dd").parse(e.key))}",
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      )
                      .toList(),
                ),
                Column(
                  children: List.generate(teacherGroup.lessons.length, (index) {
                    final lessons =
                        teacherGroup.lessons.values.elementAt(index);

                    lessons.sort((lessonA, lessonB) {
                      return DateFormat("HH:mm:ss")
                          .parse(lessonA.time)
                          .compareTo(
                              DateFormat("HH:mm:ss").parse(lessonB.time));
                    });

                    return List.generate(lessons.length, (index) {
                      final lesson = lessons[index];
                      return InkWell(
                        splashFactory: NoSplash.splashFactory,
                        onTap: () {
                          Navigator.of(context).pushNamed(
                            "/group",
                            arguments: GroupArguments(
                                user: widget.user,
                                lesson: lesson,
                                groupId: lesson.groupId),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(5),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "${DateFormat("HH:mm").format(DateFormat("HH:mm:ss").parse(lesson.time))}-${DateFormat("HH:mm").format(
                                  DateFormat("HH:mm:ss").parse(lesson.time).add(
                                        Duration(minutes: lesson.duration),
                                      ),
                                )}",
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
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        lesson.name,
                                        textAlign: TextAlign.start,
                                      ),
                                      Text(
                                          "${lesson.teacher.surName} ${lesson.teacher.name.characters.first}. ${lesson.teacher.middleName.characters.first}.")
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    });
                  })[_tabControllers[index].index],
                ),
                const SizedBox.square(
                  dimension: 20,
                ),
              ],
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Divider(
            color: Colors.grey[400],
          );
        },
        itemCount: widget.teacherGroups.length);
  }
}
