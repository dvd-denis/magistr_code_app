import 'dart:convert';

import 'package:http/http.dart' as http;

import 'package:magistr_code/core/error/exception.dart';
import 'package:magistr_code/feature/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  /// Calls the GET https://bynde-studio.site/api/user endpoint.
  ///
  /// Throws a [ServerException] for all error codes.
  Future<UserModel> login(String token);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final http.Client client;

  UserRemoteDataSourceImpl({required this.client});

  @override
  Future<UserModel> login(String token) =>
      _login("https://bynde-studio.site/api/user", token);

  Future<UserModel> _login(String url, String token) async {
    final response = await client.get(
      Uri.parse(url),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );

    if (response.statusCode == 200) {
      try {
        final user = json.decode(response.body);
        return UserModel.fromJson(user, token);
      } catch (e) {
        throw ServerException();
      }
    } else {
      throw ServerException();
    }
  }
}
