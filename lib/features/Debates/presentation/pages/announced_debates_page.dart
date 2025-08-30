// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl/intl.dart';
// import 'package:loading_animation_widget/loading_animation_widget.dart';
// import 'package:poi/core/app_cubit/app_cubit.dart';
// import 'package:poi/core/app_cubit/app_states.dart';
// import 'package:poi/core/storage/preferences_database.dart';
// import 'package:poi/core/theme/app_colors.dart';
// import 'package:poi/features/Debates/data/models/debates_model.dart';
// import 'package:poi/features/Debates/presentation/bloc/debates_cubit.dart';
// import 'package:poi/features/Debates/presentation/bloc/debates_states.dart';
// import 'package:poi/features/Debates/presentation/pages/archived_debates_page.dart';

// class AnnouncedDebatesPage extends StatefulWidget {
//   @override
//   State<AnnouncedDebatesPage> createState() => _AnnouncedDebatesPageState();
// }

// class _AnnouncedDebatesPageState extends State<AnnouncedDebatesPage> {
//   var selectedPageNumber = 1;

//   //  final ScrollController _scrollController = ScrollController();

//   @override
//   void initState() {
//     super.initState();
//     DebatesCubit.get(context).getAnnouncedDebates();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit, AppStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         final appCubit = context.read<AppCubit>();
//         final color = ThemedColors(appCubit.isLightTheme);
//         final textStyle = Theme.of(context).textTheme;
//         return Scaffold(
//           body: BlocConsumer<DebatesCubit, DebatesStates>(
//             listener: (context, state) {},
//             builder: (context, state) {
//               if (state is DebatesLoadingState) {
//                 return Center(
//                   child: LoadingAnimationWidget.discreteCircle(
//                     color: color.blue,
//                     secondRingColor: color.red,
//                     thirdRingColor: color.primary,
//                     size: 35,
//                   ),
//                 );
//               } else if (state is DebatesGetDebatesErrorState) {
//                 Center(
//                   child: Text(
//                     "${state.errorMessage}",
//                     style: textStyle.bodyLarge,
//                   ),
//                 );
//               } else if (state is DebatesGetDebatesSuccessState) {
//                 return Column(
//                   children: [
//                     SizedBox(
//                       height: 500,
//                       child: ListView.builder(
//                         padding: const EdgeInsets.all(16),
//                         itemCount: state.debatesData.data.length,
//                         itemBuilder: (context, index) {
//                           final debate = state.debatesData.data[index];
//                           return AnnouncedDebateWidget(
//                             debate: debate,
//                             index: index,
//                           );
//                         },
//                       ),
//                     ),
//                     // Pagination
//                     // NumberPagination(
//                     //   selectedButtonColor: AppColors.lightBlue,
//                     //   unSelectedButtonColor: AppColors.mainLight,
//                     //   betweenNumberButtonSpacing: 5,
//                     //   fontFamily: 'Lato',
//                     //   selectedNumberFontWeight: FontWeight.w800,
//                     //   selectedNumberColor: AppColors.white,
//                     //   unSelectedNumberColor: AppColors.lighterDarkColor,
//                     //   buttonRadius: 5,
//                     //   numberButtonSize: Size(40, 40),
//                     //   controlButtonSize: Size(35, 35),
//                     //   onPageChanged: (int pageNumber) {
//                     //     setState(() {
//                     //       selectedPageNumber = pageNumber;
//                     //     });
//                     //     DebatesCubit.get(context).changePage(pageNumber);
//                     //   },
//                     //   visiblePagesCount: 3,
//                     //   totalPages: 10,
//                     //   currentPage: selectedPageNumber,
//                     // ),
//                   ],
//                 );
//               }

//               return Center(
//                 child: LoadingAnimationWidget.discreteCircle(
//                   color: color.blue,
//                   secondRingColor: color.red,
//                   thirdRingColor: color.primary,
//                   size: 35,
//                 ),
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
