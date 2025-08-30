import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:poi/core/app_cubit/app_states.dart';
import 'package:poi/core/theme/app_colors.dart';
import 'package:poi/di/injection_container.dart' as di;
import 'package:poi/features/Authentication/presentation/bloc/auth_cubit.dart';
import 'package:poi/features/Authentication/presentation/bloc/logout_cubit.dart';
import 'package:poi/features/Authentication/presentation/pages/Login_page.dart';
import 'package:poi/features/Debates/presentation/bloc/debates_cubit.dart';
import 'package:poi/features/Debates/presentation/pages/add_feedback_page.dart';
import 'package:poi/features/Debates/presentation/pages/rating_page.dart';
import 'package:poi/features/Search/presentation/bloc/search_cubit.dart';
import 'package:poi/features/cached_data/domain/usecases/get_cached_locale_usecase.dart';
import 'package:poi/features/cached_data/domain/usecases/get_cached_theme_usecase.dart';
import 'package:poi/features/call/call_cubit.dart';
import 'package:poi/features/debate_setup/presentation/bloc/debate_setup_cubit.dart';
import 'package:poi/features/debate_setup/presentation/pages/motion_screen.dart';
import 'package:poi/features/debate_setup/presentation/pages/team_assignment_screen.dart';
import 'package:poi/features/notifications/core/push_notification_controller.dart';
import 'package:poi/firebase_options.dart';
import 'package:poi/home_page.dart';
import 'package:poi/permission_cubit.dart';
import 'package:sizer/sizer.dart';
import 'core/app_cubit/app_cubit.dart';
import 'core/localization/l10n/generated/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'features/call/connection_cubit.dart';
import 'features/posts/presentation/bloc/posts_cubit.dart';
import 'features/profiles/presentation/bloc/profile_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await di.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  PushNotificationController().init();
  bool isLightTheme = true;
  String locale = "en";
  GetCachedThemeUseCase getCachedThemeUseCase = di.sl();
  final themeOrFailure = await getCachedThemeUseCase();
  String theme = "Light";
  themeOrFailure.fold(
    (failure) {
      theme = "Light";
    },
    (th) {
      theme = th;
    },
  );
  GetCachedLocaleUseCase getCachedLocaleUseCase = di.sl();
  final localeOrFailure = await getCachedLocaleUseCase();
  localeOrFailure.fold(
    (failure) {
      locale = "en";
    },
    (lo) {
      locale = lo;
    },
  );

  if (theme == 'Dark') isLightTheme = false;

  runApp(MyApp(isLightTheme: isLightTheme, locale: locale));
}

class MyApp extends StatelessWidget {
  MyApp({super.key, required this.isLightTheme, required this.locale});
  bool isLightTheme;
  String locale;
  @override
  Widget build(BuildContext context) {
    return Sizer(
      builder: (context, orientation, deviceType) {
        return MultiBlocProvider(
          providers: [
            BlocProvider(
              create:
                  (_) =>
                      di.sl<AppCubit>()
                        ..changeTheme(isLightTheme)
                        ..changeLocale(locale),
            ),
            BlocProvider(create: (_) => di.sl<PostsCubit>()..getAllPosts()),
            BlocProvider(create: (_) => di.sl<CallCubit>()),
            BlocProvider(create: (_) => di.sl<PermissionCubit>()),
            BlocProvider(
              create:
                  (_) =>
                      di.sl<DebateSetupCubit>()
                        ..getAllTopics()
                        ..getAllMotions(),
            ),
            BlocProvider(create: (_) => di.sl<ConnectionCubit>()),
            BlocProvider(create: (_) => di.sl<AuthCubit>()),
            BlocProvider(create: (_) => di.sl<ProfileCubit>()),
            BlocProvider(create: (_) => di.sl<DebatesCubit>()),
            BlocProvider(create: (_) => di.sl<SearchCubit>()),
            BlocProvider(create: (_) => di.sl<LogoutCubit>()),
          ],
          child: BlocConsumer<AppCubit, AppStates>(
            listener: (context, state) {},
            builder: (context, state) {
              final cubit = context.read<AppCubit>();
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                theme: cubit.isLightTheme ? lightTheme : darkTheme,
                title: 'POI App',
                localizationsDelegates: const [
                  AppLocalizations.delegate,
                  GlobalMaterialLocalizations.delegate,
                  GlobalWidgetsLocalizations.delegate,
                  GlobalCupertinoLocalizations.delegate,
                ],
                supportedLocales: AppLocalizations.supportedLocales,
                locale: Locale(cubit.locale),
                home: GlobalLoaderOverlay(
                  useDefaultLoading: false,
                  overlayWidgetBuilder:
                      (context) => Center(
                        child: LoadingAnimationWidget.discreteCircle(
                          color: AppColors.darkBlue,
                          secondRingColor: AppColors.darkRed,
                          thirdRingColor: AppColors.mainLight,
                          size: 35,
                        ),
                      ),
                  child: LoginPage(),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

/*MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: cubit.isLightTheme ? lightTheme : darkTheme,
            title: 'Posts App',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales:  AppLocalizations.supportedLocales,
            locale: Locale(cubit.locale),
            home: SplashScreen(),
          ); */
