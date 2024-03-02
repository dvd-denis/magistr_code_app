import 'package:equatable/equatable.dart';

typedef UUID = String;

class TeacherGroupsEntity extends Equatable {
  final UUID id;
  final String name;
  final String workplaces;
  final List<GroupEntity> groups;

  const TeacherGroupsEntity({
    required this.id,
    required this.name,
    required this.workplaces,
    required this.groups,
  });

  @override
  List<Object?> get props => [
        id,
        name,
        workplaces,
        groups,
      ];
}

class GroupEntity extends Equatable {
  final UUID id;
  final String name;
  final String weekDays;
  final String workPlaces;

  const GroupEntity({
    required this.id,
    required this.name,
    required this.weekDays,
    required this.workPlaces,
  });

  @override
  List<Object?> get props => [id, name, weekDays, workPlaces];
}
