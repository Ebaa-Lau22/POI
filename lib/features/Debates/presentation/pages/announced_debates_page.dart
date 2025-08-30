import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:number_pagination/number_pagination.dart';
import 'package:poi/core/app_cubit/app_cubit.dart';
import 'package:poi/core/app_cubit/app_states.dart';
import 'package:poi/core/theme/app_colors.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';
import 'package:poi/features/Debates/presentation/bloc/debates_cubit.dart';
import 'package:poi/features/Debates/presentation/bloc/debates_states.dart';

class AnnouncedDebatesPage extends StatefulWidget {
  @override
  State<AnnouncedDebatesPage> createState() => _AnnouncedDebatesPageState();
}

class _AnnouncedDebatesPageState extends State<AnnouncedDebatesPage> {
  var selectedPageNumber = 1;

  final ScrollController _scrollController = ScrollController();
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
                          return AnnouncedDebateWidget(
                            debate: debate,
                            index: index,
                          );
                        },
                      ),
                    ),
                    // Pagination
                    // NumberPagination(
                    //   selectedButtonColor: AppColors.lightBlue,
                    //   unSelectedButtonColor: AppColors.mainLight,
                    //   betweenNumberButtonSpacing: 5,
                    //   fontFamily: 'Lato',
                    //   selectedNumberFontWeight: FontWeight.w800,
                    //   selectedNumberColor: AppColors.white,
                    //   unSelectedNumberColor: AppColors.lighterDarkColor,
                    //   buttonRadius: 5,
                    //   numberButtonSize: Size(40, 40),
                    //   controlButtonSize: Size(35, 35),
                    //   onPageChanged: (int pageNumber) {
                    //     setState(() {
                    //       selectedPageNumber = pageNumber;
                    //     });
                    //     DebatesCubit.get(context).changePage(pageNumber);
                    //   },
                    //   visiblePagesCount: 3,
                    //   totalPages: 10,
                    //   currentPage: selectedPageNumber,
                    // ),
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

class AnnouncedDebateWidget extends StatelessWidget {
  const AnnouncedDebateWidget({
    super.key,
    required this.debate,
    required this.index,
  });

  final Datum debate;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
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
            child: Row(
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
                          debate.type,
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
                          ).format(debate.startDate!.toLocal()),
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
                Container(
                  decoration: BoxDecoration(
                    gradient:
                        debate.isAbleToApply
                            ? const LinearGradient(
                              colors: [AppColors.darkRed, AppColors.darkBlue],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            )
                            : null,
                    color: debate.isAbleToApply ? null : Colors.grey.shade400,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(12),
                    child: InkWell(
                      borderRadius: BorderRadius.circular(12),
                      onTap:
                          debate.isAbleToApply
                              ? () {
                                DebatesCubit.get(context).toggleApply(index);
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(content: Text('Joined!')),
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
                              debate.isAbleToApply ? 'Join' : 'Joined!',
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
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
