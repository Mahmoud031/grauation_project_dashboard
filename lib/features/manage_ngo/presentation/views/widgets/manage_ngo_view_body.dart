import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grauation_project_dashboard/core/widgets/custom_app_bar.dart';
import 'package:grauation_project_dashboard/features/manage_ngo/presentation/cubit/ngos_cubit.dart';
import 'ngo_details.dart';
import 'ngo_expansion_tile.dart';

class ManageNgoViewBody extends StatefulWidget {
  const ManageNgoViewBody({super.key});

  @override
  State<ManageNgoViewBody> createState() => _ManageNgoViewBodyState();
}

class _ManageNgoViewBodyState extends State<ManageNgoViewBody> {
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const CustomAppBar(
          title: 'Manage Ngos',
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            decoration: InputDecoration(
              hintText: 'Search by name, email, phone, NGO ID, or address',
              prefixIcon: const Icon(Icons.search),
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(8)),
            ),
            onChanged: (value) {
              setState(() {
                _searchQuery = value.trim().toLowerCase();
              });
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<NgosCubit, NgosState>(
            builder: (context, state) {
              if (state is NgosLoading) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is NgosError) {
                return Center(child: Text(state.message));
              } else if (state is NgosLoaded) {
                final filteredNgos = _searchQuery.isEmpty
                    ? state.ngos
                    : state.ngos.where((ngo) {
                        return ngo.name.toLowerCase().contains(_searchQuery) ||
                            ngo.email.toLowerCase().contains(_searchQuery) ||
                            ngo.phone.toLowerCase().contains(_searchQuery) ||
                            ngo.ngoId.toLowerCase().contains(_searchQuery) ||
                            ngo.address.toLowerCase().contains(_searchQuery);
                      }).toList();
                return Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: filteredNgos.isEmpty
                      ? const Center(child: Text('No NGOs found.'))
                      : ListView.builder(
                          itemCount: filteredNgos.length,
                          itemBuilder: (context, index) {
                            final ngo = filteredNgos[index];
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
