import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:poi/core/app_cubit/app_cubit.dart';
import 'package:poi/core/app_cubit/app_states.dart';
import 'package:poi/core/components/navigators.dart';
import 'package:poi/core/localization/l10n/context_localiztion.dart';
import 'package:poi/core/theme/app_colors.dart';
import 'package:poi/features/call/call_screen.dart';
import 'package:poi/features/profiles/presentation/bloc/profile_cubit.dart';
import 'package:poi/features/profiles/presentation/bloc/profile_states.dart';
import 'package:sizer/sizer.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    super.initState();
    ProfileCubit.get(context).getProfile();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;

    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final appCubit = context.read<AppCubit>();
        final color = ThemedColors(appCubit.isLightTheme);
        final textStyle = Theme.of(context).textTheme;
        return Scaffold(
          backgroundColor: color.primary.withOpacity(0.9),
          body: BlocConsumer<ProfileCubit, ProfileStates>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is ProfileLoadingState) {
                return Center(
                  child: LoadingAnimationWidget.discreteCircle(
                    color: color.blue,
                    secondRingColor: color.red,
                    thirdRingColor: color.primary,
                    size: 35,
                  ),
                );
              } else if (state is ProfileGetprofileErrorState) {
                Center(
                  child: Text(
                    "${state.errorMessage}",
                    style: textStyle.bodyLarge,
                  ),
                );
              } else if (state is ProfileGetProfileSuccessState) {
                final user = state.profileData.data.first;
                final profile = user.profile;
                final picUrl = profile?.profilePictureUrl;
                final hasPic = picUrl != null && picUrl.toString().isNotEmpty;
                final firstLetter =
                    (profile?.firstName != null &&
                            profile!.firstName!.isNotEmpty)
                        ? profile.firstName![0].toUpperCase()
                        : '';

                return SingleChildScrollView(
                  child: Column(
                    children: [
                      Stack(
                        clipBehavior: Clip.none,
                        children: [
                          ClipPath(
                            clipper: CurvedHeaderClipper(),
                            child: Container(
                              height: 26.h,
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.darkRed,
                                    AppColors.darkBlue,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                              ),
                              child: Stack(
                                children: [
                                  Positioned(
                                    top: 40.0,
                                    right: 10.0,
                                    child: IconButton(
                                      icon: Icon(
                                        Icons.logout_rounded,
                                        color: AppColors.lighterColor,
                                        size: 26,
                                      ),
                                      onPressed: () {
                                        showDialog(
                                          context: context,
                                          barrierDismissible: false,

                                          barrierColor: Colors.black54,
                                          builder:
                                              (context) => AlertDialog(
                                                backgroundColor: color.primary,
                                                title: Text(
                                                  context.loc.confirmLogout,
                                                  style: textStyle.displaySmall
                                                      ?.copyWith(
                                                        color:
                                                            AppColors.darkBlue,
                                                      ),
                                                ),
                                                content: Text(
                                                  context.loc.confirmLogoutText,
                                                  style: textStyle.labelLarge,
                                                ),
                                                actions: [
                                                  TextButton(
                                                    onPressed:
                                                        () =>
                                                            Navigator.of(
                                                              context,
                                                            ).pop(),
                                                    child: Text(
                                                      context.loc.cancel,
                                                      style:
                                                          textStyle.labelLarge,
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      navigateTo(
                                                        context,
                                                        VideoCallScreen(),
                                                      );
                                                    },
                                                    child: Text(
                                                      context.loc.logOut,
                                                      style: textStyle
                                                          .labelLarge
                                                          ?.copyWith(
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: color.red,
                                                          ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          Positioned(
                            top: 14.h,
                            left: screenWidth / 2 - 7.4.h,
                            child: Container(
                              padding: EdgeInsets.all(0.5.h),
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  colors: [
                                    AppColors.darkRed,
                                    AppColors.darkBlue,
                                  ],
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                ),
                                shape: BoxShape.circle,
                                boxShadow: [
                                  BoxShadow(
                                    color: AppColors.light,
                                    blurRadius: 5,
                                    offset: Offset(0, 2),
                                  ),
                                ],
                              ),
                              child: CircleAvatar(
                                radius: 7.h,
                                backgroundColor: Colors.grey.shade400,
                                backgroundImage:
                                    hasPic ? NetworkImage(picUrl!) : null,
                                child:
                                    !hasPic
                                        ? Center(
                                          child: Text(
                                            firstLetter,
                                            style: textStyle.displayLarge
                                                ?.copyWith(
                                                  color: AppColors.lighterColor,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                          ),
                                        )
                                        : null,
                              ),
                            ),
                          ),
                        ],
                      ),

                      SizedBox(height: 5.h),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Text(
                            '${profile?.firstName ?? ''}',
                            style: textStyle.displayMedium,
                          ),
                          SizedBox(width: 1.w),
                          Text(
                            '${profile?.lastName ?? ''}',
                            style: textStyle.displayMedium,
                          ),
                        ],
                      ),

                      SizedBox(height: 1.h),
                      Text(
                        '${profile?.email ?? ''}',
                        style: textStyle.displaySmall?.copyWith(
                          color: color.secondary.withOpacity(0.5),
                          fontSize: 18,
                        ),
                      ),

                      //     SizedBox(height: 3.h),
                      /*
                      Container(
                        width: 35.w,
                        height: 5.h,
                        decoration: BoxDecoration(
                          gradient: const LinearGradient(
                            colors: [Color(0xff8C3A3A), Color(0xff304F73)],
                            begin: Alignment.topLeft,
                            end: Alignment.bottomRight,
                          ),
                          borderRadius: BorderRadius.circular(30),
                        ),
                        child: Material(
                          color: Colors.transparent,
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: () {},
                            child: Padding(
                              padding: EdgeInsets.symmetric(horizontal: 3.w),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.edit,
                                    color: Colors.white,
                                    size: 14.sp,
                                  ),
                                  SizedBox(width: 2.w),
                                  Text(
                                    'Edit Profile',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 11.sp,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
*/
                      SizedBox(height: 2.h),

                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 4.5.w),
                        child: Column(
                          children: [
                            InfoRow(
                              icon: Icons.person,
                              title: context.loc.userType,
                              value: state.profileData.data.first.guard ?? '',
                            ),
                            InfoRow(
                              icon: Icons.phone_android_rounded,
                              title: context.loc.mobileNumber,
                              value: profile?.mobileNumber ?? '',
                            ),
                            SizedBox(height: 0.5.h),
                            InfoRow(
                              icon: Icons.location_on_rounded,
                              title: context.loc.governorate,
                              value: profile?.governorate ?? '',
                            ),
                            SizedBox(height: 0.5.h),
                            InfoRow(
                              icon: Icons.cake_rounded,
                              title: context.loc.birthDate,
                              value:
                                  profile?.birthDate != null
                                      ? DateFormat(
                                        'dd-MM-yyyy',
                                      ).format(profile!.birthDate!.toLocal())
                                      : '',
                            ),
                            SizedBox(height: 0.5.h),
                            InfoRow(
                              icon: Icons.school_rounded,
                              title: context.loc.educationDegree,
                              value: profile?.educationDegree ?? '',
                            ),
                            SizedBox(height: 0.5.h),
                            InfoRow(
                              icon: Icons.account_balance_rounded,
                              title: context.loc.faculty,
                              value: profile?.faculty ?? '',
                            ),
                            SizedBox(height: 0.5.h),
                            InfoRow(
                              icon: Icons.location_city_rounded,
                              title: context.loc.university,
                              value: profile?.university ?? '',
                            ),
                            SizedBox(height: 0.5.h),
                            if (user.guard == 'debater')
                              Padding(
                                padding: EdgeInsets.symmetric(horizontal: 6.w),
                                child: GestureDetector(
                                  onTap: () {
                                    // context.push('/coach-profile/${user.coachId}');
                                  },
                                  child: Card(
                                    elevation: 2,
                                    color: AppColors.mainLight,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(12),
                                    ),
                                    child: Padding(
                                      padding: EdgeInsets.symmetric(
                                        horizontal: 4.w,
                                        vertical: 2.h,
                                      ),
                                      child: Row(
                                        children: [
                                          CircleAvatar(
                                            radius: 3.h,
                                            backgroundColor: Colors.black12,
                                            child: Icon(
                                              Icons.person,
                                              color: Colors.grey[700],
                                              size: 24.sp,
                                            ),
                                          ),
                                          SizedBox(width: 4.w),
                                          Expanded(
                                            child: Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Text(
                                                  'Coach',
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    color: Colors.grey[600],
                                                  ),
                                                ),
                                                Text(
                                                  user.coachName ??
                                                      'Unknown Coach',
                                                  style: TextStyle(
                                                    fontSize: 12.sp,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_forward_ios,
                                            size: 14.sp,
                                            color: Colors.grey,
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              )
                            else if (state.profileData.data.first.guard ==
                                'judge')
                              InfoRow(
                                icon: Icons.gavel,
                                title: 'games',
                                value:
                                    state.profileData.data.first.debates ??
                                    'game',
                              )
                            else if (state.profileData.data.first.guard ==
                                'coach')
                              Padding(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 5.w,
                                  vertical: 1.h,
                                ),
                                child: Card(
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12),
                                  ),
                                  child: Padding(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 4.w,
                                      vertical: 2.h,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Icon(
                                              Icons.groups,
                                              size: 20.sp,
                                              color: Colors.teal,
                                            ),
                                            SizedBox(width: 3.w),
                                            Text(
                                              'My Debaters',
                                              style: TextStyle(
                                                fontSize: 11.sp,
                                                color: Colors.grey[600],
                                              ),
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 1.h),
                                        if (state
                                            .profileData
                                            .data
                                            .first
                                            .team
                                            .isNotEmpty)
                                          ...state.profileData.data.first.team.map((
                                            debater,
                                          ) {
                                            final profile = debater['profile'];
                                            final name =
                                                (profile != null)
                                                    ? '${profile['firstName'] ?? ''} ${profile['lastName'] ?? ''}'
                                                        .trim()
                                                    : 'Unnamed Debater';

                                            return Padding(
                                              padding: EdgeInsets.symmetric(
                                                vertical: 0.5.h,
                                              ),
                                              child: Text(
                                                name,
                                                style: TextStyle(
                                                  fontSize: 12.sp,
                                                ),
                                              ),
                                            );
                                          }).toList()
                                        else
                                          Text(
                                            'No debaters assigned',
                                            style: TextStyle(
                                              fontSize: 12.sp,
                                              fontStyle: FontStyle.italic,
                                            ),
                                          ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                          ],
                        ),
                      ),
                      // LastDebatesSection(),
                    ],
                  ),
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

class CurvedHeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path =
        Path()
          ..lineTo(0, size.height - 8.h)
          ..quadraticBezierTo(
            size.width / 2,
            size.height,
            size.width,
            size.height - 7.h,
          )
          ..lineTo(size.width, 0)
          ..close();
    return path;
  }

  @override
  bool shouldReclip(CustomClipper<Path> oldClipper) => false;
}

class InfoRow extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const InfoRow({
    super.key,
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppStates>(
      listener: (context, state) {},
      builder: (context, state) {
        final appCubit = context.read<AppCubit>();
        final color = ThemedColors(appCubit.isLightTheme);
        final textStyle = Theme.of(context).textTheme;
        return Padding(
          padding: EdgeInsets.symmetric(vertical: 1.h),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // icon
              Container(
                padding: EdgeInsets.all(2.w),
                decoration: BoxDecoration(
                  // color: color.secondary,
                  border: Border.all(
                    color: AppColors.lightBlue.withOpacity(0.5),
                  ),
                  shape: BoxShape.circle,
                ),
                child: Icon(icon, size: 18.sp, color: color.blue),
              ),

              SizedBox(width: 5.w),

              // text
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      title,
                      style: textStyle.labelLarge?.copyWith(
                        color: AppColors.lightBlue,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 0.5.h),
                    Text(
                      value,
                      style: textStyle.labelLarge?.copyWith(
                        fontSize: 17,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

// class DebateItem {
//   final String title;
//   final String imageUrl;
//   final String date;
//   final String rankLabel;

//   DebateItem({
//     required this.title,
//     required this.imageUrl,
//     required this.date,
//     required this.rankLabel,
//   });
// }

// class LastDebatesSection extends StatelessWidget {
//   final List<DebateItem> debates = [
//     DebateItem(
//       title: 'AI vs Humanity Debate',
//       imageUrl:
//           'https://static.vecteezy.com/system/resources/thumbnails/006/406/394/small/debate-line-icon-on-white-vector.jpg',
//       date: '2025-06-20',
//       rankLabel: '1st Place',
//     ),
//     DebateItem(
//       title: 'Climate Change Round',
//       imageUrl:
//           'https://static.vecteezy.com/system/resources/thumbnails/006/406/394/small/debate-line-icon-on-white-vector.jpg',
//       date: '2025-06-15',
//       rankLabel: '2nd Place',
//     ),
//     DebateItem(
//       title: 'Education for Future',
//       imageUrl:
//           'https://static.vecteezy.com/system/resources/thumbnails/006/406/394/small/debate-line-icon-on-white-vector.jpg',
//       date: '2025-06-10',
//       rankLabel: '3rd Place',
//     ),
//   ];

//   LastDebatesSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Padding(
//           padding: EdgeInsets.symmetric(horizontal: 4.w),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Text(
//                 'Last 5 Debates',
//                 style: TextStyle(fontSize: 13.sp, fontWeight: FontWeight.bold),
//               ),
//               TextButton(
//                 onPressed: () {},
//                 child: Text(
//                   'Show More',
//                   style: TextStyle(
//                     color: Colors.black45,
//                     fontWeight: FontWeight.bold,
//                     fontSize: 10.sp,
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//         SizedBox(height: 1.5.h),
//         SizedBox(
//           height: 28.h,
//           child: ListView.builder(
//             scrollDirection: Axis.horizontal,
//             itemCount: debates.length,
//             itemBuilder: (context, index) {
//               final debate = debates[index];
//               return Container(
//                 width: 42.w,
//                 margin: EdgeInsets.only(left: 4.w),
//                 child: Card(
//                   shape: RoundedRectangleBorder(
//                     borderRadius: BorderRadius.circular(12),
//                   ),
//                   elevation: 3,
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Container(
//                         width: double.infinity,
//                         padding: EdgeInsets.symmetric(vertical: 0.8.h),
//                         decoration: const BoxDecoration(
//                           gradient: LinearGradient(
//                             colors: [Color(0xff8C3A3A), Color(0xff304F73)],
//                             begin: Alignment.topLeft,
//                             end: Alignment.bottomRight,
//                           ),
//                           borderRadius: BorderRadius.only(
//                             topLeft: Radius.circular(12),
//                             topRight: Radius.circular(12),
//                           ),
//                         ),
//                         child: Center(
//                           child: Text(
//                             debate.rankLabel,
//                             style: TextStyle(
//                               color: Colors.white,
//                               fontWeight: FontWeight.bold,
//                               fontSize: 9.sp,
//                             ),
//                           ),
//                         ),
//                       ),
//                       Image.network(
//                         debate.imageUrl,
//                         height: 12.h,
//                         width: double.infinity,
//                         fit: BoxFit.cover,
//                       ),
//                       SizedBox(height: 1.h),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 2.w),
//                         child: Text(
//                           debate.title,
//                           textAlign: TextAlign.center,
//                           style: TextStyle(
//                             fontWeight: FontWeight.w600,
//                             fontSize: 10.sp,
//                           ),
//                         ),
//                       ),
//                       SizedBox(height: 0.5.h),
//                       Padding(
//                         padding: EdgeInsets.symmetric(horizontal: 2.w),
//                         child: Text(
//                           debate.date,
//                           style: TextStyle(fontSize: 9.sp, color: Colors.grey),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               );
//             },
//           ),
//         ),
//       ],
//     );
//   }
// }
