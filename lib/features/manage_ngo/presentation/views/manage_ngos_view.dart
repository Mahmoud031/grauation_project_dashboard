import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grauation_project_dashboard/core/services/firestore_service.dart';
import 'package:grauation_project_dashboard/core/widgets/custom_side_bar.dart';
import 'package:grauation_project_dashboard/features/manage_ngo/data/repos/ngos_repo_impl.dart';
import 'package:grauation_project_dashboard/features/manage_ngo/presentation/cubit/ngos_cubit.dart';

import 'widgets/manage_ngo_view_body.dart';

class ManageNgosView extends StatelessWidget {
  const ManageNgosView({super.key});
  static const String routeName = 'manage_ngos_view';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final FirestoreService firestoreService = FirestoreService();
        final NgosRepoImpl ngosRepo =
            NgosRepoImpl(databaseService: firestoreService);
        return NgosCubit(ngosRepo: ngosRepo)..getNgos();
      },
      child: Scaffold(
        drawer: CustomSideBar(),
        body: ManageNgoViewBody(),
      ),
    );
  }
}
