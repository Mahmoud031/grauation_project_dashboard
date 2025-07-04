import 'package:dartz/dartz.dart';
import 'package:grauation_project_dashboard/core/errors/failures.dart';
import 'package:grauation_project_dashboard/core/services/database_service.dart';
import 'package:grauation_project_dashboard/core/utils/backend_endpoint.dart';
import 'package:grauation_project_dashboard/features/manage_memebers/data/models/user_model.dart';
import 'package:grauation_project_dashboard/features/manage_memebers/domain/entities/user_entity.dart';
import 'package:grauation_project_dashboard/features/manage_memebers/domain/repos/users_repo.dart';

class UsersRepoImpl implements UsersRepo {
  final DatabaseService databaseService;
  UsersRepoImpl({required this.databaseService});

  @override
  Future<Either<Failure, List<UserEntity>>> getUsers() async {
    try {
      final result =
          await databaseService.getData(path: BackendEndpoint.getUserData);
      if (result == null) {
        return const Right([]);
      }

      final List<UserEntity> users = (result as List).map((userData) {
        // userData['documentId'] is set in FirestoreService.getData
        return UserModel.fromJson(userData);
      }).toList();

      return Right(users);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteUser(String userId) async {
    try {
      await databaseService.deleteData(path: BackendEndpoint.getUserData, documentId: userId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> blockUser(String userId, bool blocked) async {
    try {
      await databaseService.updateData(
        path: BackendEndpoint.getUserData,
        data: {'blocked': blocked},
        documentId: userId,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
}
