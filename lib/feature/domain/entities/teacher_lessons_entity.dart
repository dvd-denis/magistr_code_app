import 'package:equatable/equatable.dart';

typedef UUID = String;

class TeacherLessonsEntity extends Equatable {
  final UUID id; // branch id
  final String name;
  final String workplaces;
  final Map<String, List<LessonEntity>> lessons;

  const TeacherLessonsEntity({
    required this.id,
    required this.name,
    required this.workplaces,
    required this.lessons,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        workplaces,
        lessons,
      ];
}

class LessonEntity extends Equatable {
  final UUID id;
  final UUID groupId;
  final String name;
  final String theme;
  final String time;
  final String date;
  final int duration;
  final TeacherEntity teacher;

  const LessonEntity({
    required this.id,
    required this.groupId,
    required this.name,
    required this.theme,
    required this.time,
    required this.date,
    required this.duration,
    required this.teacher,
  });

  @override
  List<Object?> get props =>
      [id, groupId, name, theme, date, time, duration, teacher];
}

class TeacherEntity extends Equatable {
  final UUID id;
  final String name;
  final String surName;
  final String middleName;

  const TeacherEntity({
    required this.id,
    required this.name,
    required this.surName,
    required this.middleName,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        surName,
        middleName,
      ];
}
