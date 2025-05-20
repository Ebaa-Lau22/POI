import 'package:flutter_bloc/flutter_bloc.dart';
import 'states.dart';

class AppCubit extends Cubit<AppStates> {
  AppCubit() : super(InitialAppState()) {
    // selectedScreenIndex = AppLink.branchId == '0' ? 1 : 0;
    initialListScreen();
  }

  List screensConst = [];
  List screens = [];

  static AppCubit get(context) => BlocProvider.of(context);

  int selectedScreenIndex = 1;
  int lastScreen = 1;

  void updateSelected(int newScreenIndex) {
    if (newScreenIndex != screensConst.length - 1) {
      selectedScreenIndex = newScreenIndex;
      screens[selectedScreenIndex] = screensConst[selectedScreenIndex];
      emit(ScreenNavigationState());
      // lastScreen = newScreenIndex;
    }
    // else {
    //   screens[newScreenIndex] = screensConst[lastScreen];
    //   selectedScreenIndex = newScreenIndex;
    //   emit(ScreenNavigationState());
    // }
  }

  initialListScreen() {
    print('selectedScreenIndex $selectedScreenIndex');
    screens = [];
    screensConst = [];
  }
}
