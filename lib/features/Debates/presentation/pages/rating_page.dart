import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poi/core/app_cubit/app_cubit.dart';
import 'package:poi/core/app_cubit/app_states.dart';
import 'package:poi/core/theme/app_colors.dart';
import 'package:poi/features/Debates/presentation/bloc/debates_cubit.dart';
import 'package:poi/features/Debates/presentation/bloc/debates_states.dart';

class JudgeRatingPage extends StatefulWidget {
  const JudgeRatingPage({super.key});

  @override
  State<JudgeRatingPage> createState() => _JudgeRatingPageState();
}

class _JudgeRatingPageState extends State<JudgeRatingPage> {
  final List<String> judges = ["Judge A", "Judge B", "Judge C"];
  String? selectedJudge;
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
              appBar: AppBar(title: const Text("Judge Evaluation")),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ====== Select Judge ======
                    const Text(
                      "Select Judge",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButtonFormField<String>(
                        value: selectedJudge,
                        isExpanded: true,
                        decoration: fieldDecoration("Choose a judge"),
                        items:
                            judges
                                .map(
                                  (j) => DropdownMenuItem(
                                    value: j,
                                    child: Text(j),
                                  ),
                                )
                                .toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedJudge = value;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ====== Rating ======
                    const Text(
                      "Rating",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
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
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
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
                          if (selectedJudge == null ||
                              rating == null ||
                              reasonController.text.isEmpty) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Please complete all fields"),
                              ),
                            );
                          } else {
                            // هنا يمكن ربط API لإرسال التقييم
                            print("Judge: $selectedJudge");
                            print("Rating: $rating");
                            print("Reason: ${reasonController.text}");

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Evaluation sent successfully"),
                              ),
                            );

                            reasonController.clear();
                            setState(() {
                              selectedJudge = null;
                              rating = null;
                            });
                          }
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
      },
    );
  }
}
