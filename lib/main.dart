import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_netflix/common/utils.dart';
import 'package:flutter_netflix/screens/splash_screen.dart';
import 'package:flutter_netflix/services/init_getit.dart';
import 'package:flutter_netflix/services/navigation_service.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  setupLocator(); // Initialize GetIt
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp, // Force portrait mode
  ]).then((_) async {
    await dotenv.load(fileName: "assets/.env");
    runApp(const ProviderScope(child: MainApp()));
  });
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: getIt<NavigationService>().navigatorKey,
      themeMode: ThemeMode.dark,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: kRedColor)
            .copyWith(surface: kBlackColor),
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: kWhiteColor,
            fontSize: 24,
          ),
          bodyMedium: TextStyle(
            color: kWhiteColor,
            fontSize: 20,
          ),
        ),
        fontFamily: GoogleFonts.ptSans().fontFamily,
      ),
      home: const SplashScreen(),
    );
  }
}
