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

class ActiveDebatesPage extends StatefulWidget {
  @override
  State<ActiveDebatesPage> createState() => _ActiveDebatesPageState();
}

class _ActiveDebatesPageState extends State<ActiveDebatesPage> {
  var selectedPageNumber = 1;

  //final ScrollController _scrollController = ScrollController();

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
                Center(
                  child: Text(
                    "${state.errorMessage}",
                    style: textStyle.bodyLarge,
                  ),
                );
              } else if (state is DebatesGetDebatesSuccessState) {
                return Column(
                  children: [
                    SizedBox(
                      height: 500,
                      child: ListView.builder(
                        padding: const EdgeInsets.all(16),
                        itemCount: state.debatesData.data.length,
                        itemBuilder: (context, index) {
                          final debate = state.debatesData.data[index];
                          return ActiveDebateWidget(
                            debate: debate,
                            index: index,
                          );
                        },
                      ),
                    ),
                 
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

class ActiveDebateWidget extends StatefulWidget {
  const ActiveDebateWidget({
    super.key,
    required this.debate,
    required this.index,
  });

  final Datum debate;
  final int index;

  @override
  State<ActiveDebateWidget> createState() => _AnnouncedDebateWidgetState();
}

class _AnnouncedDebateWidgetState extends State<ActiveDebateWidget> {
   String savedGuard = "";

  @override
  void initState() {
    super.initState();
    _loadGuard();
  }

  Future<void> _loadGuard() async {
    final prefs = PreferencesDatabase();
    final value = await prefs.getEncryptedValue("Guard");
    setState(() {
      savedGuard = value ?? "";
    });
  }
  @override
  Widget build(BuildContext context) {
  
    return Container(
     // height: 110,
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: AppColors.lighterColor,
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
          ClipRRect(
            borderRadius: BorderRadius.circular(14),
            child:
            //  Image.asset(
            //   "assets/images/debate.png",
            //   width: 100,
            //   height: 100,
            //   fit: BoxFit.cover,
            // ),
            Image.network(
              "https://static.vecteezy.com/system/resources/thumbnails/006/406/394/small/debate-line-icon-on-white-vector.jpg",
              width: 100,
              height: 100,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const SizedBox(width: 3),
                            Container(
                              width: 12,
                              height: 12,
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: Colors.grey,
                              ),
                            ),
                            const SizedBox(width: 6),
                            Text(
                              widget.debate.type,
                              style: const TextStyle(
                                fontSize: 15,
                                color: Colors.black54,
                                fontWeight: FontWeight.bold,
                                fontFamily: 'Ubuntu',
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 5),
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
                        Row(
                          children: [
                            const Icon(
                              Icons.access_time,
                              size: 18,
                              color: Colors.grey,
                            ),
                            const SizedBox(width: 6),
                            Text(
                              DateFormat('HH:mm').format(
                                DateFormat('HH:mm:ss').parse(widget.debate.startTime),
                              ),
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
                    (savedGuard == "debater")
                        ? Container(
                          decoration: BoxDecoration(
                            gradient:
                                widget.debate.isAbleToApply
                                    ? const LinearGradient(
                                      colors: [
                                        AppColors.darkRed,
                                        AppColors.darkBlue,
                                      ],
                                      begin: Alignment.topLeft,
                                      end: Alignment.bottomRight,
                                    )
                                    : null,
                            color:
                                widget.debate.isAbleToApply
                                    ? null
                                    : Colors.grey.shade400,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Material(
                            color: Colors.transparent,
                            borderRadius: BorderRadius.circular(12),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(12),
                              onTap:
                                  widget.debate.isAbleToApply
                                      ? () {
                                        DebatesCubit.get(
                                          context,
                                        ).toggleApply(widget.index);
                                        ScaffoldMessenger.of(
                                          context,
                                        ).showSnackBar(
                                          const SnackBar(
                                            content: Text('Joined!'),
                                          ),
                                        );
                                      }
                                      : null,
                              child: Padding(
                                padding: const EdgeInsets.all(10),
                                child: SizedBox(
                                  width: 60,
                                  height: 20,
                                  child: Center(
                                    child: Text(
                                      widget.debate.isAbleToApply ? 'Join' : 'Joined!',
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 14,
                                        color: Colors.white,
                                        fontWeight: FontWeight.w600,
                                        fontFamily: 'Ubuntu',
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                        : const SizedBox.shrink(),
                  ],
                ),
                const SizedBox(height: 10),
                (savedGuard == "judge")
                    ? Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              // logic for joining as chair
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.lightBlue,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Text(
                                  'Join as Chair',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Ubuntu',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Expanded(
                          child: InkWell(
                            onTap: () {
                              // logic for joining as panelist
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 10),
                              decoration: BoxDecoration(
                                color: AppColors.lightBlue,
                                borderRadius: BorderRadius.circular(12),
                              ),
                              child: const Center(
                                child: Text(
                                  'Join as Panelist',
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontFamily: 'Ubuntu',
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    )
                    : const SizedBox.shrink(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
