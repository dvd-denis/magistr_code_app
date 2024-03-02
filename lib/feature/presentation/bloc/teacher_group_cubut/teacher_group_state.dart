import 'package:equatable/equatable.dart';
import 'package:magistr_code/feature/domain/entities/teacher_group_entity.dart';

abstract class TeacherGroupState extends Equatable {
  const TeacherGroupState();

  @override
  List<Object> get props => [];
}

class TeacherGroupEmpty extends TeacherGroupState {}

class TeacherGroupLoading extends TeacherGroupState {
  final TeacherGroupEntity? oldTeacherGroup;
  final bool isFisrtFetch;

  const TeacherGroupLoading(this.oldTeacherGroup, {this.isFisrtFetch = false});

  @override
  List<Object> get props => [isFisrtFetch];
}

class TeacherGroupLoaded extends TeacherGroupState {
  final TeacherGroupEntity teacherGroup;

  const TeacherGroupLoaded({required this.teacherGroup});

  @override
  List<Object> get props => [teacherGroup];
}

class TeacherGroupError extends TeacherGroupState {
  final String message;

  const TeacherGroupError({required this.message});

  @override
  List<Object> get props => [message];
}
