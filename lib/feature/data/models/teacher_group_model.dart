import 'package:magistr_code/feature/domain/entities/teacher_group_entity.dart';

class TeacherGroupModel extends TeacherGroupEntity {
  const TeacherGroupModel({
    required super.id,
    required super.name,
    required super.weekDays,
    required super.workPlaces,
    required super.directionName,
    required super.lessons,
    required super.journal,
  });

  factory TeacherGroupModel.fromJson(Map<String, dynamic> json) {
    List<LessonModel> lessons = [];
    Map<String, List<JournalModel>> journal = {};

    lessons = json['lessons']
        .map<LessonModel>((json) => LessonModel.fromJson(json))
        .toList();

    json['journal'].forEach((date, journalData) {
      journal[date] = (journalData as List)
          .map((jorunal) => JournalModel.fromJson(jorunal))
          .toList();
    });

    return TeacherGroupModel(
      id: json['id'],
      name: json['name'],
      weekDays: json['weekdays'],
      workPlaces: json['workplaces'],
      directionName: json['direction_name'],
      lessons: lessons,
      journal: journal,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'weekdays': weekDays,
      'workplaces': workPlaces,
      'lessons': lessons,
    };
  }
}

class LessonModel extends LessonEntity {
  const LessonModel(
      {required super.id,
      required super.theme,
      required super.time,
      required super.date,
      required super.comment,
      required super.duration,
      required super.canceled,
      required super.finished});

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'],
      theme: json['theme'],
      comment: json['comment'],
      date: json['date'],
      time: json['time'],
      duration: json['duration'],
      canceled: json['canceled'],
      finished: json['finished'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'theme': theme,
      'comment': comment,
      'date': date,
      'time': time,
      'duration': duration,
      'canceled': canceled,
      'finished': finished,
    };
  }
}

class JournalModel extends JournalEntity {
  const JournalModel({
    required super.id,
    required super.name,
    required super.lessonId,
    required super.type,
  });

  factory JournalModel.fromJson(Map<String, dynamic> json) {
    return JournalModel(
      id: json['id'],
      lessonId: json['lesson_id'],
      name: json['name'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'lesson_id': lessonId,
      'name': name,
      'type': type,
    };
  }
}
