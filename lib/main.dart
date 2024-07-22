import 'package:animated_splash_screen/animated_splash_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:insta_clone/Provider/user_provider.dart';
import 'package:insta_clone/Screens/login_Screen.dart';
import 'package:insta_clone/Screens/sign_up_screen.dart';
import 'package:insta_clone/Screens/welcome_screen.dart';
import 'package:insta_clone/responsive/mobile_screen_layout.dart';
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
  SystemChrome.setSystemUIOverlayStyle(
    SystemUiOverlayStyle(
      systemNavigationBarColor: Colors.black,
      statusBarColor: Colors.blue.shade900,
      systemNavigationBarIconBrightness: Brightness.light,
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // SystemChrome.setSystemUIOverlayStyle(
    //   SystemUiOverlayStyle(
    //     systemNavigationBarColor: Colors.black,
    //     systemNavigationBarIconBrightness: Brightness.light,
    //   ),
    // );
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
        ),
        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context, snapshot) {
            //FirebaseAuth.instance.signOut();
            if (snapshot.connectionState == ConnectionState.active) {
              // Checking if the snapshot has any data or not
              if (snapshot.hasData) {
                // if snapshot has data which means user is logged in then we check the width of screen and accordingly display the screen layout
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
                  nextScreen: const ResponsiveLayout(
                    mobileScreenLayout: MobileScreenLayout(),
                    webScreenLayout: WebScreenLayout(),
                  ),
                );
              } else if (snapshot.hasError) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              }
            }

            // means connection to future hasnt been made yet
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
              nextScreen: SignUpScreen(),
              // nextScreen: WelcomeScreen(),
            );
          },
        ),
      ),
    );
  }
}
