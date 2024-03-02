import 'package:equatable/equatable.dart';

class SalaryEntity extends Equatable {
  final int? salary;
  final int? advance;
  final int? prize;
  final int? total;
  final bool isConfirm;

  const SalaryEntity(
      {required this.salary,
      required this.advance,
      required this.prize,
      required this.total,
      required this.isConfirm});

  @override
  List<Object?> get props => [salary, advance, prize, total, isConfirm];
}
