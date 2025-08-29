import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poi/core/app_cubit/app_cubit.dart';
import 'package:poi/core/app_cubit/app_states.dart';
import 'package:poi/core/theme/app_colors.dart';
import 'package:poi/features/Debates/presentation/bloc/debates_cubit.dart';
import 'package:poi/features/Debates/presentation/bloc/debates_states.dart';

class DebateFeedbackListPage extends StatelessWidget {
  const DebateFeedbackListPage({super.key});

  final List<Map<String, dynamic>> feedbackList = const [
    {
      "debateTitle": "Debate on Climate Change",
      "judge": "Judge 1",
      "feedback": "Great arguments, well structured and clear.",
    },
    {
      "debateTitle": "Debate on Artificial Intelligence",
      "judge": "Judge 2",
      "feedback":
          "Needs improvement on rebuttals and examples.Needs improvement on rebuttals and examplesNeeds improvement on rebuttals and examplesNeeds improvement on rebuttals and examplesNeeds improvement on rebuttals and examplesNeeds improvement on rebuttals and examples",
    },
    {
      "debateTitle": "Debate on Education Policy",
      "judge": "Judge 1",
      "feedback": "Excellent timing and use of references.",
    },
    {
      "debateTitle": "Debate on Space Exploration",
      "judge": "Judge 3",
      "feedback": "Good points but lacks clarity in conclusion.",
    },
  ];

  void showFeedbackBottomSheet(
    BuildContext context,
    Map<String, dynamic> feedback,
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            top: 16,
            left: 16,
            right: 16,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 50,
                  height: 5,
                  margin: const EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey[400],
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
              Text(
                feedback["debateTitle"],
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Judge: ${feedback["judge"]}",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 12),
              const Text(
                "Feedback:",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 6),
              Text(feedback["feedback"], style: const TextStyle(fontSize: 14)),
              const SizedBox(height: 20),
            ],
          ),
        );
      },
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
              appBar: AppBar(title: const Text("Debate Feedbacks")),
              body: ListView.separated(
                padding: const EdgeInsets.all(16),
                itemCount: feedbackList.length,
                separatorBuilder: (_, __) => const SizedBox(height: 12),
                itemBuilder: (context, index) {
                  final feedback = feedbackList[index];
                  return GestureDetector(
                    onTap: () => showFeedbackBottomSheet(context, feedback),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    feedback["debateTitle"],
                                    style: const TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    "Judge: ${feedback["judge"]}",
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const Icon(Icons.arrow_upward, size: 16),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          },
        );
      },
    );
  }
}
