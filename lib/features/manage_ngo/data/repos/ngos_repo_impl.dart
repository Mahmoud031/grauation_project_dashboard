import 'package:dartz/dartz.dart';
import 'package:grauation_project_dashboard/core/errors/failures.dart';
import 'package:grauation_project_dashboard/core/services/database_service.dart';
import 'package:grauation_project_dashboard/core/utils/backend_endpoint.dart';
import 'package:grauation_project_dashboard/features/manage_ngo/data/models/ngo_model.dart';
import 'package:grauation_project_dashboard/features/manage_ngo/domain/entities/ngo_entity.dart';
import 'package:grauation_project_dashboard/features/manage_ngo/domain/repos/ngos_repo.dart';

class NgosRepoImpl implements NgosRepo {
  final DatabaseService databaseService;
  NgosRepoImpl({required this.databaseService});

  @override
  Future<Either<Failure, List<NgoEntity>>> getNgos() async {
    try {
      final result = await databaseService.getData(path: BackendEndpoint.getNgoData);
      if (result == null) {
        return const Right([]);
      }
      
      final List<NgoEntity> ngos = (result as List).map((ngoData) {
        return NgoModel.fromJson(ngoData);
      }).toList();
      
      return Right(ngos);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> deleteNgo(String ngoId) async {
    try {
      await databaseService.deleteData(path: BackendEndpoint.getNgoData, documentId: ngoId);
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  @override
  Future<Either<Failure, void>> blockNgo(String ngoId, bool blocked) async {
    try {
      await databaseService.updateData(
        path: BackendEndpoint.getNgoData,
        data: {'blocked': blocked},
        documentId: ngoId,
      );
      return const Right(null);
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }
} 