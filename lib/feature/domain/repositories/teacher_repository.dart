import 'package:dartz/dartz.dart';
import 'package:magistr_code/core/error/failure.dart';
import 'package:magistr_code/feature/domain/entities/salary_entity.dart';
import 'package:magistr_code/feature/domain/entities/teacher_group_entity.dart';
import 'package:magistr_code/feature/domain/entities/teacher_groups_entity.dart';
import 'package:magistr_code/feature/domain/entities/teacher_lessons_entity.dart';

abstract class TeacherRepository {
  Future<Either<Failure, List<TeacherLessonsEntity>>> getTeacherLessons(
      String token);

  Future<Either<Failure, List<TeacherGroupsEntity>>> getTeacherGroups(
      String token);

  Future<Either<Failure, TeacherGroupEntity>> getTeacherGroup(
      String token, String id);

  Future<Either<Failure, void>> setStudentGrade(
      String token, String lessonId, String studentId, String type);

  Future<Either<Failure, void>> setLessonFinished(
      String token, String id, int finished);

  Future<Either<Failure, List<SalaryEntity>>> getSalary(
      String token, String id);
}
