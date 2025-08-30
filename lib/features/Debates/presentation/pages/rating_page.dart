import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:poi/core/app_cubit/app_cubit.dart';
import 'package:poi/core/app_cubit/app_states.dart';
import 'package:poi/core/theme/app_colors.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';
import 'package:poi/features/Debates/data/models/dto/rate_judge_dto.dart';
import 'package:poi/features/Debates/presentation/bloc/debates_cubit.dart';
import 'package:poi/features/Debates/presentation/bloc/debates_states.dart';

class JudgeRatingPage extends StatefulWidget {
  final DebateData debate;
  const JudgeRatingPage({super.key, required this.debate});

  @override
  State<JudgeRatingPage> createState() => _JudgeRatingPageState();
}

class _JudgeRatingPageState extends State<JudgeRatingPage> {
  int? selectedJudgeId;
  String? selectedJudgeName;
  int? rating;
  final TextEditingController reasonController = TextEditingController();

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
    // دمج كل القضاة في قائمة واحدة
    final allJudges = <Map<String, dynamic>>[];
    if (widget.debate.chairJudge != null) {
      allJudges.add({
        "id": widget.debate.chairJudge!.chairJudgeId,
        "name": widget.debate.chairJudge!.name,
      });
    }
    allJudges.addAll(
      widget.debate.panelistJudges.map((j) => {"id": j.id, "name": j.name}),
    );

    return BlocConsumer<DebatesCubit, DebatesStates>(
      listener: (context, state) {
        if (state is AddFeedbackLoading || state is RateJudgeLoading) {
          context.loaderOverlay.show();
        } else {
          context.loaderOverlay.hide();
        }

        if (state is RateJudgeSuccess) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text("Evaluation sent successfully")),
          );
        }

        if (state is RateJudgeError) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(state.message)));
        }
      },
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(title: const Text("Judge Evaluation")),
          body: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // ====== Select Judge ======
                const Text(
                  "Select Judge",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                SizedBox(
                  width: double.infinity,
                  child: DropdownButtonFormField<String>(
                    value: selectedJudgeName,
                    isExpanded: true,
                    decoration: fieldDecoration("Choose a judge"),
                    items:
                        allJudges.map((j) {
                          return DropdownMenuItem<String>(
                            value: j["name"],
                            child: Text(j["name"]),
                          );
                        }).toList(),
                    onChanged: (value) {
                      setState(() {
                        selectedJudgeName = value;
                        final selected = allJudges.firstWhere(
                          (j) => j["name"] == value,
                          orElse: () => {"id": null},
                        );
                        selectedJudgeId = selected["id"] as int?;
                      });
                    },
                  ),
                ),

                const SizedBox(height: 20),
                // ====== Rating ======
                const Text(
                  "Rating",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                Row(
                  children: List.generate(5, (index) {
                    int star = index + 1;
                    return IconButton(
                      icon: Icon(
                        rating != null && rating! >= star
                            ? Icons.star
                            : Icons.star_border,
                        color: Colors.amber,
                      ),
                      onPressed: () {
                        setState(() {
                          rating = star;
                        });
                      },
                    );
                  }),
                ),

                const SizedBox(height: 20),
                // ====== Reason ======
                const Text(
                  "Reason for Rating",
                  style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 6),
                TextFormField(
                  controller: reasonController,
                  maxLines: null,
                  minLines: 4,
                  keyboardType: TextInputType.multiline,
                  decoration: fieldDecoration("Write your reason here..."),
                ),
                const SizedBox(height: 30),
                Center(
                  child: ElevatedButton(
                    onPressed: () {
                      if (selectedJudgeId == null ||
                          rating == null ||
                          reasonController.text.isEmpty) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text("Please complete all fields"),
                          ),
                        );
                        return;
                      }

                      final dto = RateJudgeDto(
                        judgeId: selectedJudgeId!,
                        debateId: widget.debate.debateId,
                        rate: rating!,
                        opinion: reasonController.text,
                      );

                      context.read<DebatesCubit>().addRating(
                        dto: dto,
                        context: context,
                      );

                      reasonController.clear();
                      setState(() {
                        selectedJudgeName = null;
                        selectedJudgeId = null;
                        rating = null;
                      });
                    },
                    child: const Text("Send Evaluation"),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
