import 'package:equatable/equatable.dart';
import 'package:magistr_code/feature/domain/entities/teacher_groups_entity.dart';

abstract class TeacherGroupsState extends Equatable {
  const TeacherGroupsState();

  @override
  List<Object> get props => [];
}

class TeacherGroupsEmpty extends TeacherGroupsState {}

class TeacherGroupsLoading extends TeacherGroupsState {
  final List<TeacherGroupsEntity> oldTeacherGroups;
  final bool isFisrtFetch;

  const TeacherGroupsLoading(this.oldTeacherGroups,
      {this.isFisrtFetch = false});

  @override
  List<Object> get props => [oldTeacherGroups, isFisrtFetch];
}

class TeacherGroupsLoaded extends TeacherGroupsState {
  final List<TeacherGroupsEntity> teacherGroups;

  const TeacherGroupsLoaded({required this.teacherGroups});

  @override
  List<Object> get props => [teacherGroups];
}

class TeacherGroupsError extends TeacherGroupsState {
  final String message;

  const TeacherGroupsError({required this.message});

  @override
  List<Object> get props => [message];
}
