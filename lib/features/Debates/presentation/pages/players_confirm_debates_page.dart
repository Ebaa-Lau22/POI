import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:poi/core/app_cubit/app_cubit.dart';
import 'package:poi/core/app_cubit/app_states.dart';
import 'package:poi/core/storage/preferences_database.dart';
import 'package:poi/core/theme/app_colors.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';
import 'package:poi/features/Debates/presentation/bloc/debates_cubit.dart';
import 'package:poi/features/Debates/presentation/bloc/debates_states.dart';

class PlayersConfirmDebatesPage extends StatefulWidget {
  @override
  State<PlayersConfirmDebatesPage> createState() =>
      _PlayersConfirmDebatesPageState();
}

class _PlayersConfirmDebatesPageState
    extends State<PlayersConfirmDebatesPage> {
  var selectedPageNumber = 1;

  @override
  void initState() {
    super.initState();
    DebatesCubit.get(context).getAnnouncedDebates();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final appCubit = context.read<AppCubit>();
        final color = ThemedColors(appCubit.isLightTheme);
        final textStyle = Theme.of(context).textTheme;

        return Scaffold(
          body: BlocConsumer<DebatesCubit, DebatesStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is DebatesLoadingState) {
                return Center(
                  child: LoadingAnimationWidget.discreteCircle(
                    color: color.blue,
                    secondRingColor: color.red,
                    thirdRingColor: color.primary,
                    size: 35,
                  ),
                );
              } else if (state is DebatesGetDebatesErrorState) {
                return Center(
                  child: Text(
                    "${state.errorMessage}",
                    style: textStyle.bodyLarge,
                  ),
                );
              } else if (state is DebatesGetDebatesSuccessState) {
                return Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.debatesData.data.length,
                        itemBuilder: (context, index) {
                          final debate = state.debatesData.data[index];
                          return PlayersConfirmDebateWidget(
                            debate: debate,
                            index: index,
                          );
                        },
                      ),
                    ),
                    // Pagination ممكن ترجعه هنا
                  ],
                );
              }

              return Center(
                child: LoadingAnimationWidget.discreteCircle(
                  color: color.blue,
                  secondRingColor: color.red,
                  thirdRingColor: color.primary,
                  size: 35,
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class PlayersConfirmDebateWidget extends StatefulWidget {
  const PlayersConfirmDebateWidget({
    super.key,
    required this.debate,
    required this.index,
  });

  final Datum debate;
  final int index;

  @override
  State<PlayersConfirmDebateWidget> createState() =>
      _PlayersConfirmDebateWidgetState();
}

class _PlayersConfirmDebateWidgetState
    extends State<PlayersConfirmDebateWidget> {
  String savedGuard = "";

  @override
  void initState() {
    super.initState();
    _loadGuard();
  }

  Future<void> _loadGuard() async {
    final prefs = PreferencesDatabase();
    final value = await prefs.getEncryptedValue("Guard");
    if (!mounted) return;
    setState(() {
      savedGuard = value ?? "";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
                           // height: 100,
                            margin: const EdgeInsets.only(bottom: 16),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: AppColors.mainLight,
                              borderRadius: BorderRadius.circular(20),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.1),
                                  blurRadius: 16,
                                  spreadRadius: 1,
                                  offset: const Offset(0, 6),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // الصورة
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(14),
                                  child: Image.network(
                                    "https://static.vecteezy.com/system/resources/thumbnails/006/406/394/small/debate-line-icon-on-white-vector.jpg",
                                    width: 100,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                const SizedBox(width: 10),
                                // النوع + التاريخ + الوقت
                                Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    // نوع المناظرة
                                    Text(
                                    widget.debate.type,
                                      style: const TextStyle(
                                        fontSize: 15,
                                        color: Colors.black54,
                                        fontWeight: FontWeight.bold,
                                        fontFamily: 'Ubuntu',
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    // التاريخ
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.calendar_month,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          DateFormat(
                                            'dd-MM-yyyy',
                                          ).format(widget.debate.startDate!.toLocal()),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Ubuntu',
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 5),
                                    // الوقت
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.access_time,
                                          size: 18,
                                          color: Colors.grey,
                                        ),
                                        const SizedBox(width: 6),
                                        Text(
                                          DateFormat(
                                            'HH:mm',
                                          ).format(widget.debate.startDate!.toLocal()),
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                            fontFamily: 'Ubuntu',
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          );
  }
}
