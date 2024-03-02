import 'package:magistr_code/feature/domain/entities/salary_entity.dart';

class SalaryModel extends SalaryEntity {
  const SalaryModel(
      {required super.salary,
      required super.advance,
      required super.prize,
      required super.total,
      required super.isConfirm});

  factory SalaryModel.fromJson(Map<String, dynamic> json) {
    return SalaryModel(
      salary: json.containsKey("3") ? json["3"]["salary"] : 0,
      advance: json.containsKey("0") ? json["0"]["salary"] : 0,
      prize: json.containsKey("2") ? json["2"]["salary"] : 0,
      total: json.containsKey("1") ? json["1"]["salary"] : 0,
      isConfirm: json.containsKey("1"),
    );
  }
}
