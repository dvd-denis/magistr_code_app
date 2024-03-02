import 'package:magistr_code/feature/domain/entities/teacher_lessons_entity.dart';

class TeacherLessonsModel extends TeacherLessonsEntity {
  const TeacherLessonsModel({
    required super.id,
    required super.name,
    required super.workplaces,
    required super.lessons,
  });

  factory TeacherLessonsModel.fromJson(Map<String, dynamic> json) {
    Map<String, List<LessonModel>> lessonsByDate = {};
    json['lessons'].forEach((date, lessonsData) {
      lessonsByDate[date] = (lessonsData as List)
          .map((lesson) => LessonModel.fromJson(lesson))
          .toList();
    });
    return TeacherLessonsModel(
      id: json['id'],
      name: json['name'],
      workplaces: json['workplaces'],
      lessons: lessonsByDate,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'lessons': lessons,
      'workplaces': workplaces
    };
  }
}

class LessonModel extends LessonEntity {
  const LessonModel({
    required super.id,
    required super.groupId,
    required super.name,
    required super.theme,
    required super.time,
    required super.date,
    required super.duration,
    required super.teacher,
  });

  factory LessonModel.fromJson(Map<String, dynamic> json) {
    return LessonModel(
      id: json['id'],
      groupId: json['group_id'],
      theme: json['theme'],
      date: json['date'],
      time: json['time'],
      duration: json['duration'],
      teacher: TeacherModel.fromJson(json['teacher']),
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'theme': theme,
      'time': time,
      'date': date,
      'duration': duration,
      'teacher': teacher,
    };
  }
}

class TeacherModel extends TeacherEntity {
  const TeacherModel({
    required super.id,
    required super.name,
    required super.surName,
    required super.middleName,
  });

  factory TeacherModel.fromJson(Map<String, dynamic> json) {
    return TeacherModel(
      id: json['id'],
      name: json['name'],
      surName: json['sur_name'],
      middleName: json['middle_name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'middle_name': middleName,
      'sur_name': surName,
    };
  }
}
