import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:poi/core/app_cubit/app_states.dart';
import 'package:poi/di/injection_container.dart' as di;
import 'package:poi/features/Authentication/presentation/bloc/auth_cubit.dart';
import 'package:poi/features/Authentication/presentation/pages/Login_page.dart';
import 'package:poi/features/cached_data/domain/usecases/get_cached_locale_usecase.dart';
import 'package:poi/features/cached_data/domain/usecases/get_cached_theme_usecase.dart';
import 'package:poi/features/call/call_cubit.dart';
import 'package:poi/features/team_assignment/presentation/bloc/team_assignment_cubit.dart';
import 'package:poi/features/team_assignment/presentation/pages/team_assignment_screen.dart';
import 'package:poi/permission_cubit.dart';
import 'package:poi/splash_screen.dart';
import 'package:sizer/sizer.dart';
import 'core/app_cubit/app_cubit.dart';
import 'core/localization/l10n/generated/app_localizations.dart';
import 'core/theme/app_theme.dart';
import 'features/call/connection_cubit.dart';
import 'features/posts/presentation/bloc/posts_cubit.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await di.init();
  bool isLightTheme = true;
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
  String locale = "en";
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
        BlocProvider(create: (_) => di.sl<TeamAssignmentCubit>()),
        BlocProvider(create: (_) => di.sl<ConnectionCubit>()),
        BlocProvider(create: (_) => di.sl<AuthCubit>()),

      ],
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) {
          final cubit = context.read<AppCubit>();
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: cubit.isLightTheme ? lightTheme : darkTheme,
            title: 'Posts App',
            localizationsDelegates: const [
              AppLocalizations.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            supportedLocales: AppLocalizations.supportedLocales,
            locale: Locale(cubit.locale),
            home: LoginPage(),
          );
        },
      ),
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
