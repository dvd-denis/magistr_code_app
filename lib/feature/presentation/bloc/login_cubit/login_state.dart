import 'package:equatable/equatable.dart';
import 'package:magistr_code/feature/domain/entities/user_entity.dart';

abstract class UserLoginState extends Equatable {
  const UserLoginState();

  @override
  List<Object?> get props => [];
}

class UserLoginEmpty extends UserLoginState {}

class UserLoginStart extends UserLoginState {}

class UserLoginLoaded extends UserLoginState {
  final UserEntity user;

  const UserLoginLoaded({required this.user});

  @override
  List<Object?> get props => [user];
}

class UserLoginError extends UserLoginState {
  final String message;

  const UserLoginError({required this.message});

  @override
  List<Object?> get props => [message];
}
