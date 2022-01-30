import 'package:firebase_core/firebase_core.dart';
import 'package:flash_chat/app/screens/add_employee.dart';
import 'package:flash_chat/app/screens/all_employees_screen.dart';
import 'package:flash_chat/app/screens/login_screen.dart';
import 'package:flash_chat/app/screens/registration_screen.dart';
import 'package:flash_chat/app/screens/welcome_screen.dart';
import 'package:flash_chat/theme/app_theme_state.dart';
import 'package:flash_chat/theme/theme_constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import 'widgets/auth_widget.dart';

final appThemeStateNotifier = ChangeNotifierProvider((ref) => AppThemeState());

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
    statusBarColor: Themes.darkTheme.scaffoldBackgroundColor,
  ));
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitDown,
    DeviceOrientation.portraitUp,
  ]);
  // final sharedPreferences = await SharedPreferences.getInstance();
  runApp(ProviderScope(
    // overrides: [
    //   sharedPreferencesServiceProvider.overrideWithValue(
    //     SharedPreferencesService(sharedPreferences),
    //   ),
    // ],
    child: const MyApp(),
  ));
}

class MyApp extends ConsumerWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      routes: {
        WelcomeScreen.id: (context) => WelcomeScreen(),
        LoginScreen.id: (context) => LoginScreen(),
        RegistrationScreen.id: (context) => RegistrationScreen(),
        AllScreen.id: (context) => AllScreen(),
        AddEmployeeScreen.id: (context) => AddEmployeeScreen(),
      },
      home: AuthWidget(
        nonSignedInBuilder: (context) => WelcomeScreen(),
        signedInBuilder: (context) => AllScreen(),
      ),
    );
  }
}
