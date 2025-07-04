import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';

class ReportsViewBody extends StatelessWidget {
  const ReportsViewBody({super.key});

  Future<Map<String, dynamic>> _fetchReportData() async {
    final usersSnap =
        await FirebaseFirestore.instance.collection('users').get();
    final ngosSnap = await FirebaseFirestore.instance.collection('ngos').get();
    final medicinesSnap =
        await FirebaseFirestore.instance.collection('medicine').get();

    final users = usersSnap.docs;
    final ngos = ngosSnap.docs;
    final medicines = medicinesSnap.docs;

    // Medicine status distribution
    final Map<String, int> statusCount = {};
    for (final doc in medicines) {
      final data = doc.data() as Map<String, dynamic>;
      final status = data['status']?.toString() ?? 'Unknown';
      statusCount[status] = (statusCount[status] ?? 0) + 1;
    }

    // Medicines per NGO (bar chart)
    final Map<String, int> medicinesPerNgo = {};
    for (final doc in medicines) {
      final data = doc.data() as Map<String, dynamic>;
      final ngo = data['ngoName']?.toString() ?? 'Unknown';
      medicinesPerNgo[ngo] = (medicinesPerNgo[ngo] ?? 0) + 1;
    }

    // Recent medicines (last 5 by receivedDate or created time)
    final recentMedicines =
        List<Map<String, dynamic>>.from(medicines.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return data;
    }));
    recentMedicines.sort((a, b) {
      final aDate = DateTime.tryParse(a['receivedDate']?.toString() ?? '') ??
          DateTime(1970);
      final bDate = DateTime.tryParse(b['receivedDate']?.toString() ?? '') ??
          DateTime(1970);
      return bDate.compareTo(aDate);
    });

    // Recent users (last 5 by name as fallback)
    final recentUsers = List<Map<String, dynamic>>.from(users.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return data;
    }));
    recentUsers.sort((a, b) {
      // If you have a timestamp field, use it here. Otherwise, fallback to name.
      return b['name'].toString().compareTo(a['name'].toString());
    });

    // Recent NGOs (last 5 by name as fallback)
    final recentNgos = List<Map<String, dynamic>>.from(ngos.map((doc) {
      final data = doc.data() as Map<String, dynamic>;
      data['id'] = doc.id;
      return data;
    }));
    recentNgos.sort((a, b) {
      // If you have a timestamp field, use it here. Otherwise, fallback to name.
      return b['name'].toString().compareTo(a['name'].toString());
    });

    return {
      'usersCount': users.length,
      'ngosCount': ngos.length,
      'medicinesCount': medicines.length,
      'statusCount': statusCount,
      'medicinesPerNgo': medicinesPerNgo,
      'recentMedicines': recentMedicines.take(5).toList(),
      'recentUsers': recentUsers.take(5).toList(),
      'recentNgos': recentNgos.take(5).toList(),
    };
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Map<String, dynamic>>(
      future: _fetchReportData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        final data = snapshot.data!;
        return SingleChildScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SummaryCards(
                usersCount: data['usersCount'],
                ngosCount: data['ngosCount'],
                medicinesCount: data['medicinesCount'],
              ),
              const SizedBox(height: 32),
              _SectionTitle('Medicine Status Distribution'),
              _StatusPieChart(
                  statusCount: data['statusCount'] as Map<String, int>),
              const SizedBox(height: 32),
              _SectionTitle('Medicines per NGO'),
              _MedicinesBarChart(
                  medicinesPerNgo: data['medicinesPerNgo'] as Map<String, int>),
              const SizedBox(height: 32),
              _SectionTitle('Recent Medicines'),
              _RecentMedicinesList(
                  medicines:
                      data['recentMedicines'] as List<Map<String, dynamic>>),
              const SizedBox(height: 32),
              _SectionTitle('Recent Donors'),
              _RecentUsersList(
                  users: data['recentUsers'] as List<Map<String, dynamic>>),
              const SizedBox(height: 32),
              _SectionTitle('Recent NGOs'),
              _RecentNgosList(
                  ngos: data['recentNgos'] as List<Map<String, dynamic>>),
            ],
          ),
        );
      },
    );
  }
}

