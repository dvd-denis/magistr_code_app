import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:magistr_code/core/error/failure.dart';
import 'package:magistr_code/core/usecases/usecase.dart';
import 'package:magistr_code/feature/domain/entities/salary_entity.dart';
import 'package:magistr_code/feature/domain/repositories/teacher_repository.dart';

class GetSalary extends UseCase<List<SalaryEntity>, GetSalaryParams> {
  final TeacherRepository teacherRepository;

  GetSalary({required this.teacherRepository});

  @override
  Future<Either<Failure, List<SalaryEntity>>> call(
      GetSalaryParams params) async {
    return await teacherRepository.getSalary(params.token, params.id);
  }
}

class GetSalaryParams extends Equatable {
  final String token;
  final String id;

  const GetSalaryParams({required this.token, required this.id});

  @override
  List<Object?> get props => [token, id];
}
