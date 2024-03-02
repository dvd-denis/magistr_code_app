import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:magistr_code/core/error/failure.dart';
import 'package:magistr_code/core/usecases/usecase.dart';
import 'package:magistr_code/feature/domain/entities/user_entity.dart';
import 'package:magistr_code/feature/domain/repositories/user_repository.dart';

class Login extends UseCase<UserEntity, UserParams> {
  final UserRepository userRepository;

  Login({required this.userRepository});

  @override
  Future<Either<Failure, UserEntity>> call(UserParams params) async {
    return await userRepository.login(params.token);
  }
}

class UserParams extends Equatable {
  final String token;

  const UserParams({required this.token});

  @override
  List<Object?> get props => [token];
}

class Exit extends UseCase<void, void> {
  final UserRepository userRepository;

  Exit({required this.userRepository});

  @override
  Future<Either<Failure, void>> call(void params) async {
    return await userRepository.exit();
  }
}
