import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:poi/core/app_cubit/app_cubit.dart';
import 'package:poi/core/app_cubit/app_states.dart';
import 'package:poi/core/app_cubit/state_builder.dart';
import 'package:poi/core/logger/logger.dart';
import 'package:poi/core/theme/app_colors.dart';
import 'package:poi/features/Debates/data/enums/debates_status.dart';
import 'package:poi/features/Debates/data/models/debates_model.dart';
import 'package:poi/features/Debates/presentation/bloc/debates_cubit.dart';
import 'package:poi/features/Debates/presentation/bloc/debates_states.dart';
import 'package:poi/features/Debates/presentation/pages/announced_debates_page.dart';
import 'package:poi/features/Debates/presentation/pages/players_confirm_debate_details_page.dart';
import 'package:poi/features/Debates/presentation/pages/players_confirm_debates_page.dart';
import 'package:poi/features/Debates/presentation/pages/teams_confirm_debates_page.dart';
import 'package:poi/features/Debates/presentation/widgets/active_debate_widget.dart';
import 'package:poi/features/Debates/presentation/widgets/confirmed_debate_widget.dart';
import 'package:poi/features/Debates/presentation/widgets/past_debate_widget.dart';
import 'package:sizer/sizer.dart';

class DebatesPage extends StatefulWidget {
  const DebatesPage({super.key});

  @override
  State<DebatesPage> createState() => _DebatesPageState();
}

