import 'package:equatable/equatable.dart';
import 'package:magistr_code/feature/domain/entities/teacher_lessons_entity.dart';

abstract class TeacherLessonsState extends Equatable {
  const TeacherLessonsState();

  @override
  List<Object> get props => [];
}

class TeacherLessonsEmpty extends TeacherLessonsState {}

class TeacherLessonsLoading extends TeacherLessonsState {
  final List<TeacherLessonsEntity> oldTeacherLessons;
  final bool isFisrtFetch;

  const TeacherLessonsLoading(this.oldTeacherLessons,
      {this.isFisrtFetch = false});

  @override
  List<Object> get props => [oldTeacherLessons, isFisrtFetch];
}

class TeacherLessonsLoaded extends TeacherLessonsState {
  final List<TeacherLessonsEntity> teacherLessons;

  const TeacherLessonsLoaded({required this.teacherLessons});

  @override
  List<Object> get props => [teacherLessons];
}

class TeacherLessonsError extends TeacherLessonsState {
  final String message;

  const TeacherLessonsError({required this.message});

  @override
  List<Object> get props => [message];
}
