import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grauation_project_dashboard/features/manage_ngo/domain/entities/ngo_entity.dart';
import 'package:grauation_project_dashboard/features/manage_ngo/domain/repos/ngos_repo.dart';

part 'ngos_state.dart';

class NgosCubit extends Cubit<NgosState> {
  final NgosRepo ngosRepo;

  NgosCubit({required this.ngosRepo}) : super(NgosInitial());

  Future<void> getNgos() async {
    emit(NgosLoading());
    final result = await ngosRepo.getNgos();
    result.fold(
      (failure) => emit(NgosError(failure.toString())),
      (ngos) => emit(NgosLoaded(ngos)),
    );
  }

  Future<void> deleteNgo(String ngoId) async {
    emit(NgosLoading());
    final result = await ngosRepo.deleteNgo(ngoId);
    result.fold(
      (failure) => emit(NgosError(failure.toString())),
      (_) => getNgos(),
    );
  }

  Future<void> blockNgo(String ngoId, bool blocked) async {
    emit(NgosLoading());
    final result = await ngosRepo.blockNgo(ngoId, blocked);
    result.fold(
      (failure) => emit(NgosError(failure.toString())),
      (_) => getNgos(),
    );
  }
} 