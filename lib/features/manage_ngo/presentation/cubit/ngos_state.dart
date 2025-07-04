part of 'ngos_cubit.dart';

abstract class NgosState {}

class NgosInitial extends NgosState {}

class NgosLoading extends NgosState {}

class NgosLoaded extends NgosState {
  final List<NgoEntity> ngos;
  NgosLoaded(this.ngos);
}

class NgosError extends NgosState {
  final String message;
  NgosError(this.message);
} 