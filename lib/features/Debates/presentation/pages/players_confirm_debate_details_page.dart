import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';

class PlayersConfirmDebateDetailsPage extends StatelessWidget {
  final int debateId;
  final List<Datum> allDebates;

  const PlayersConfirmDebateDetailsPage({
    super.key,
    required this.debateId,
    required this.allDebates,
  });

  @override
  Widget build(BuildContext context) {
    final debate = allDebates.firstWhere((d) => d.debateId == debateId);

    return Scaffold(
      appBar: AppBar(title: const Text('Debate Details')),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
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

            const SizedBox(height: 20),

            // Chair Judge
            const Text(
              'Chair Judge',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage('assets/images/judge.png'),
              ),
              title: Text(debate.chairJudge?.name ?? 'No chair judge'),
            ),
            const SizedBox(height: 20),

            // Panelist Judges
            const Text(
              'Panelist Judges',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            debate.panelistJudges.isEmpty
                ? const Text('No panelist judges')
                : Column(
                  children:
                      debate.panelistJudges.map((judge) {
                        return ListTile(
                          leading: CircleAvatar(
                            backgroundImage: AssetImage(
                              'assets/images/judge.png',
                            ),
                          ),
                          title: Text(judge['name'] ?? 'No name'),
                        );
                      }).toList(),
                ),
            const SizedBox(height: 20),

            // Debaters
            const Text(
              'Debaters',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Column(
              children:
                  debate.debaters.map((debater) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: AssetImage(
                          'assets/images/debater.png',
                        ),
                      ),
                      title: Text(debater.name),
                    );
                  }).toList(),
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
