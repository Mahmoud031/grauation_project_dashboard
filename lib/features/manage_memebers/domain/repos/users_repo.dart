

import 'package:dartz/dartz.dart';
import 'package:grauation_project_dashboard/core/errors/failures.dart';
import 'package:grauation_project_dashboard/features/manage_memebers/domain/entities/user_entity.dart';

abstract class UsersRepo {
  Future<Either<Failure, List<UserEntity>>> getUsers();
  Future<Either<Failure, void>> deleteUser(String userId);
  Future<Either<Failure, void>> blockUser(String userId, bool blocked);
}
