import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:magistr_code/feature/domain/entities/teacher_group_entity.dart';
import 'package:magistr_code/feature/domain/entities/user_entity.dart';
import 'package:magistr_code/feature/presentation/bloc/teacher_group_cubut/teacher_group_cubit.dart';

class JournalWidget extends StatefulWidget {
  final UserEntity user;
  final TeacherGroupEntity group;
  final String? lessonDate;

  const JournalWidget({
    super.key,
    required this.user,
    required this.group,
    this.lessonDate,
  });

  @override
  State<JournalWidget> createState() => _JournalWidgetState();
}

class _JournalWidgetState extends State<JournalWidget>
    with TickerProviderStateMixin {
  late TabController tabController;
  final List<String> listGrades = <String>[
    "1",
    "2",
    "3",
    "4",
    "5",
    "я",
    "н",
  ];

  _initTabController() {
    int currentLessonIndex = 0;

    if (widget.lessonDate != null) {
      for (var element in widget.group.journal.entries) {
        if (element.key != widget.lessonDate) {
          currentLessonIndex++;
        } else {
          break;
        }
      }
    } else {
      for (var element in widget.group.journal.entries) {
        if (DateFormat("yyyy-MM-dd").parse(element.key).isBefore(
              DateTime.now(),
            )) {
          currentLessonIndex++;
        }
      }
    }
    // TODO replace with update annotation
    if (currentLessonIndex >= widget.group.journal.length) {
      currentLessonIndex = 0;
      for (var element in widget.group.journal.entries) {
        if (DateFormat("yyyy-MM-dd").parse(element.key).isBefore(
              DateTime.now(),
            )) {
          currentLessonIndex++;
        }
      }
    }

    tabController = TabController(
        length: widget.group.journal.length,
        initialIndex: currentLessonIndex,
        vsync: this)
      ..addListener(() {
        setState(() {});
      });
  }

  @override
  void initState() {
    _initTabController();
    super.initState();
  }

  @override
  void didUpdateWidget(covariant JournalWidget oldWidget) {
    if (oldWidget.group != widget.group) {
      _initTabController();
    }
    super.didUpdateWidget(oldWidget);
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final journal = widget.group.journal;

    return Container(
      margin: const EdgeInsets.only(bottom: 23),
      width: double.infinity,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Журнал",
                style: TextStyle(fontSize: 22),
              ),
              Text(
                DateFormat.MMMM().format(DateFormat("yyyy-MM-dd")
                    .parse(journal.entries.elementAt(tabController.index).key)),
                style: const TextStyle(fontSize: 18),
              ),
            ],
          ),
          TabBar(
            isScrollable: true,
            controller: tabController,
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
            tabs: journal.entries
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
            children: List.generate(journal.length, (index) {
              final students = journal.values.elementAt(index);
              return List.generate(students.length, (index) {
                final student = students[index];

                return Container(
                  padding: const EdgeInsets.all(5),
                  margin: const EdgeInsets.only(top: 5, bottom: 5),
                  decoration: BoxDecoration(
                    shape: BoxShape.rectangle,
                    border: Border.all(
                      width: 2,
                      color: const Color.fromRGBO(144, 64, 245, 1.0),
                    ),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          student.name,
                          style: const TextStyle(fontSize: 12),
                        ),
                        Align(
                          alignment: Alignment.center,
                          child: ToggleButtons(
                            direction: Axis.horizontal,
                            onPressed: (int index) {
                              setState(() {
                                BlocProvider.of<TeacherGroupCubit>(context)
                                    .setGrade(
                                        widget.user.token,
                                        student.lessonId,
                                        student.id,
                                        listGrades[index]);
                                BlocProvider.of<TeacherGroupCubit>(context)
                                    .load(widget.user.token, widget.group.id);
                                tabController.animateTo(tabController.index);
                              });
                            },
                            borderRadius:
                                const BorderRadius.all(Radius.circular(8)),
                            selectedBorderColor: Colors.red[700],
                            selectedColor: Colors.white,
                            fillColor: Colors.red[200],
                            color: Colors.red[400],
                            constraints: const BoxConstraints(
                              minHeight: 30.0,
                              minWidth: 30.0,
                            ),
                            isSelected: () {
                              final List<bool> selectedGrades = <bool>[
                                false,
                                false,
                                false,
                                false,
                                false,
                                false,
                                false,
                              ];
                              for (int i = 0; i < selectedGrades.length; i++) {
                                selectedGrades[i] =
                                    listGrades[i] == student.type;
                              }

                              return selectedGrades;
                            }(),
                            children: List.generate(listGrades.length,
                                (index) => Text(listGrades[index])),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              });
            })[tabController.index],
          ),
          const SizedBox.square(
            dimension: 20,
          ),
        ],
      ),
    );
  }
}
