import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poi/core/app_cubit/app_cubit.dart';
import 'package:poi/core/components/navigators.dart';
import 'package:poi/core/constants/constants.dart';
import 'package:poi/core/localization/l10n/context_localiztion.dart';
import 'package:poi/features/debate_setup/presentation/bloc/team_assignment_cubit.dart';
import 'package:poi/features/debate_setup/presentation/bloc/team_assignment_states.dart';
import 'package:poi/features/debate_setup/presentation/widgets/team_card.dart';
import 'package:sizer/sizer.dart';
import '../../../../core/app_cubit/app_states.dart';
import '../../../../core/theme/app_colors.dart';

class MotionScreen extends StatelessWidget {
  const MotionScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AppCubit, AppStates>(
        builder: (context, state) {
          final appCubit = context.read<AppCubit>();
          final color = ThemedColors(appCubit.isLightTheme);
          final textStyle = Theme.of(context).textTheme;
          return BlocBuilder<DebateSetupCubit, DebateSetupStates>(
            builder: (context, state) {
              final cubit = context.read<DebateSetupCubit>();
              return Scaffold(
                appBar: AppBar(
                  title: Text('Assign Debate Sides'),
                  actions: [
                    IconButton(
                      onPressed: () {
                        appCubit.changeTheme(!appCubit.isLightTheme);
                      },
                      icon: Icon(
                        appCubit.isLightTheme
                            ? Icons.dark_mode_outlined
                            : Icons.light_mode_outlined,
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        appCubit.changeLocale(
                          appCubit.locale == "en" ? "ar" : "en",
                        );
                      },
                      icon: Icon(Icons.translate),
                    ),
                  ],
                ),
                body: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 18.0),
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Expanded(
                        flex: 4,
                        child: GridView.count(
                          crossAxisCount: 2,
                          childAspectRatio: 0.7,
                          padding: const EdgeInsets.all(16),
                          mainAxisSpacing: 16,
                          crossAxisSpacing: 16,
                          children: List.generate(cubit.currentTeams.length, (index) {
                            DebateTeam team = DebateTeam(player1: "player${index*10}", player2: "player${index*10+1}", assignedSide: cubit.currentTeams[index]);
                            return ClipRRect(
                              borderRadius: BorderRadius.circular(widgetBorderRadius),
                              child: TeamCard(
                                team: team,
                                availableSides: cubit.allSides,
                                color: color,
                                textStyles: textStyle,
                              ),
                            );
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 48.0, vertical: 32),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  cubit.randomizeSides();
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: color.secondary.withOpacity(0.2), ),
                                child: Text(context.loc.random, style: TextStyle(color: color.red),),
                              ),
                            ),
                            SizedBox(width: 15.w,),
                            Expanded(
                              child: ElevatedButton(
                                onPressed: () {
                                  navigateTo(context, MotionScreen());
                                },
                                style: ElevatedButton.styleFrom(backgroundColor: color.red),
                                child: Text(context.loc.random, style: TextStyle(color: AppColors.lighterColor),),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          );
        }
    );
  }
}
