import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grauation_project_dashboard/core/services/firestore_service.dart';
import 'package:grauation_project_dashboard/core/widgets/custom_side_bar.dart';
import 'package:grauation_project_dashboard/features/manage_memebers/data/repos/users_repo_impl.dart';
import 'package:grauation_project_dashboard/features/manage_memebers/presentation/cubit/users_cubit.dart';

import 'widgets/manage_members_view_body.dart';

class ManageMembersView extends StatelessWidget {
  const ManageMembersView({super.key});
  static const String routeName = 'manage_members_view';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final FirestoreService firestoreService = FirestoreService();
        final UsersRepoImpl usersRepo = UsersRepoImpl(databaseService: firestoreService);
        return UsersCubit(usersRepo: usersRepo)..getUsers();
      },
      child: SafeArea(
        child: Scaffold(
          drawer: CustomSideBar(),
          body: ManageMembersViewBody(),
        ),
      ),
    );
  }
}
