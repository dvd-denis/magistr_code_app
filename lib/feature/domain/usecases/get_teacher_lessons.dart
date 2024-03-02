import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:magistr_code/core/error/failure.dart';
import 'package:magistr_code/core/usecases/usecase.dart';
import 'package:magistr_code/feature/domain/entities/teacher_lessons_entity.dart';
import 'package:magistr_code/feature/domain/repositories/teacher_repository.dart';

class GetTeacherLessons
    extends UseCase<List<TeacherLessonsEntity>, TeacherLessonsParams> {
  final TeacherRepository teacherRepository;

  GetTeacherLessons({required this.teacherRepository});

  @override
  Future<Either<Failure, List<TeacherLessonsEntity>>> call(
      TeacherLessonsParams params) async {
    return await teacherRepository.getTeacherLessons(params.token);
  }
}

class TeacherLessonsParams extends Equatable {
  final String token;

  const TeacherLessonsParams({required this.token});

  @override
  List<Object?> get props => [token];
}
