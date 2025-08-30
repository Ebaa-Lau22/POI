import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';

class TeamsConfirmDebateDetailsPage extends StatelessWidget {
  final DebateData debate;

  const TeamsConfirmDebateDetailsPage({super.key, required this.debate});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Debate Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // التاريخ والوقت
            // التاريخ والوقت
            Row(
              children: [
                const Icon(Icons.calendar_month, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  DateFormat('dd-MM-yyyy').format(debate.startDate!.toLocal()),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(width: 20),
                const Icon(Icons.access_time, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  DateFormat(
                    'HH:mm',
                  ).format(DateFormat('HH:mm:ss').parse(debate.startTime)),
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),

            // Applicants Count
            Row(
              children: [
                const Icon(Icons.people, color: Colors.grey),
                const SizedBox(width: 6),
                Text(
                  'Applicants: ${debate.applicantsCount}',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
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
                    'https://via.placeholder.com/150',
                  ), // صورة مؤقتة
                ),
                const SizedBox(width: 12),
                Text(
                  debate.chairJudge?.name ?? '',
                  style: const TextStyle(fontSize: 16),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // الحكام المشاركين (Panelist Judges)
            if (debate.panelistJudges.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Panelist Judges:',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Column(
                    children:
                        debate.panelistJudges.map((judge) {
                          // Todo look for the judge model
                          return Row(
                            children: [
                              CircleAvatar(
                                radius: 24,
                                backgroundImage: NetworkImage(
                                  'https://via.placeholder.com/150',
                                ), // صورة مؤقتة
                              ),
                              const SizedBox(width: 12),
                              Text(
                                judge.name,
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
              children:
                  debate.teams.map((team) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Team ${team.teamNumber}',
                            style: const TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children:
                                team.debaters.map((debater) {
                                  return Text(
                                    debater.name,
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
