import 'package:flutter/material.dart';
import 'package:grauation_project_dashboard/core/utils/app_text_styles.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:grauation_project_dashboard/features/manage_ngo/presentation/cubit/ngos_cubit.dart';

import '../ngo_medicine_detalis_view.dart';

class NgoMedicineDetailsSection extends StatelessWidget {
  final String ngoId;
  final bool blocked;
  const NgoMedicineDetailsSection(
      {super.key, required this.ngoId, required this.blocked});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                decoration: ShapeDecoration(
                  color: const Color(0xFFC2E1E3),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                  shadows: [
                    BoxShadow(
                      color: Color(0x3F000000),
                      blurRadius: 4,
                      offset: Offset(0, 4),
                      spreadRadius: 0,
                    )
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        NgoMedicineDetailsView.routeName,
                        arguments: ngoId,
                      );
                    },
                    child: Row(
                      children: [
                        Text('Medicine Details',
                            style: TextStyles.textstyle18.copyWith(
                              color: const Color(0xFF071A26),
                              fontWeight: FontWeight.bold,
                            )),
                        SizedBox(width: 8),
                        Icon(
                          Icons.medical_services,
                          color: const Color(0xFF071A26),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.delete, color: Colors.red),
                    onPressed: () async {
                      final confirm = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('Delete NGO'),
                          content: const Text(
                              'Are you sure you want to delete this NGO?'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.pop(context, false),
                              child: const Text('Cancel'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.pop(context, true),
                              child: const Text('Delete'),
                            ),
                          ],
                        ),
                      );
                      if (confirm == true) {
                        final cubit = BlocProvider.of<NgosCubit>(context);
                        cubit.deleteNgo(ngoId);
                      }
                    },
                  ),
                  blocked
                      ? IconButton(
                          icon: const Icon(Icons.check_circle,
                              color: Colors.green),
                          tooltip: 'Unblock',
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Unblock NGO'),
                                content: const Text(
                                    'Are you sure you want to unblock this NGO?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text('Unblock'),
                                  ),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              final cubit = BlocProvider.of<NgosCubit>(context);
                              cubit.blockNgo(ngoId, false);
                            }
                          },
                        )
                      : IconButton(
                          icon: const Icon(Icons.block, color: Colors.orange),
                          tooltip: 'Block',
                          onPressed: () async {
                            final confirm = await showDialog<bool>(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: const Text('Block NGO'),
                                content: const Text(
                                    'Are you sure you want to block this NGO?'),
                                actions: [
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, false),
                                    child: const Text('Cancel'),
                                  ),
                                  TextButton(
                                    onPressed: () =>
                                        Navigator.pop(context, true),
                                    child: const Text('Block'),
                                  ),
                                ],
                              ),
                            );
                            if (confirm == true) {
                              final cubit = BlocProvider.of<NgosCubit>(context);
                              cubit.blockNgo(ngoId, true);
                            }
                          },
                        ),
                ],
              ),
            ],
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }
}
