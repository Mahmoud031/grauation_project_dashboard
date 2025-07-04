import 'package:dartz/dartz.dart';
import 'package:grauation_project_dashboard/core/errors/failures.dart';
import 'package:grauation_project_dashboard/features/manage_ngo/domain/entities/ngo_entity.dart';

abstract class NgosRepo {
  Future<Either<Failure, List<NgoEntity>>> getNgos();
  Future<Either<Failure, void>> deleteNgo(String ngoId);
  Future<Either<Failure, void>> blockNgo(String ngoId, bool blocked);
} 