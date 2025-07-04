import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grauation_project_dashboard/core/widgets/custom_app_bar.dart';
import 'package:grauation_project_dashboard/features/manage_memebers/presentation/cubit/users_cubit.dart';
import 'member_details.dart';
import 'member_expansion_tile.dart';

class ManageMembersViewBody extends StatelessWidget {
  const ManageMembersViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(
          title: 'Manage Members',
        ),
        Expanded(
          child: BlocBuilder<UsersCubit, UsersState>(
            builder: (context, state) {
              if (state is UsersLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is UsersError) {
                return Center(child: Text(state.message));
              } else if (state is UsersLoaded) {
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: ListView.builder(
                    itemCount: state.users.length,
                    itemBuilder: (context, index) {
                      final user = state.users[index];
                      return Padding(
                        padding: const EdgeInsets.only(bottom: 8.0),
                        child: MemberExpansionTile(
                          userName: '${index + 1}- ${user.name}',
                          memberDetails: MemberDetails(
                            memberId: user.documentId ?? '',
                            age: user.age.toString(),
                            contactNo: user.phone,
                            email: user.email,
                            address: user.address,
                            type: user.type,
                            nationalId: user.nationalId,
                          ),
                          blocked: user.blocked,
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
