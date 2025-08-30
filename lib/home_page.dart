import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar/persistent_bottom_nav_bar.dart';
import 'package:poi/core/app_cubit/state_builder.dart';
import 'package:poi/core/app_cubit/state_cubit.dart';
import 'package:poi/core/theme/app_colors.dart';
import 'package:poi/di/injection_container.dart';
import 'package:poi/features/Debates/presentation/pages/debates_page.dart';
import 'package:poi/features/Search/presentation/pages/search_page.dart';
import 'package:poi/features/call/call_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    List<Widget> _buildScreens() {
      return [DebatesPage(), SearchPage(), Screen3(), VideoCallScreen()];
    }

    List<PersistentBottomNavBarItem> _navBarsItems() {
      return [
        PersistentBottomNavBarItem(
          icon: Icon(Icons.home_rounded),
          title: ("Debates"),
          activeColorPrimary: AppColors.darkBlue,
          inactiveColorPrimary: Colors.grey[400],
        ),

        PersistentBottomNavBarItem(
          icon: Icon(Icons.favorite_rounded),
          title: ("Search"),
          activeColorPrimary: AppColors.darkBlue,
          inactiveColorPrimary: Colors.grey[400],
        ),

        PersistentBottomNavBarItem(
          icon: Icon(Icons.notifications_rounded),
          title: ("Blogs"),
          activeColorPrimary: AppColors.darkBlue,
          inactiveColorPrimary: Colors.grey[400],
        ),

        PersistentBottomNavBarItem(
          icon: Icon(Icons.lightbulb_sharp),
          title: ("theme"),
          activeColorPrimary: AppColors.darkBlue,
          inactiveColorPrimary: Colors.grey[400],
        ),
      ];
    }

    PersistentTabController _controller;

    _controller = PersistentTabController(initialIndex: 0);

    return PersistentTabView(
      context,
      controller: _controller,
      screens: _buildScreens(),
      items: _navBarsItems(),
      handleAndroidBackButtonPress: true,
      resizeToAvoidBottomInset: true,
      stateManagement: true,
      hideNavigationBarWhenKeyboardAppears: true,

      // popBehaviorOnSelectedNavBarItemPress: PopBehavior.none,
      padding: const EdgeInsets.only(top: 8),
      backgroundColor: Color.fromRGBO(234, 237, 243, 1),
      isVisible: true,
      animationSettings: const NavBarAnimationSettings(
        navBarItemAnimation: ItemAnimationSettings(
          duration: Duration(milliseconds: 400),
          curve: Curves.ease,
        ),
        screenTransitionAnimation: ScreenTransitionAnimationSettings(
          animateTabTransition: true,
          duration: Duration(milliseconds: 100),
          screenTransitionAnimationType: ScreenTransitionAnimationType.slide,
        ),
      ),
      confineToSafeArea: true,
      navBarHeight: 60,
      decoration: NavBarDecoration(
        colorBehindNavBar: Colors.white,
        // borderRadius: BorderRadius.only(
        //   topLeft: Radius.circular(25),
        //   topRight: Radius.circular(25),
        // ),
      ),
      navBarStyle:
          NavBarStyle.style12, // Choose the nav bar style with this property
    );
  }
}

class Screen3 extends StatelessWidget {
  const Screen3({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: Text('screen3', style: TextStyle(fontSize: 30))),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:poi/core/app_cubit/app_cubit.dart';
// import 'package:poi/core/app_cubit/app_states.dart';
// import 'package:poi/core/theme/app_colors.dart';
// import 'package:poi/features/Debates/presentation/pages/debates_page.dart';
// import 'package:poi/features/Search/presentation/pages/search_page.dart';
// import 'package:poi/features/call/call_screen.dart';
// import 'package:poi/features/profiles/profile_page.dart';

// class HomePage extends StatefulWidget {
//   const HomePage({super.key});

//   @override
//   State<HomePage> createState() => _HomePageState();
// }

// class _HomePageState extends State<HomePage> {
//   int selectedIndex = 0;

//   final List<Widget> pages = [
//     Center(
//       child: Text(
//         'Home Page',
//         style: TextStyle(fontFamily: "Sansation", fontSize: 30),
//       ),
//     ),
//     DebatesPage(),
//     VideoCallScreen(),
//     SearchPage(),
//     // ProfilePage(),
//   ];

//   final List<IconData> icons = [
//     Icons.home_rounded,
//     Icons.forum_rounded,
//     Icons.favorite_rounded,
//     Icons.person_rounded,
//   ];

//   final List<String> labels = ['Home', 'Debates', 'Favorites', 'Profile'];

//   @override
//   Widget build(BuildContext context) {
//     return BlocConsumer<AppCubit, AppStates>(
//       listener: (context, state) {},
//       builder: (context, state) {
//         final appCubit = context.read<AppCubit>();
//         final color = ThemedColors(appCubit.isLightTheme);
//         final textStyle = Theme.of(context).textTheme;
//         return Scaffold(
//           // appBar: AppBar(backgroundColor: Color.fromRGBO(234, 237, 243, 1)),
//           // drawer: DrawerCode(),
//           backgroundColor: AppColors.light,
//           extendBody: true,
//           body: Stack(
//             children: [
//               pages[selectedIndex],
//               Align(
//                 alignment: Alignment.bottomCenter,
//                 child: Padding(
//                   padding: const EdgeInsets.only(bottom: 70.0),
//                   child: AnimatedContainer(
//                     duration: Duration(milliseconds: 300),
//                     padding: EdgeInsets.symmetric(horizontal: 20),
//                     height: 60,
//                     margin: EdgeInsets.symmetric(horizontal: 30),
//                     decoration: BoxDecoration(
//                       color: AppColors.mainLight,
//                       borderRadius: BorderRadius.circular(30),
//                       boxShadow: [
//                         BoxShadow(
//                           color: AppColors.darkBlue,
//                           blurRadius: 10,
//                           spreadRadius: 1,
//                         ),
//                       ],
//                     ),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.spaceAround,
//                       children: List.generate(icons.length, (index) {
//                         final isSelected = selectedIndex == index;
//                         return GestureDetector(
//                           onTap: () {
//                             setState(() {
//                               selectedIndex = index;
//                             });
//                           },
//                           child: AnimatedContainer(
//                             duration: Duration(milliseconds: 300),
//                             padding: EdgeInsets.symmetric(
//                               horizontal: isSelected ? 16 : 0,
//                             ),
//                             decoration: BoxDecoration(
//                               color:
//                                   isSelected
//                                       ? AppColors.lightBlue.withOpacity(0.5)
//                                       : Colors.transparent,
//                               borderRadius: BorderRadius.circular(20),
//                             ),
//                             child: Row(
//                               children: [
//                                 Icon(
//                                   icons[index],
//                                   color:
//                                       isSelected
//                                           ? AppColors.darkBlue
//                                           : Colors.grey[400],
//                                   size: 25,
//                                 ),
//                                 if (isSelected) SizedBox(width: 8),
//                                 if (isSelected)
//                                   Text(
//                                     labels[index],
//                                     style: TextStyle(
//                                       color: AppColors.darkBlue,
//                                       fontWeight: FontWeight.bold,
//                                       fontSize: 17,
//                                       fontFamily: "Sansation",
//                                     ),
//                                   ),
//                               ],
//                             ),
//                           ),
//                         );
//                       }),
//                     ),
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         );
//       },
//     );
//   }
// }
