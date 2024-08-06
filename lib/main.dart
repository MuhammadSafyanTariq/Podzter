import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_clone/Provider/user_provider.dart';
import 'package:insta_clone/Resource/Auth_Methods.dart';
import 'package:insta_clone/Screens/login_Screen.dart';
import 'package:insta_clone/Screens/main_screen.dart';
import 'package:insta_clone/Screens/welcome_screen.dart';
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
        home: const WelcomeScreen(),
      ),
    );
  }
}