class _SectionTitle extends StatelessWidget {
  final String title;
  const _SectionTitle(this.title);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.blueGrey[800],
            ),
      ),
    );
  }
}

class _SummaryCards extends StatelessWidget {
  final int usersCount;
  final int ngosCount;
  final int medicinesCount;
  const _SummaryCards(
      {required this.usersCount,
      required this.ngosCount,
      required this.medicinesCount});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _StatCard(
              label: 'Members',
              count: usersCount,
              color: Colors.blue,
              icon: Icons.people),
          const SizedBox(width: 16),
          _StatCard(
              label: 'NGOs',
              count: ngosCount,
              color: Colors.green,
              icon: Icons.volunteer_activism),
          const SizedBox(width: 16),
          _StatCard(
              label: 'Medicines',
              count: medicinesCount,
              color: Colors.purple,
              icon: Icons.medication),
        ],
      ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final String label;
  final int count;
  final Color color;
  final IconData icon;
  const _StatCard(
      {required this.label,
      required this.count,
      required this.color,
      required this.icon});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      color: color.withOpacity(0.12),
      margin: const EdgeInsets.symmetric(vertical: 6), // Add vertical margin
      child: Container(
        width: 110,
        height: 120, // Reduce height
        padding: const EdgeInsets.symmetric(
            vertical: 8, horizontal: 8), // Reduce padding
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: color, size: 26), // Reduce icon size
            const SizedBox(height: 8),
            Text('$count',
                style: TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold, color: color)),
            const SizedBox(height: 2),
            Text(label,
                style: TextStyle(
                    fontSize: 13, color: color, fontWeight: FontWeight.w600)),
          ],
        ),
      ),
    );
  }
}

class _StatusPieChart extends StatelessWidget {
  final Map<String, int> statusCount;
  const _StatusPieChart({required this.statusCount});

