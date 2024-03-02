import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:magistr_code/core/error/failure.dart';
import 'package:magistr_code/feature/domain/entities/salary_entity.dart';
import 'package:magistr_code/feature/domain/usecases/get_salary.dart';
import 'package:magistr_code/feature/presentation/bloc/salary_cubit/salary_state.dart';

class SalaryCubit extends Cubit<SalaryState> {
  final GetSalary getSalary;

  bool isFerstFetch = true;

  SalaryCubit({required this.getSalary}) : super(SalaryEmpty());

  void load(String token, String id) async {
    if (state is SalaryLoading) return;

    final currentState = state;

    var oldSalaries = <SalaryEntity>[];

    if (currentState is SalaryLoaded) {
      oldSalaries = currentState.salaries;
    }

    emit(SalaryLoading(oldSalaries, isFisrtFetch: isFerstFetch));
    isFerstFetch = false;

    final failureOrSalary =
        await getSalary(GetSalaryParams(token: token, id: id));

    emit(failureOrSalary.fold(
      (l) => SalaryError(message: _mapFailureFromMessage(l)),
      (r) {
        return SalaryLoaded(salaries: r);
      },
    ));
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
