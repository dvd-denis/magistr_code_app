import 'package:equatable/equatable.dart';

typedef UUID = String;

class UserEntity extends Equatable {
  final UUID id;
  final UUID token;
  final String name;
  final String surName;
  final String middleName;
  final String dateOfBirth;
  final String email;
  final String phoneNumber;
  final String snils;
  final String pasport;
  final String address;
  final int groupsCount;
  final int studentsCount;
  final int stake;
  final int paymentType;
  final DateTime createdAt;
  final DateTime updatedAt;

  const UserEntity(
      {required this.id,
      required this.token,
      required this.name,
      required this.surName,
      required this.middleName,
      required this.dateOfBirth,
      required this.email,
      required this.phoneNumber,
      required this.snils,
      required this.pasport,
      required this.address,
      required this.groupsCount,
      required this.studentsCount,
      required this.stake,
      required this.paymentType,
      required this.createdAt,
      required this.updatedAt});

  @override
  List<Object?> get props => [
        id,
        name,
        surName,
        middleName,
        dateOfBirth,
        email,
        phoneNumber,
        snils,
        pasport,
        address,
        groupsCount,
        studentsCount,
        stake,
        paymentType,
        createdAt,
        updatedAt
      ];
}
