import 'package:magistr_code/core/error/exception.dart';
import 'package:shared_preferences/shared_preferences.dart';

typedef Token = String;

abstract class UserLocalDataSource {
  /// Gets the cached [Token] which was gotten the last time
  ///
  /// Throws [CacheException] if no cached data.
  Future<Token> tokenFromCache();

  /// add to cache [Token] which was gotten the last time
  ///
  /// Throws [CacheException] if get error with caching data.
  Future<void> tokenToCache(Token token);
}

const cachedToken = "CACHED_TOKEN";

class UserLocalDataSourceImpl implements UserLocalDataSource {
  final SharedPreferences sharedPreferences;

  UserLocalDataSourceImpl({required this.sharedPreferences});

  @override
  Future<Token> tokenFromCache() {
    final token = sharedPreferences.getString(cachedToken);
    if (token != null || token != "") {
      return Future.value(token);
    } else {
      throw CacheException();
    }
  }

  @override
  Future<void> tokenToCache(Token token) async {
    sharedPreferences.setString(cachedToken, token);

    return Future.value();
  }
}
