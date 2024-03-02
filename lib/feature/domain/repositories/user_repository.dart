import 'package:dartz/dartz.dart';
import 'package:magistr_code/core/error/failure.dart';
import 'package:magistr_code/feature/domain/entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, UserEntity>> login(String token);
  Future<Either<Failure, void>> exit();
}
