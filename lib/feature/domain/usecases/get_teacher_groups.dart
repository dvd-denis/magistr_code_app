import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:magistr_code/core/error/failure.dart';
import 'package:magistr_code/core/usecases/usecase.dart';
import 'package:magistr_code/feature/domain/entities/teacher_groups_entity.dart';
import 'package:magistr_code/feature/domain/repositories/teacher_repository.dart';

class GetTeacherGroups
    extends UseCase<List<TeacherGroupsEntity>, TeacherGroupsParams> {
  final TeacherRepository teacherRepository;

  GetTeacherGroups({required this.teacherRepository});

  @override
  Future<Either<Failure, List<TeacherGroupsEntity>>> call(
      TeacherGroupsParams params) async {
    return await teacherRepository.getTeacherGroups(params.token);
  }
}

class TeacherGroupsParams extends Equatable {
  final String token;

  const TeacherGroupsParams({required this.token});

  @override
  List<Object?> get props => [token];
}
