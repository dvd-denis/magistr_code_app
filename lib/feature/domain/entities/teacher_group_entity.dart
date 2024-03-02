import 'package:equatable/equatable.dart';

typedef UUID = String;

class TeacherGroupEntity extends Equatable {
  final UUID id;
  final String name;
  final String weekDays;
  final String workPlaces;
  final String directionName;
  final List<LessonEntity> lessons;
  final Map<String, List<JournalEntity>> journal;

  const TeacherGroupEntity({
    required this.id,
    required this.name,
    required this.weekDays,
    required this.workPlaces,
    required this.directionName,
    required this.lessons,
    required this.journal,
  });

  @override
  List<Object?> get props => [id, name, weekDays, workPlaces];
}

class LessonEntity extends Equatable {
  final UUID id;
  final String theme;
  final String time;
  final String date;
  final String? comment;
  final int duration;
  final int canceled;
  final int finished;

  const LessonEntity({
    required this.id,
    required this.theme,
    required this.time,
    required this.date,
    required this.comment,
    required this.duration,
    required this.canceled,
    required this.finished,
  });

  @override
  List<Object?> get props => [id, comment, theme, date, time, duration];
}

class JournalEntity extends Equatable {
  final UUID id;
  final UUID lessonId;

  final String name;
  final String? type;

  const JournalEntity({
    required this.id,
    required this.lessonId,
    required this.name,
    required this.type,
  });

  @override
  List<Object?> get props => [id, name, type];
}
