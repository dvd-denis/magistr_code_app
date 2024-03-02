import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magistr_code/core/error/failure.dart';
import 'package:magistr_code/feature/domain/entities/teacher_lessons_entity.dart';
import 'package:magistr_code/feature/domain/usecases/get_teacher_lessons.dart';
import 'package:magistr_code/feature/presentation/bloc/teacher_lessons_cubit/teacher_lessons_state.dart';

class TeacherLessonsCubit extends Cubit<TeacherLessonsState> {
  final GetTeacherLessons getTeacherLessons;

  bool isFerstFetch = true;

  TeacherLessonsCubit({required this.getTeacherLessons})
      : super(TeacherLessonsEmpty());

  void load(String token) async {
    if (state is TeacherLessonsLoading) return;

    final currentState = state;

    var oldTeacherGroups = <TeacherLessonsEntity>[];

    if (currentState is TeacherLessonsLoaded) {
      oldTeacherGroups = currentState.teacherLessons;
    }

    emit(TeacherLessonsLoading(oldTeacherGroups, isFisrtFetch: isFerstFetch));
    isFerstFetch = false;

    final failureOrTeacherLessons =
        await getTeacherLessons(TeacherLessonsParams(token: token));

    emit(failureOrTeacherLessons.fold(
      (l) => TeacherLessonsError(message: _mapFailureFromMessage(l)),
      (r) {
        return TeacherLessonsLoaded(teacherLessons: r);
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
