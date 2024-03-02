import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:magistr_code/core/error/exception.dart';
import 'package:magistr_code/feature/data/models/salary_model.dart';
import 'package:magistr_code/feature/data/models/teacher_group_model.dart';
import 'package:magistr_code/feature/data/models/teacher_groups_model.dart';
import 'package:magistr_code/feature/data/models/teacher_lessons_model.dart';

abstract class TeacherRemoteDataSource {
  /// Call the GET https://bynde-studio.site/api/teacher/getLessons endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<TeacherLessonsModel>> getTeacherLessons(String token);

  /// Call the GET https://bynde-studio.site/api/teacher/getGroups endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<TeacherGroupsModel>> getTeacherGroups(String token);

  /// Call the GET https://bynde-studio.site/api/teacher/getGroup/{id} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<TeacherGroupModel> getTeacherGroup(String token, String id);

  /// Call the GET https://bynde-studio.site/api/teacher/setGradeStudent/{lesson_id}/{student_id}/{type} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> setGradeStudent(
      String token, String lessonId, String studentId, String type);

  /// Call the GET https://bynde-studio.site/api/teacher/setLessonFinished/{id}/{finished} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<void> setLessonFinished(String token, String id, int finished);

  /// Call the GET https://bynde-studio.site/api/teacher/getSalary/{id} endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<List<SalaryModel>> getSalary(String token, String id);
}

class TeacherRemoteDataSourceImpl implements TeacherRemoteDataSource {
  final http.Client client;

  TeacherRemoteDataSourceImpl({required this.client});

  @override
  Future<List<TeacherLessonsModel>> getTeacherLessons(String token) =>
      _getTeacherLessons(
          "https://bynde-studio.site/api/teacher/getLessons", token);

  Future<List<TeacherLessonsModel>> _getTeacherLessons(
      String url, String token) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body);
        List<TeacherLessonsModel> teacherLessonsModels = data
            .map<TeacherLessonsModel>(
                (json) => TeacherLessonsModel.fromJson(json))
            .toList();
        return teacherLessonsModels;
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<TeacherGroupsModel>> getTeacherGroups(String token) =>
      _getTeacherGroups(
          "https://bynde-studio.site/api/teacher/getGroups", token);

  Future<List<TeacherGroupsModel>> _getTeacherGroups(
      String url, String token) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body);
        List<TeacherGroupsModel> teacherGroupsModels = data
            .map<TeacherGroupsModel>(
                (json) => TeacherGroupsModel.fromJson(json))
            .toList();
        return teacherGroupsModels;
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<TeacherGroupModel> getTeacherGroup(String token, String id) =>
      _getTeacherGroup(
          "https://bynde-studio.site/api/teacher/getGroup/$id", token);

  Future<TeacherGroupModel> _getTeacherGroup(String url, String token) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body);
        TeacherGroupModel teacherGroupModel = TeacherGroupModel.fromJson(data);
        return teacherGroupModel;
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> setGradeStudent(
          String token, String lessonId, String studentId, String type) =>
      _setGradeStudent(
          "https://bynde-studio.site/api/teacher/setGradeStudent/$lessonId/$studentId/$type",
          token);

  Future<void> _setGradeStudent(String url, String token) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<void> setLessonFinished(String token, String id, int finished) =>
      _setLessonFinished(
          "https://bynde-studio.site/api/teacher/setLessonFinished/$id/$finished",
          token);

  Future<void> _setLessonFinished(String url, String token) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      return;
    } else {
      throw ServerException();
    }
  }

  @override
  Future<List<SalaryModel>> getSalary(String token, String id) =>
      _getSalary("https://bynde-studio.site/api/teacher/getSalary/$id", token);

  Future<List<SalaryModel>> _getSalary(String url, String token) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      try {
        final data = json.decode(response.body);
        List<SalaryModel> models = <SalaryModel>[];
        for (var i = 0; i < 12; i++) {
          if (data.containsKey(i.toString())) {
            models.add(SalaryModel.fromJson(data[i.toString()]));
          } else {
            models.add(const SalaryModel(
                salary: 0, advance: 0, prize: 0, total: 0, isConfirm: false));
          }
        }
        return models;
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }
}
