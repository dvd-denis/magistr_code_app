import 'package:equatable/equatable.dart';
import 'package:magistr_code/feature/domain/entities/salary_entity.dart';

abstract class SalaryState extends Equatable {
  const SalaryState();

  @override
  List<Object> get props => [];
}

class SalaryEmpty extends SalaryState {}

class SalaryLoading extends SalaryState {
  final List<SalaryEntity> oldSalaries;
  final bool isFisrtFetch;

  const SalaryLoading(this.oldSalaries, {this.isFisrtFetch = false});

  @override
  List<Object> get props => [isFisrtFetch];
}

class SalaryLoaded extends SalaryState {
  final List<SalaryEntity> salaries;

  const SalaryLoaded({required this.salaries});

  @override
  List<Object> get props => [salaries];
}

class SalaryError extends SalaryState {
  final String message;

  const SalaryError({required this.message});

  @override
  List<Object> get props => [message];
}
