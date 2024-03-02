import 'package:dartz/dartz.dart';
import 'package:magistr_code/core/error/failure.dart';
import 'package:magistr_code/core/platform/network_info.dart';
import 'package:magistr_code/feature/data/datasources/teacher_remote_datasource.dart';
import 'package:magistr_code/feature/data/models/salary_model.dart';
import 'package:magistr_code/feature/data/models/teacher_group_model.dart';
import 'package:magistr_code/feature/data/models/teacher_groups_model.dart';
import 'package:magistr_code/feature/data/models/teacher_lessons_model.dart';
import 'package:magistr_code/feature/domain/repositories/teacher_repository.dart';

class TeacherRepositoryImpl implements TeacherRepository {
  final TeacherRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  TeacherRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<TeacherLessonsModel>>> getTeacherLessons(
      String token) async {
    if (await networkInfo.isConnected) {
      final remoteTeacherLessons =
          await remoteDataSource.getTeacherLessons(token);
      return Right(remoteTeacherLessons);
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<TeacherGroupsModel>>> getTeacherGroups(
      String token) async {
    if (await networkInfo.isConnected) {
      final remoteTeacherGroups =
          await remoteDataSource.getTeacherGroups(token);
      return Right(remoteTeacherGroups);
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, TeacherGroupModel>> getTeacherGroup(
      String token, String id) async {
    if (await networkInfo.isConnected) {
      final remoteTeacherGroup =
          await remoteDataSource.getTeacherGroup(token, id);
      return Right(remoteTeacherGroup);
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setStudentGrade(
      String token, String lessonId, String studentId, String type) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.setGradeStudent(
          token, lessonId, studentId, type);
      return Right(result);
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> setLessonFinished(
      String token, String id, int finished) async {
    if (await networkInfo.isConnected) {
      final result =
          await remoteDataSource.setLessonFinished(token, id, finished);
      return Right(result);
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, List<SalaryModel>>> getSalary(
      String token, String id) async {
    if (await networkInfo.isConnected) {
      final result = await remoteDataSource.getSalary(token, id);
      return Right(result);
    } else {
      return Left(ServerFailure());
    }
  }
}
