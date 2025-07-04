import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grauation_project_dashboard/core/widgets/custom_app_bar.dart';
import 'package:grauation_project_dashboard/features/manage_ngo/presentation/cubit/ngos_cubit.dart';
import 'ngo_details.dart';
import 'ngo_expansion_tile.dart';

class ManageNgoViewBody extends StatelessWidget {
  const ManageNgoViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(
          title: 'Manage Ngos',
        ),
        Expanded(
          child: BlocBuilder<NgosCubit, NgosState>(
            builder: (context, state) {
              if (state is NgosLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is NgosError) {
                return Center(child: Text(state.message));
              } else if (state is NgosLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: state.ngos.length,
                    itemBuilder: (context, index) {
                      final ngo = state.ngos[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: NgoExpansionTile(
                          userName: '${index + 1}- ${ngo.name}',
                          ngoDetails: NgoDetails(
                            uId: ngo.uId,
                            ngoId: ngo.ngoId,
                            email: ngo.email,
                            address: ngo.address,
                            phone: ngo.phone,
                          ),
                          blocked: ngo.blocked,
                        ),
                      );
                    },
                  ),
                );
              }
              return const SizedBox();
            },
          ),
        ),
      ],
    );
  }
}
