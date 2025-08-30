import 'package:flutter/material.dart';

class TeamsConfirmDebateDetailsPage extends StatelessWidget {
  final Map<String, dynamic> debate;

  const TeamsConfirmDebateDetailsPage({super.key, required this.debate});

  @override
  Widget build(BuildContext context) {
    final startDate = debate['start_date'];
    final startTime = debate['start_time'];
    final applicantsCount = debate['applicants_count'];
    final chairJudge = debate['chair_judge'];
    final panelistJudges = debate['panelist_judges'] as List;
    final teams = debate['teams'] as List;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Debate Details'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // التاريخ والوقت
            Text(
              'Date: $startDate',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Time: $startTime',
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),

            // عدد المتقدمين
            Text(
              'Applicants Count: $applicantsCount',
              style: const TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 16),

            // الحكم الرئيسي (Chair Judge)
            const Text(
              'Chair Judge:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                CircleAvatar(
                  radius: 24,
                  backgroundImage: NetworkImage(
                      'https://via.placeholder.com/150'), // صورة مؤقتة
                ),
                const SizedBox(width: 12),
                Text(
                  chairJudge['name'],
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // الحكام المشاركين (Panelist Judges)
            if (panelistJudges.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Panelist Judges:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children: panelistJudges.map((judge) {
                      return Row(
                        children: [
                          CircleAvatar(
                            radius: 24,
                            backgroundImage: NetworkImage(
                                'https://via.placeholder.com/150'), // صورة مؤقتة
                          ),
                          const SizedBox(width: 12),
                          Text(
                            judge['name'],
                            style: const TextStyle(fontSize: 16),
                          ),
                        ],
                      );
                    }).toList(),
                  ),
                  const SizedBox(height: 16),
                ],
              ),

            // الفرق (Teams) مع المناظرين
            const Text(
              'Teams:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: teams.map((team) {
                final debaters = team['debaters'] as List;
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Team ${team['team_number']}',
                        style: const TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 4),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: debaters.map((debater) {
                          return Text(
                            debater['name'],
                            style: const TextStyle(fontSize: 14),
                          );
                        }).toList(),
                      ),
                    ],
                  ),
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

