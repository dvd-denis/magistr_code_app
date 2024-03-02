import 'package:dartz/dartz.dart';
import 'package:magistr_code/core/error/exception.dart';
import 'package:magistr_code/core/error/failure.dart';
import 'package:magistr_code/core/platform/network_info.dart';
import 'package:magistr_code/feature/data/datasources/user_local_datasource.dart';
import 'package:magistr_code/feature/data/datasources/user_remote_datasource.dart';
import 'package:magistr_code/feature/domain/entities/user_entity.dart';
import 'package:magistr_code/feature/domain/repositories/user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final UserLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, UserEntity>> login(String token) async {
    if (await networkInfo.isConnected) {
      if (token == "") {
        try {
          token = await localDataSource.tokenFromCache();
        } on CacheException {
          return Left(CacheFailure());
        }
      }
      try {
        final remoteUser = await remoteDataSource.login(token);
        await localDataSource.tokenToCache(token);

        return Right(remoteUser);
      } on ServerException {
        return Left(ServerFailure());
      }
    } else {
      return Left(ServerFailure());
    }
  }

  @override
  Future<Either<Failure, void>> exit() async {
    try {
      await localDataSource.tokenToCache("");

      return const Right(());
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}
