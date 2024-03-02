import 'package:magistr_code/feature/domain/entities/user_entity.dart';

class UserModel extends UserEntity {
  const UserModel(
      {required super.id,
      required super.token,
      required super.name,
      required super.surName,
      required super.middleName,
      required super.email,
      required super.phoneNumber,
      required super.createdAt,
      required super.dateOfBirth,
      required super.snils,
      required super.pasport,
      required super.address,
      required super.groupsCount,
      required super.studentsCount,
      required super.stake,
      required super.paymentType,
      required super.updatedAt});

  factory UserModel.fromJson(Map<String, dynamic> json, String token) {
    return UserModel(
      id: json['id'],
      token: token,
      name: json['name'],
      surName: json['sur_name'],
      middleName: json['middle_name'],
      dateOfBirth: json['dateOfBirth'],
      address: json['address'],
      groupsCount: json['groups_count'],
      studentsCount: json['students_count'],
      snils: json['snils'],
      pasport: json['pasport'],
      email: json['email'],
      phoneNumber: json['phone_number'],
      paymentType: json['payment_type'],
      stake: json['stake'],
      createdAt: DateTime.parse(json['created_at'] as String),
      updatedAt: DateTime.parse(json['updated_at'] as String),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'token': token,
      'name': name,
      'sur_name': surName,
      'middle_name': middleName,
      'dateOfBirth': dateOfBirth,
      'address': address,
      'groups_count': groupsCount,
      'students_count': studentsCount,
      'snils': snils,
      'pasport': pasport,
      'email': email,
      'phone_number': phoneNumber,
      'payment_type': paymentType,
      'stake': stake,
      'created_at': createdAt.toIso8601String(),
      'updated_at': createdAt.toIso8601String(),
    };
  }
}
