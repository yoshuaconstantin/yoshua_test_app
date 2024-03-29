import 'package:another_flutter_splash_screen/another_flutter_splash_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yoshua_ui_test/module/cart_page/bloc/cart_page_bloc.dart';
import 'package:yoshua_ui_test/module/home_page/bloc/home_page_bloc.dart';
import 'package:yoshua_ui_test/module/home_page/home_page.dart';
import 'package:yoshua_ui_test/module/home_page/homepage_2.dart';
import 'package:yoshua_ui_test/module/login/bloc/login_bloc.dart';
import 'package:yoshua_ui_test/module/login/login_page.dart';
import 'package:yoshua_ui_test/module/search_page/bloc/search_page_bloc.dart';

import 'helper/constant.dart';
import 'helper/preferences.dart';
import 'module/splashscreen/splashscreen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.getInstance().init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LoginBloc()),
        BlocProvider(create: (context) => HomePageBloc()),
        BlocProvider(create: (context) => CartPageBloc()),
        BlocProvider(create: (context) => SearchPageBloc()),
      ],
      child: GlobalLoaderOverlay(
        useDefaultLoading: false,
        overlayWidget: const Center(
          child: SpinKitPianoWave(
              color: Colors.blue,
              size: 50
          ),
        ),
        overlayColor: Colors.black,
        overlayOpacity: 0.8,
        child: DismissableKeyboard(
          widget: MaterialApp(
            title: 'Test Demo',
            home: FlutterSplashScreen(
              backgroundColor: Colors.transparent,
              duration: const Duration(milliseconds: 1250),
              nextScreen: home(),
              splashScreenBody: const SplashScreen(),
            ),
          ),
        ),
      ),
    );
  }

  Widget home(){
    if (Preferences.getInstance().contain(SharedPreferenceKey.SESSION_ID)) {
      return const M7ExpampleScreen();
    } else {
      return const M7ExpampleScreen();
    }
  }

}




class DismissableKeyboard extends StatelessWidget {
  final Widget widget;

  const DismissableKeyboard({
    Key? key,
    required this.widget
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          FocusScopeNode focusScopeNode = FocusScope.of(context);

          if (!focusScopeNode.hasPrimaryFocus && focusScopeNode.focusedChild != null) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
        },
        child: widget
    );
  }
}
