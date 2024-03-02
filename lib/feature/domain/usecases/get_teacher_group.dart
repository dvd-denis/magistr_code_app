import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:magistr_code/core/error/failure.dart';
import 'package:magistr_code/core/usecases/usecase.dart';
import 'package:magistr_code/feature/domain/entities/teacher_group_entity.dart';
import 'package:magistr_code/feature/domain/repositories/teacher_repository.dart';

class GetTeacherGroup extends UseCase<TeacherGroupEntity, TeacherGroupParams> {
  final TeacherRepository teacherRepository;

  GetTeacherGroup({required this.teacherRepository});

  @override
  Future<Either<Failure, TeacherGroupEntity>> call(
      TeacherGroupParams params) async {
    return await teacherRepository.getTeacherGroup(params.token, params.id);
  }
}

class TeacherGroupParams extends Equatable {
  final String token;
  final String id;

  const TeacherGroupParams({required this.token, required this.id});

  @override
  List<Object?> get props => [token, id];
}

class SetStudentGrade extends UseCase<void, SetStudentGradeParams> {
  final TeacherRepository teacherRepository;

  SetStudentGrade({required this.teacherRepository});

  @override
  Future<Either<Failure, void>> call(SetStudentGradeParams params) async {
    return await teacherRepository.setStudentGrade(
        params.token, params.lessonId, params.studentId, params.type);
  }
}

class SetStudentGradeParams extends Equatable {
  final String token;
  final String lessonId;
  final String studentId;
  final String type;

  const SetStudentGradeParams(
      {required this.token,
      required this.lessonId,
      required this.studentId,
      required this.type});

  @override
  List<Object?> get props => [token, lessonId, studentId, type];
}

class SetLessonFinished extends UseCase<void, SetLessonFinishedParams> {
  final TeacherRepository teacherRepository;

  SetLessonFinished({required this.teacherRepository});

  @override
  Future<Either<Failure, void>> call(SetLessonFinishedParams params) async {
    return await teacherRepository.setLessonFinished(
        params.token, params.id, params.finished);
  }
}

class SetLessonFinishedParams extends Equatable {
  final String token;
  final String id;
  final int finished;

  const SetLessonFinishedParams({
    required this.token,
    required this.id,
    required this.finished,
  });

  @override
  List<Object?> get props => [token, id, finished];
}