class _DebatesPageState extends State<DebatesPage>
    with TickerProviderStateMixin {
  late TabController tabController;
  var selectedPageNumber = 1;

  @override
  void initState() {
    super.initState();
    DebatesCubit.get(context).getAnnouncedDebates();
    tabController = TabController(
      length: DebatesStatus.values.length,
      vsync: this,
    );
    tabController.addListener(() {
      if (tabController.indexIsChanging) {
        DebatesCubit.get(context).onPageChanged(tabController.index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final appCubit = context.read<AppCubit>();
        final color = ThemedColors(appCubit.isLightTheme);
        final textStyle = Theme.of(context).textTheme;

        return DefaultTabController(
          length: DebatesStatus.values.length,
          child: Scaffold(
            appBar: AppBar(
              title: Text('Debates', style: TextStyle(fontSize: 18.sp)),
              elevation: 0,
            ),
            body: Column(
              children: [
                SizedBox(height: 1.5.h),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 3.w),
                  child: Container(
                    height: 6.h,
                    decoration: BoxDecoration(
                      color: AppColors.lighterColor,
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TabBar(
                      labelColor: AppColors.mainLight,
                      controller: tabController,
                      isScrollable: true,
                      labelStyle: TextStyle(
                        fontSize: 11.sp,
                        fontWeight: FontWeight.w600,
                      ),
                      unselectedLabelColor: AppColors.lighterDarkColor,
                      dividerHeight: 0,
                      padding: EdgeInsets.symmetric(horizontal: 1.w),
                      tabAlignment: TabAlignment.center,
                      dragStartBehavior: DragStartBehavior.down,
                      indicatorSize: TabBarIndicatorSize.tab,
                      indicator: BoxDecoration(
                        color: AppColors.darkBlue.withOpacity(0.9),
                        borderRadius: BorderRadius.circular(30),
                      ),
                      tabs:
                          DebatesStatus.values
                              .map((tab) => Tab(text: tab.name))
                              .toList(),
                    ),
                  ),
                ),
                SizedBox(height: 1.h),
                Expanded(
                  child: StateBuilder<DebatesStatus>(
                    cubit: DebatesCubit.get(context).currentStatusCubit,

                    builder: (currentStatus) {
                      return BlocConsumer<DebatesCubit, DebatesStates>(
                        listener: (context, state) {},
                        builder: (context, state) {
                          switch (state) {
                            case DebatesLoadingState():
                              return Center(
                                child: LoadingAnimationWidget.discreteCircle(
                                  color: color.blue,
                                  secondRingColor: color.red,
                                  thirdRingColor: color.primary,
                                  size: 35,
                                ),
                              );
                            case DebatesGetDebatesErrorState():
                              return Center(
                                child: Text(
                                  state.errorMessage,
                                  style: textStyle.bodyLarge,
                                ),
                              );
                            case DebatesGetDebatesSuccessState():
                              if (state.debatesData.data.isEmpty) {
                                return Center(
                                  child: Text(
                                    "No debates found",
                                    style: textStyle.bodyLarge,
                                  ),
                                );
                              }
                              return Stack(
                                children: [
                                  ListView.builder(
                                    padding: const EdgeInsets.all(16),
                                    itemCount: state.debatesData.data.length,
                                    itemBuilder: (context, index) {
                                      return _buildTabContent(
                                        state.debatesData.data[index],
                                        context,
                                        index,
                                        currentStatus,
                                      );
                                    },
                                  ),
                                ],
                              );
                            default:
                              return Center(
                                child: LoadingAnimationWidget.discreteCircle(
                                  color: color.blue,
                                  secondRingColor: color.red,
                                  thirdRingColor: color.primary,
                                  size: 35,
                                ),
                              );
                          }
                        },
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  // Todo build card for each debate status
  Widget _buildTabContent(
    Datum debate,
    BuildContext context,
    int index,
    DebatesStatus status,
  ) {
    switch (status) {
      case DebatesStatus.active:
        return ActiveDebatWidget();
      case DebatesStatus.playersConfirmed:
        return PlayersConfirmDebatesPage();
         case DebatesStatus.teamsConfirmed:
        return TeamsConfirmDebatesPage();
      case DebatesStatus.past:
        return PastDebateWidget();
      default:
        return AnnouncedDebateWidget(debate: debate, index: index);
    }
  }
}

// class ConfirmedPage extends StatelessWidget {
//   final List<Map<String, String>> items = [
//     {
//       'image':
//           'https://static.vecteezy.com/system/resources/thumbnails/006/406/394/small/debate-line-icon-on-white-vector.jpg',
//       'title': 'Tech & Innovation Debate',
//       'date': 'July 1, 2025',
//     },
//     {
//       'image':
//           'https://static.vecteezy.com/system/resources/thumbnails/006/406/394/small/debate-line-icon-on-white-vector.jpg',
//       'title': 'Climate Change Forum',
//       'date': 'July 5, 2025',
//     },
//     {
//       'image':
//           'https://static.vecteezy.com/system/resources/thumbnails/006/406/394/small/debate-line-icon-on-white-vector.jpg',
//       'title': 'AI & Ethics Roundtable',
//       'date': 'July 8, 2025',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           final item = items[index];

//           return ConfirmedDebateWidget(item: item);
//         },
//       ),
//     );
//   }
// }

// class ConfirmedDebateWidget extends StatelessWidget {
//   const ConfirmedDebateWidget({super.key, required this.item});

//   final Map<String, String> item;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: const EdgeInsets.only(bottom: 10),
//       padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.15),
//             blurRadius: 16,
//             spreadRadius: 1,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Row(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(14),
//             child: Image.network(
//               item['image']!,
//               width: 100,
//               height: 100,
//               fit: BoxFit.cover,
//             ),
//           ),
//           const SizedBox(width: 10),

//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               children: [
//                 const SizedBox(height: 20),
//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const Icon(
//                       Icons.calendar_month,
//                       size: 18,
//                       color: Colors.grey,
//                     ),
//                     const SizedBox(width: 6),
//                     Text(
//                       item['date']!,
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.black,
//                         fontWeight: FontWeight.w500,
//                         fontFamily: 'Ubuntu',
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 15),

//                 SizedBox(
//                   height: 30,
//                   child: Stack(
//                     children: List.generate(8, (idx) {
//                       return Positioned(
//                         left: idx * 15.0,
//                         child: CircleAvatar(
//                           radius: 10,
//                           backgroundColor: Colors.grey.shade300,
//                           child: Icon(
//                             Icons.person,
//                             size: 14,
//                             color: Colors.grey.shade700,
//                           ),
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//                 // SizedBox(
//                 //   height: 30,
//                 //   child: Stack(
//                 //     children: List.generate(8, (idx) {
//                 //       return Positioned(
//                 //         left: idx * 22.0,
//                 //         child: CircleAvatar(
//                 //           radius: 14,
//                 //           backgroundColor: Colors.grey.shade300,
//                 //           child: Icon(
//                 //             Icons.person,
//                 //             size: 16,
//                 //             color: Colors.grey.shade700,
//                 //           ),
//                 //         ),
//                 //       );
//                 //     }),
//                 //   ),
//                 // ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class ActiveDebatesPage extends StatelessWidget {
//   final List<Map<String, dynamic>> items = [
//     {
//       'id': 1,
//       'title': 'Fake title',
//       'date': 'July 2, 2025',
//       'image':
//           'https://static.vecteezy.com/system/resources/thumbnails/006/406/394/small/debate-line-icon-on-white-vector.jpg',
//     },
//     {
//       'id': 2,
//       'title': 'Fake title',
//       'date': 'July 4, 2025',
//       'image':
//           'https://static.vecteezy.com/system/resources/thumbnails/006/406/394/small/debate-line-icon-on-white-vector.jpg',
//     },
//     {
//       'id': 3,
//       'title':
//           'Fake title Fake title Fake title Fake title Fake title Fake title Fake title Fake title Fake title Fake title ',
//       'date': 'July 6, 2025',
//       'image':
//           'https://static.vecteezy.com/system/resources/thumbnails/006/406/394/small/debate-line-icon-on-white-vector.jpg',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           final item = items[index];

//           return ActiveDebatWidget(item: item);
//         },
//       ),
//     );
//   }
// }

// class ActiveDebatWidget extends StatelessWidget {
//   const ActiveDebatWidget({super.key, required this.item});

//   final Map<String, dynamic> item;

//   @override
//   Widget build(BuildContext context) {
//     return InkWell(
//       onTap: () {},
//       child: Container(
//         height: 170,
//         margin: const EdgeInsets.only(bottom: 16),
//         padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//         decoration: BoxDecoration(
//           color: Colors.white,
//           borderRadius: BorderRadius.circular(20),
//           boxShadow: [
//             BoxShadow(
//               color: Colors.black.withOpacity(0.15),
//               blurRadius: 16,
//               spreadRadius: 1,
//               offset: const Offset(0, 6),
//             ),
//           ],
//         ),
//         child: Row(
//           children: [
//             ClipRRect(
//               borderRadius: BorderRadius.circular(14),
//               child: Image.network(
//                 item['image']!,
//                 width: 100,
//                 height: 100,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             const SizedBox(width: 10),

//             Expanded(
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   const SizedBox(height: 10),
//                   Hero(
//                     tag: item['id'],
//                     child: Text(
//                       item['title'] ?? '',
//                       maxLines: 1,
//                       overflow: TextOverflow.ellipsis,
//                       style: const TextStyle(
//                         fontSize: 16,
//                         fontWeight: FontWeight.bold,
//                         fontFamily: 'Ubuntu',
//                       ),
//                     ),
//                   ),
//                   const SizedBox(height: 8),

//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       const Icon(
//                         Icons.calendar_month,
//                         size: 18,
//                         color: Colors.grey,
//                       ),
//                       const SizedBox(width: 6),
//                       Text(
//                         item['date']!,
//                         style: TextStyle(
//                           fontSize: 16,
//                           color: Colors.black,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'Ubuntu',
//                         ),
//                       ),
//                     ],
//                   ),

//                   const SizedBox(height: 10),
//                   // 8
//                   SizedBox(
//                     height: 30,
//                     child: Stack(
//                       children: List.generate(8, (idx) {
//                         return Positioned(
//                           left: idx * 15.0,
//                           child: CircleAvatar(
//                             radius: 10,
//                             backgroundColor: Colors.grey.shade300,
//                             child: Icon(
//                               Icons.person,
//                               size: 14,
//                               color: Colors.grey.shade700,
//                             ),
//                           ),
//                         );
//                       }),
//                     ),
//                   ),
//                   const SizedBox(height: 10),

//                   Align(
//                     // alignment: Alignment.center,
//                     alignment: Alignment.bottomRight,
//                     child: Container(
//                       decoration: BoxDecoration(
//                         gradient: LinearGradient(
//                           colors: [AppColors.darkBlue, AppColors.darkRed],
//                           begin: Alignment.topLeft,
//                           end: Alignment.bottomRight,
//                         ),
//                         borderRadius: BorderRadius.circular(12),
//                       ),
//                       child: Material(
//                         color: Colors.transparent,
//                         borderRadius: BorderRadius.circular(12),
//                         child: InkWell(
//                           borderRadius: BorderRadius.circular(12),
//                           onTap: () {
//                             ScaffoldMessenger.of(context).showSnackBar(
//                               SnackBar(
//                                 content: Text('Watching "${item['title']}"...'),
//                               ),
//                             );
//                           },
//                           child: const Padding(
//                             padding: EdgeInsets.symmetric(
//                               // horizontal: 98,
//                               horizontal: 40,
//                               vertical: 8,
//                             ),
//                             child: Text(
//                               'Watch',
//                               style: TextStyle(
//                                 fontSize: 14,
//                                 color: Colors.white,
//                                 fontWeight: FontWeight.w600,
//                                 fontFamily: 'Ubuntu',
//                               ),
//                             ),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

// class PastDebatesPage extends StatelessWidget {
//   final List<Map<String, String>> items = [
//     {
//       'image':
//           'https://static.vecteezy.com/system/resources/thumbnails/006/406/394/small/debate-line-icon-on-white-vector.jpg',
//       'title': 'Freedom of Speech Limits',
//       'date': 'June 20, 2025',
//     },
//     {
//       'image':
//           'https://static.vecteezy.com/system/resources/thumbnails/006/406/394/small/debate-line-icon-on-white-vector.jpg',
//       'title': 'Universal Basic Income',
//       'date': 'June 15, 2025',
//     },
//     {
//       'image':
//           'https://static.vecteezy.com/system/resources/thumbnails/006/406/394/small/debate-line-icon-on-white-vector.jpg',
//       'title': 'Privacy vs Security',
//       'date': 'June 10, 2025',
//     },
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: ListView.builder(
//         padding: const EdgeInsets.all(16),
//         itemCount: items.length,
//         itemBuilder: (context, index) {
//           final item = items[index];

//           return PastDebateWidget(item: item);
//         },
//       ),
//     );
//   }
// }

// class PastDebateWidget extends StatelessWidget {
//   const PastDebateWidget({super.key, required this.item});

//   final Map<String, String> item;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: 150,
//       margin: const EdgeInsets.only(bottom: 16),
//       padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
//       decoration: BoxDecoration(
//         color: Colors.white,
//         borderRadius: BorderRadius.circular(20),
//         boxShadow: [
//           BoxShadow(
//             color: Colors.black.withOpacity(0.15),
//             blurRadius: 16,
//             spreadRadius: 1,
//             offset: const Offset(0, 6),
//           ),
//         ],
//       ),
//       child: Row(
//         children: [
//           ClipRRect(
//             borderRadius: BorderRadius.circular(14),
//             child: Image.network(
//               item['image']!,
//               width: 100,
//               height: 100,
//               fit: BoxFit.cover,
//             ),
//           ),
//           const SizedBox(width: 10),
//           Expanded(
//             child: Column(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 Text(
//                   item['title'] ?? '',
//                   maxLines: 2,
//                   overflow: TextOverflow.ellipsis,
//                   style: const TextStyle(
//                     fontSize: 16,
//                     fontWeight: FontWeight.bold,
//                     fontFamily: 'Ubuntu',
//                   ),
//                 ),
//                 const SizedBox(height: 10),

//                 Row(
//                   mainAxisAlignment: MainAxisAlignment.start,
//                   children: [
//                     const Icon(
//                       Icons.calendar_month,
//                       size: 18,
//                       color: Colors.grey,
//                     ),
//                     const SizedBox(width: 6),
//                     Text(
//                       item['date']!,
//                       style: TextStyle(
//                         fontSize: 16,
//                         color: Colors.black,
//                         fontWeight: FontWeight.w500,
//                         fontFamily: 'Ubuntu',
//                       ),
//                     ),
//                   ],
//                 ),

//                 const SizedBox(height: 15),
//                 // 8
//                 SizedBox(
//                   height: 30,
//                   child: Stack(
//                     children: List.generate(8, (idx) {
//                       return Positioned(
//                         left: idx * 15.0,
//                         child: CircleAvatar(
//                           radius: 10,
//                           backgroundColor: Colors.grey.shade300,
//                           child: Icon(
//                             Icons.person,
//                             size: 14,
//                             color: Colors.grey.shade700,
//                           ),
//                         ),
//                       );
//                     }),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
