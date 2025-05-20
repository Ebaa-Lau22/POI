import 'package:bloc/bloc.dart';
import 'package:poi/core/app_cubit/app_states.dart';
import 'package:poi/features/cached_data/domain/usecases/cache_locale_use_case.dart';
import 'package:poi/features/cached_data/domain/usecases/cache_theme_use_case.dart';
import '../theme/app_colors.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit({
    required this.cacheLocaleUseCase,
    required this.cacheThemeUseCase,
}) : super(AppInitialState());

  CacheLocaleUseCase cacheLocaleUseCase;
  CacheThemeUseCase cacheThemeUseCase;

  bool isLightTheme = true;
  void changeTheme(bool newTheme) async{
    isLightTheme = newTheme;
    await cacheThemeUseCase(theme: isLightTheme ? "Light" : "Dark");
    ThemedColors(isLightTheme);
    emit(AppChangeThemeState());
  }

  String locale = "en";
  void changeLocale(String newLocale) async{
    locale = newLocale;
    await cacheLocaleUseCase(locale: locale);
    emit(AppChangeLocaleState());
  }
}