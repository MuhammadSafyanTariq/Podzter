import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_clone/Resource/Auth_Methods.dart';
import 'package:insta_clone/Screens/main_screen.dart';
import 'package:insta_clone/Screens/sign_up_screen.dart';
import 'package:insta_clone/Widgets/text_input_feilds.dart';
import 'package:insta_clone/utils/colors.dart';
import 'package:insta_clone/utils/utils.dart';
import '../responsive/mobile_screen_layout.dart';
import '../responsive/responsive_screen_layout.dart';
import '../responsive/web_screen_layout.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  final AuthMethods _authMethods = AuthMethods();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
  }

  void LoginUser() async {
    setState(() {
      _isLoading = true;
    });
    String res = await _authMethods.loginUser(
        email: _emailController.text, password: _passwordController.text);
    setState(() {
      _isLoading = false;
    });
    if (res == "success") {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => ResponsiveLayout(
              webScreenLayout: WebScreenLayout(),
              mobileScreenLayout: MainScreen()),
        ),
      );
    } else {
      showSnackBar(res, context);
    }
  }

  void goTOSignUpScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const SignUpScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
   SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        statusBarColor: Color.fromRGBO(0, 0, 0, 0.50),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      body: Container(
        height: height,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/profilebg.png'),
            fit: BoxFit.cover,
          ),
        ),
        padding: EdgeInsets.symmetric(horizontal: width > 600 ? 100 : 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: height * 0.15),
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Hello,\nWelcome Back!",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.syne(
                    fontWeight: FontWeight.bold,
                    fontSize: width > 600 ? 50 : 40,
                    color: Colors.white,
                  ),
                ),
              ),
              SizedBox(height: height * 0.08),
              TextInputFields(
                textEditingController: _emailController,
                hintText: "Enter User Name",
                textInputType: TextInputType.emailAddress,
              ),
              SizedBox(height: height * 0.03),
              TextInputFields(
                textEditingController: _passwordController,
                hintText: "Enter Password",
                isPass: true,
                textInputType: TextInputType.visiblePassword,
              ),
              SizedBox(height: height * 0.01),
              Align(
                alignment: Alignment.centerRight,
                child: Text(
                  "Forgot Password?",
                  style: GoogleFonts.syne(
                    fontWeight: FontWeight.w400,
                    fontSize: 14,
                    color: Colors.white70,
                  ),
                ),
              ),
              SizedBox(height: height * 0.05),
              InkWell(
                onTap: LoginUser,
                child: Container(
                  width: double.infinity,
                  height: 58,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: const DecorationImage(
                      image: AssetImage('assets/buttonbg.png'),
                      fit: BoxFit.cover,
                    ),
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: Colors.white,
                          ),
                        )
                      : Text(
                          "Log In",
                          style: GoogleFonts.syne(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                ),
              ),
              SizedBox(height: height * 0.05),
              const Row(
                children: <Widget>[
                  Expanded(
                    child: Divider(
                      color: Colors.white54,
                      thickness: 0.5,
                    ),
                  ),
                  Text(
                    " or continue with ",
                    style: TextStyle(
                      color: Colors.white54,
                      fontSize: 14,
                    ),
                  ),
                  Expanded(
                    child: Divider(
                      color: Colors.white54,
                      thickness: 0.5,
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(right: 20),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Image.asset(
                        'assets/icons/facebook.png',
                        height: 14,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    margin: const EdgeInsets.only(right: 20),
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Image.asset(
                        'assets/icons/apple.png',
                        height: 14,
                      ),
                      onPressed: () {},
                    ),
                  ),
                  Container(
                    height: 40,
                    width: 40,
                    decoration: const BoxDecoration(
                      color: Color.fromRGBO(255, 255, 255, 0.15),
                      shape: BoxShape.circle,
                    ),
                    child: IconButton(
                      icon: Image.asset(
                        'assets/icons/google.png',
                        height: 14,
                      ),
                      onPressed: () {},
                    ),
                  ),
                ],
              ),
              SizedBox(height: height * 0.04),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    "Create New Account? ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  GestureDetector(
                    onTap: goTOSignUpScreen,
                    child: Text(
                      "Sign Up",
                      style: TextStyle(
                        color: textColor,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                        decorationColor: textColor,
                        fontSize: 14,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
