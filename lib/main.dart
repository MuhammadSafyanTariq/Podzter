import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_clone/Provider/user_provider.dart';
import 'package:insta_clone/Screens/interest_selection_screen.dart';
import 'package:insta_clone/Screens/main_screen.dart';
import 'package:insta_clone/Screens/sign_up_screen.dart';
import 'package:insta_clone/responsive/responsive_screen_layout.dart';
import 'package:insta_clone/responsive/web_screen_layout.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // initialise app based on platform- web or mobile
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCZ-xrXqD5D19Snauto-Fx_nLD7PLrBXGM",
          appId: "1:585119731880:web:eca6e4b3c42a755cee329d",
          messagingSenderId: "585119731880",
          projectId: "instagram-clone-4cea4",
          storageBucket: 'instagram-clone-4cea4.appspot.com'),
    );
  } else {
    await Firebase.initializeApp();
  }
  // SystemChrome.setSystemUIOverlayStyle(
  //   const SystemUiOverlayStyle(
  //     systemNavigationBarColor: Color(0xFF0d0521),
  //     statusBarColor: Colors.transparent,
  //     // statusBarColor: Color(0xFF0d0521),
  //     systemNavigationBarIconBrightness: Brightness.light,
  //   ),
  // );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => UserProvider(),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Instagram Clone',
        theme: ThemeData.dark().copyWith(
          scaffoldBackgroundColor: mobileBackgroundColor,
          textTheme: GoogleFonts.interTextTheme(
            Theme.of(context).textTheme.apply(bodyColor: Colors.white),
          ).copyWith(
            displayLarge: GoogleFonts.syne(color: Colors.white),
            displayMedium: GoogleFonts.syne(color: Colors.white),
            displaySmall: GoogleFonts.syne(color: Colors.white),
            headlineLarge: GoogleFonts.syne(color: Colors.white),
            headlineMedium: GoogleFonts.syne(color: Colors.white),
            headlineSmall: GoogleFonts.syne(color: Colors.white),
            titleLarge: GoogleFonts.syne(color: Colors.white),
            titleMedium: GoogleFonts.syne(color: Colors.white),
          ),
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.active) {
              if (snapshot.hasData) {
                return AnimatedSplashScreen(
                  duration: 1000,
                  splashIconSize: 300,
                  splash: const Image(
                    image: AssetImage(
                      'assets/Bunny.png',
                    ),
                  ),
                  splashTransition: SplashTransition.slideTransition,
                  backgroundColor: mobileBackgroundColor,
                  nextScreen: ResponsiveLayout(
                    mobileScreenLayout: MainScreen(),
                    webScreenLayout: const WebScreenLayout(),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }

            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            return AnimatedSplashScreen(
              duration: 1000,
              splashIconSize: 250,
              splash: const Image(
                image: AssetImage(
                  'assets/Bunny.png',
                ),
              ),
              splashTransition: SplashTransition.slideTransition,
              backgroundColor: mobileBackgroundColor,
              nextScreen: const ExpertSelectionScreen(),
            );
          },
        ),
      ),
    );
  }
}
