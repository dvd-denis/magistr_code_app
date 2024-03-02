import 'package:magistr_code/feature/domain/entities/teacher_groups_entity.dart';

class TeacherGroupsModel extends TeacherGroupsEntity {
  const TeacherGroupsModel({
    required super.id,
    required super.name,
    required super.workplaces,
    required super.groups,
  });

  factory TeacherGroupsModel.fromJson(Map<String, dynamic> json) {
    List<GroupModel> groups = [];
    groups = json['groups']
        .map<GroupModel>((json) => GroupModel.fromJson(json))
        .toList();
    return TeacherGroupsModel(
      id: json['id'],
      name: json['name'],
      workplaces: json['workplaces'],
      groups: groups,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'groups': groups,
      'workplaces': workplaces,
    };
  }
}

class GroupModel extends GroupEntity {
  const GroupModel({
    required super.id,
    required super.name,
    required super.weekDays,
    required super.workPlaces,
  });

  factory GroupModel.fromJson(Map<String, dynamic> json) {
    return GroupModel(
      id: json['id'],
      name: json['name'],
      weekDays: json['weekdays'],
      workPlaces: json['workplaces'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'weekdays': weekDays,
      'workplaces': workPlaces,
    };
  }
}
