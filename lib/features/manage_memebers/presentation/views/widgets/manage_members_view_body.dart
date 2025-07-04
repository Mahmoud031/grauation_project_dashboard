import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grauation_project_dashboard/core/widgets/custom_app_bar.dart';
import 'package:grauation_project_dashboard/features/manage_memebers/presentation/cubit/users_cubit.dart';
import 'member_details.dart';
import 'member_expansion_tile.dart';

class ManageMembersViewBody extends StatefulWidget {
  const ManageMembersViewBody({super.key});

  @override
  State<ManageMembersViewBody> createState() => _ManageMembersViewBodyState();
}

class _ManageMembersViewBodyState extends State<ManageMembersViewBody> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(
          title: 'Manage Members',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search by name, email, phone, or national ID',
              prefixIcon: const Icon(Icons.search),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value.trim().toLowerCase();
              });
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<UsersCubit, UsersState>(
            builder: (context, state) {
              if (state is UsersLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is UsersError) {
                return Center(child: Text(state.message));
              } else if (state is UsersLoaded) {
                final filteredUsers = _searchQuery.isEmpty
                    ? state.users
                    : state.users.where((user) {
                        return user.name.toLowerCase().contains(_searchQuery) ||
                            user.email.toLowerCase().contains(_searchQuery) ||
                            user.phone.toLowerCase().contains(_searchQuery) ||
                            user.nationalId
                                .toLowerCase()
                                .contains(_searchQuery);
                      }).toList();
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: filteredUsers.isEmpty
                      ? const Center(child: Text('No members found.'))
                      : ListView.builder(
                          itemCount: filteredUsers.length,
                          itemBuilder: (context, index) {
                            final user = filteredUsers[index];
                            return Padding(
                              padding: const EdgeInsets.only(bottom: 8.0),
                              child: MemberExpansionTile(
                                userName: ' ${index + 1}- ${user.name}',
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
