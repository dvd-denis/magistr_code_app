import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magistr_code/core/error/failure.dart';
import 'package:magistr_code/feature/domain/entities/teacher_groups_entity.dart';
import 'package:magistr_code/feature/domain/usecases/get_teacher_groups.dart';
import 'package:magistr_code/feature/presentation/bloc/teacher_groups_cubut/teacher_groups_state.dart';

class TeacherGroupsCubit extends Cubit<TeacherGroupsState> {
  final GetTeacherGroups getTeacherGroups;

  bool isFerstFetch = true;

  TeacherGroupsCubit({required this.getTeacherGroups})
      : super(TeacherGroupsEmpty());

  void load(String token) async {
    if (state is TeacherGroupsLoading) return;

    final currentState = state;

    var oldTeacherGroups = <TeacherGroupsEntity>[];

    if (currentState is TeacherGroupsLoaded) {
      oldTeacherGroups = currentState.teacherGroups;
    }

    emit(TeacherGroupsLoading(oldTeacherGroups, isFisrtFetch: isFerstFetch));
    isFerstFetch = false;

    final failureOrTeacherGroups =
        await getTeacherGroups(TeacherGroupsParams(token: token));

    emit(failureOrTeacherGroups.fold(
      (l) => TeacherGroupsError(message: _mapFailureFromMessage(l)),
      (r) {
        return TeacherGroupsLoaded(teacherGroups: r);
      },
    ));
  }

  String _mapFailureFromMessage(Failure failure) {
    switch (failure.runtimeType) {
      case ServerFailure:
        return "ServerFailure";
      case CacheFailure:
        return "CacheFailure";
      default:
        return "Unexpected error";
    }
  }
}
