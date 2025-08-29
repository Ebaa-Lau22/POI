import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poi/core/app_cubit/app_cubit.dart';
import 'package:poi/core/app_cubit/app_states.dart';
import 'package:poi/core/theme/app_colors.dart';
import 'package:poi/features/Debates/presentation/bloc/debates_cubit.dart';
import 'package:poi/features/Debates/presentation/bloc/debates_states.dart';

class RankingPage extends StatefulWidget {
  const RankingPage({super.key});

  @override
  State<RankingPage> createState() => _RankingPageState();
}

class _RankingPageState extends State<RankingPage> {
  final List<String> teams = ["Team A", "Team B", "Team C", "Team D"];

  String? winner;
  Map<int, String?> ranks = {2: null, 3: null, 4: null};

  List<String> getAvailableTeams([String? current]) {
    final selected = {winner, ...ranks.values}..remove(current);
    return teams.where((team) => !selected.contains(team)).toList();
  }

  InputDecoration fieldDecoration(String hint) {
    return InputDecoration(
      hintText: hint,
      border: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: AppColors.darkBlue, width: 1.5),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(
          color: AppColors.darkBlue.withOpacity(0.5),
          width: 1.5,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: const BorderRadius.all(Radius.circular(12)),
        borderSide: BorderSide(color: AppColors.darkBlue, width: 2),
      ),
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final appCubit = context.read<AppCubit>();
        final color = ThemedColors(appCubit.isLightTheme);
        final textStyle = Theme.of(context).textTheme;
        return BlocConsumer<DebatesCubit, DebatesStates>(
          listener: (context, state) {},
          builder: (context, state) {
            return Scaffold(
              appBar: AppBar(title: const Text("Choose Winner & Ranking")),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ====== Winner ======
                    const Text(
                      "Winner (1st place)",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButtonFormField<String>(
                        value: winner,
                        isExpanded: true, 
                        decoration: fieldDecoration("Select the winning team"),
                        items:
                            getAvailableTeams(winner)
                                .map(
                                  (team) => DropdownMenuItem(
                                    value: team,
                                    child: Text(team),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            winner = value;
                            ranks.updateAll(
                              (key, val) => val == winner ? null : val,
                            );
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ====== Other ranks ======
                    for (int pos = 2; pos <= 4; pos++) ...[
                      Text(
                        pos == 2
                            ? "Second place"
                            : pos == 3
                            ? "Third place"
                            : "Fourth place",
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 6),
                      SizedBox(
                        width: double.infinity,
                        child: DropdownButtonFormField<String>(
                          value: ranks[pos],
                          isExpanded: true,
                          decoration: fieldDecoration(
                            "Select team for $pos${pos == 2
                                ? "nd"
                                : pos == 3
                                ? "rd"
                                : "th"} place",
                          ),
                          items:
                              getAvailableTeams(ranks[pos])
                                  .map(
                                    (team) => DropdownMenuItem(
                                      value: team,
                                      child: Text(team),
                                    ),
                                  )
                                  .toList(),
                          onChanged: (value) {
                            setState(() {
                              ranks[pos] = value;
                            });
                          },
                        ),
                      ),
                      const SizedBox(height: 20),
                    ],

                    const SizedBox(height: 30),

                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (winner != null &&
                              ranks.values.every((v) => v != null)) {
                            print("Winner: $winner");
                            print("Ranking: $ranks");
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Ranking saved successfully"),
                              ),
                            );
                          } else {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please complete all ranks"),
                              ),
                            );
                          }
                        },
                        child: const Text("Save"),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
    );
  }
}
