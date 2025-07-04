import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grauation_project_dashboard/features/manage_memebers/domain/entities/user_entity.dart';
import 'package:grauation_project_dashboard/features/manage_memebers/domain/repos/users_repo.dart';

part 'users_state.dart';

class UsersCubit extends Cubit<UsersState> {
  final UsersRepo usersRepo;

  UsersCubit({required this.usersRepo}) : super(UsersInitial());

  Future<void> getUsers() async {
    emit(UsersLoading());
    final result = await usersRepo.getUsers();
    result.fold(
      (failure) => emit(UsersError(failure.toString())),
      (users) => emit(UsersLoaded(users)),
    );
  }

  Future<void> deleteUser(String userId) async {
    emit(UsersLoading());
    final result = await usersRepo.deleteUser(userId);
    result.fold(
      (failure) => emit(UsersError(failure.toString())),
      (_) => getUsers(),
    );
  }

  Future<void> blockUser(String userId, bool blocked) async {
    emit(UsersLoading());
    final result = await usersRepo.blockUser(userId, blocked);
    result.fold(
      (failure) => emit(UsersError(failure.toString())),
      (_) => getUsers(),
    );
  }
} 