  @override
  Widget build(BuildContext context) {
    if (statusCount.isEmpty) {
      return const Text('No data');
    }
    final total = statusCount.values.fold<int>(0, (a, b) => a + b);
    final colors = [
      Colors.blue,
      Colors.green,
      Colors.orange,
      Colors.red,
      Colors.purple,
      Colors.grey
    ];
    final keys = statusCount.keys.toList();
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          children: [
            SizedBox(
              width: 140,
              height: 140,
              child: PieChart(
                PieChartData(
                  sections: [
                    for (int i = 0; i < keys.length; i++)
                      PieChartSectionData(
                        color: colors[i % colors.length],
                        value: statusCount[keys[i]]!.toDouble(),
                        title:
                            '${((statusCount[keys[i]]! / total) * 100).toStringAsFixed(1)}%',
                        radius: 55,
                        titleStyle: const TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.white,
                            fontSize: 16),
                      ),
                  ],
                  sectionsSpace: 2,
                  centerSpaceRadius: 30,
                ),
              ),
            ),
            const SizedBox(width: 24),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  for (int i = 0; i < keys.length; i++)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4),
                      child: Row(
                        children: [
                          Container(
                              width: 16,
                              height: 16,
                              color: colors[i % colors.length],
                              margin: const EdgeInsets.only(right: 8)),
                          Text('${keys[i]}',
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600)),
                          const SizedBox(width: 8),
                          Text('(${statusCount[keys[i]]})'),
                        ],
                      ),
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _MedicinesBarChart extends StatelessWidget {
  final Map<String, int> medicinesPerNgo;
  const _MedicinesBarChart({required this.medicinesPerNgo});

  @override
  Widget build(BuildContext context) {
    if (medicinesPerNgo.isEmpty) {
      return const Text('No data');
    }
    final keys = medicinesPerNgo.keys.toList();
    final values = medicinesPerNgo.values.toList();
    final maxValue =
        values.isNotEmpty ? values.reduce((a, b) => a > b ? a : b) : 1;
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SizedBox(
          height: 220,
          child: BarChart(
            BarChartData(
              alignment: BarChartAlignment.spaceAround,
              maxY: (maxValue + 2).toDouble(),
              barTouchData: BarTouchData(enabled: true),
              titlesData: FlTitlesData(
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(showTitles: true, reservedSize: 28),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    getTitlesWidget: (double value, TitleMeta meta) {
                      final idx = value.toInt();
                      if (idx < 0 || idx >= keys.length)
                        return const SizedBox();
                      return Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Text(
                          keys[idx].length > 8
                              ? keys[idx].substring(0, 8) + '…'
                              : keys[idx],
                          style: const TextStyle(
                              fontSize: 12, fontWeight: FontWeight.w600),
                        ),
                      );
                    },
                    interval: 1,
                  ),
                ),
                rightTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles:
                    AxisTitles(sideTitles: SideTitles(showTitles: false)),
              ),
              borderData: FlBorderData(show: false),
              gridData: FlGridData(show: false),
              barGroups: [
                for (int i = 0; i < keys.length; i++)
                  BarChartGroupData(
                    x: i,
                    barRods: [
                      BarChartRodData(
                        toY: values[i].toDouble(),
                        color: Colors.blueAccent,
                        width: 22,
                        borderRadius: BorderRadius.circular(8),
                        backDrawRodData: BackgroundBarChartRodData(
                          show: true,
                          toY: (maxValue + 2).toDouble(),
                          color: Colors.blueAccent.withOpacity(0.08),
                        ),
                      ),
                    ],
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _RecentMedicinesList extends StatelessWidget {
  final List<Map<String, dynamic>> medicines;
  const _RecentMedicinesList({required this.medicines});

  @override
  Widget build(BuildContext context) {
    if (medicines.isEmpty) {
      return const Text('No recent medicines.');
    }
    return Column(
      children: medicines.map((data) {
        return Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: data['imageUrl'] != null &&
                    data['imageUrl'].toString().isNotEmpty
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(data['imageUrl'],
                        width: 44, height: 44, fit: BoxFit.cover),
                  )
                : Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey[50],
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Icon(Icons.medication,
                        color: Colors.blueGrey, size: 28),
                  ),
            title: Text(data['medicineName']?.toString() ?? 'Unknown',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Status: ${data['status'] ?? 'N/A'}'),
                Text('Received: ${data['receivedDate'] ?? 'N/A'}'),
                if (data['ngoName'] != null) Text('NGO: ${data['ngoName']}'),
              ],
            ),
            trailing: const Icon(Icons.arrow_forward_ios,
                size: 18, color: Colors.blueGrey),
          ),
        );
      }).toList(),
    );
  }
}

class _RecentUsersList extends StatelessWidget {
  final List<Map<String, dynamic>> users;
  const _RecentUsersList({required this.users});

  @override
  Widget build(BuildContext context) {
    if (users.isEmpty) {
      return const Text('No recent donors.');
    }
    return Column(
      children: users.map((data) {
        return Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: const Icon(Icons.person, color: Colors.blue, size: 32),
            title: Text(data['name']?.toString() ?? 'Unknown',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email: ${data['email'] ?? 'N/A'}'),
                if (data['type'] != null) Text('Type: ${data['type']}'),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}

class _RecentNgosList extends StatelessWidget {
  final List<Map<String, dynamic>> ngos;
  const _RecentNgosList({required this.ngos});

  @override
  Widget build(BuildContext context) {
    if (ngos.isEmpty) {
      return const Text('No recent NGOs.');
    }
    return Column(
      children: ngos.map((data) {
        return Card(
          elevation: 3,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
          margin: const EdgeInsets.symmetric(vertical: 8),
          child: ListTile(
            leading: const Icon(Icons.apartment, color: Colors.green, size: 32),
            title: Text(data['name']?.toString() ?? 'Unknown',
                style: const TextStyle(fontWeight: FontWeight.bold)),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Email: ${data['email'] ?? 'N/A'}'),
                if (data['ngoId'] != null) Text('NGO ID: ${data['ngoId']}'),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
