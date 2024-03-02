import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magistr_code/core/error/failure.dart';
import 'package:magistr_code/feature/domain/usecases/user.dart';
import 'package:magistr_code/feature/presentation/bloc/login_cubit/login_state.dart';

class UserLoginCubit extends Cubit<UserLoginState> {
  final Login login;

  UserLoginCubit({required this.login}) : super(UserLoginEmpty());

  auth(String token) async {
    emit(UserLoginStart());

    final failureOrUser = await login(UserParams(token: token));
    emit(failureOrUser.fold(
        (failure) => UserLoginError(message: _mapFailureFromMessage(failure)),
        (user) => UserLoginLoaded(user: user)));
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
