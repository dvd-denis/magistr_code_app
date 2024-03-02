import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magistr_code/core/error/failure.dart';
import 'package:magistr_code/feature/domain/entities/teacher_group_entity.dart';
import 'package:magistr_code/feature/domain/usecases/get_teacher_group.dart';
import 'package:magistr_code/feature/presentation/bloc/teacher_group_cubut/teacher_group_state.dart';

class TeacherGroupCubit extends Cubit<TeacherGroupState> {
  final GetTeacherGroup getTeacherGroup;
  final SetStudentGrade setStudentGrade;
  final SetLessonFinished setLessonFinished;

  bool isFerstFetch = true;

  TeacherGroupCubit(
      {required this.getTeacherGroup,
      required this.setStudentGrade,
      required this.setLessonFinished})
      : super(TeacherGroupEmpty());

  void load(String token, String id) async {
    if (state is TeacherGroupLoading) return;

    final currentState = state;

    TeacherGroupEntity? oldTeacherGroup;

    if (currentState is TeacherGroupLoaded) {
      oldTeacherGroup = currentState.teacherGroup;
    }

    emit(TeacherGroupLoading(oldTeacherGroup, isFisrtFetch: isFerstFetch));
    isFerstFetch = false;

    final failureOrTeacherGroup =
        await getTeacherGroup(TeacherGroupParams(token: token, id: id));

    emit(failureOrTeacherGroup.fold(
      (l) => TeacherGroupError(message: _mapFailureFromMessage(l)),
      (r) {
        return TeacherGroupLoaded(teacherGroup: r);
      },
    ));
  }

  void setGrade(String token, String lessonId, String studentId, String type) {
    setStudentGrade(SetStudentGradeParams(
        token: token, lessonId: lessonId, studentId: studentId, type: type));
  }

  void setFinished(String token, String id, int finished) {
    setLessonFinished(
        SetLessonFinishedParams(token: token, id: id, finished: finished));
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
