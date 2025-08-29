import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poi/core/app_cubit/app_cubit.dart';
import 'package:poi/core/app_cubit/app_states.dart';
import 'package:poi/core/theme/app_colors.dart';
import 'package:poi/features/Debates/presentation/bloc/debates_cubit.dart';
import 'package:poi/features/Debates/presentation/bloc/debates_states.dart';

class FeedbackPage extends StatefulWidget {
  const FeedbackPage({super.key});

  @override
  State<FeedbackPage> createState() => _FeedbackPageState();
}

class _FeedbackPageState extends State<FeedbackPage> {
  final TextEditingController feedbackController = TextEditingController();

  final List<Map<String, dynamic>> debaters = [
    {"id": 1, "name": "Ahmad Ali"},
    {"id": 2, "name": "Sara Khan"},
    {"id": 3, "name": "John Doe"},
    {"id": 4, "name": "Lina M."},
  ];

  String? selectedDebaterName; // اسم للعرض
  int? selectedDebaterId; // ID للإرسال

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
              appBar: AppBar(title: const Text("Send Feedback")),
              body: SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // ====== Feedback Text ======
                    const Text(
                      "Your Feedback",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    TextFormField(
                      controller: feedbackController,
                      maxLines: null,
                      minLines: 5,
                      keyboardType: TextInputType.multiline,
                      decoration: fieldDecoration(
                        "Write your feedback here...",
                      ),
                    ),
                    const SizedBox(height: 20),

                    // ====== Select Debater ======
                    const Text(
                      "Select Debater",
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 6),
                    SizedBox(
                      width: double.infinity,
                      child: DropdownButtonFormField<String>(
                        value: selectedDebaterName,
                        isExpanded: true,
                        decoration: fieldDecoration("Choose a debater"),
                        items:
                            debaters.map((debater) {
                              final name = debater["name"]?.toString() ?? "";
                              return DropdownMenuItem<String>(
                                value: name,
                                child: Text(name),
                              );
                            }).toList(),
                        onChanged: (value) {
                          setState(() {
                            selectedDebaterName = value;
                            selectedDebaterId =
                                debaters.firstWhere(
                                      (debater) => debater["name"] == value,
                                      orElse: () => {"id": null},
                                    )["id"]
                                    as int?;
                          });
                        },
                      ),
                    ),

                    const SizedBox(height: 30),

                    Center(
                      child: ElevatedButton(
                        onPressed: () {
                          if (feedbackController.text.isEmpty ||
                              selectedDebaterId == null) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text(
                                  "Please fill feedback and select a debater",
                                ),
                              ),
                            );
                            return;
                          }

                          // هنا يمكن ربط API لإرسال الفيدباك
                          final payload = {
                            "debater_id": selectedDebaterId,
                            "feedback": feedbackController.text,
                          };

                          print(payload); // مثال للطباعة قبل إرسالها

                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Feedback sent successfully"),
                            ),
                          );

                          feedbackController.clear();
                          setState(() {
                            selectedDebaterName = null;
                            selectedDebaterId = null;
                          });
                        },
                        child: const Text("Send Feedback"),
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
