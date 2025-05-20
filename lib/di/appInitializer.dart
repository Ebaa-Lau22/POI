import 'package:flutter/material.dart';
import 'package:poi/routing/app_router.dart';
import '../features/posts/presentation/pages/temp_screen.dart';


abstract class AppInitializer {
  static Widget startScreen = const PostsScreen(); //TODO
  static bool isHaveAuth = false;
  static init() async {
    ///initialize EasyLocalization
    //await EasyLocalization.ensureInitialized();

    ///initialize routing
    AppRouter.init();

    //init

      isHaveAuth = true;
    }

    ///dependencies injection
    // await di.init();
}

