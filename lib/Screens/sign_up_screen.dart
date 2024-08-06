import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/Resource/Auth_Methods.dart';
import 'package:insta_clone/Screens/login_Screen.dart';
import 'package:insta_clone/Screens/main_screen.dart';
import 'package:insta_clone/Widgets/text_input_feilds.dart';
import 'package:insta_clone/utils/colors.dart';

import '../responsive/responsive_screen_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/utils.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _usernameController = TextEditingController();
  Uint8List? _image;
  bool _isLoading = false;
  final AuthMethods _authMethods = AuthMethods();

  @override
  void dispose() {
    super.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _bioController.dispose();
    _usernameController.dispose();
  }

  void selectImage() async {
    Uint8List im = await pickImage(ImageSource.gallery);
    setState(() {
      _image = im;
    });
  }

  void goToLoginScreen() {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => const LoginScreen(),
      ),
    );
  }

  Future<String> SignUpUser() async {
    String res = '';
    setState(() {
      _isLoading = true;
    });
    if (_image != null) {
      res = await _authMethods.signUpUser(
        email: _emailController.text,
        password: _passwordController.text,
        username: _usernameController.text,
        bio: _bioController.text,
        file: _image!,
      );
    } else if (_image == null) {
      showSnackBar('Please insert an image', context);
    }
    setState(() {
      _isLoading = false;
    });
    if (res != 'success') {
      showSnackBar(res, context);
    } else {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) =>  ResponsiveLayout(
              webScreenLayout: const WebScreenLayout(),
              mobileScreenLayout: MainScreen()),
        ),
      );
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
   SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        statusBarColor: Color.fromRGBO(0, 0, 0, 0.50),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      body: SingleChildScrollView(
        child: Container(
          // height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/profilebg.png',
                ),
                fit: BoxFit.cover),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(
                height: 90,
              ),
              const Image(
                image: AssetImage(
                  'assets/logo.png',
                ),
                height: 56,
              ),

              // InkWell(
              //   onTap: () {
              //     selectImage();
              //   },
              //   child: Stack(
              //     children: [
              //       _image != null
              //           ? CircleAvatar(
              //               radius: 100,
              //               backgroundImage: MemoryImage(_image!),
              //             )
              //           : Container(
              //               decoration: BoxDecoration(
              //                   shape: BoxShape.circle,
              //                   border: Border.all(color: Colors.white)),
              //               child: const CircleAvatar(
              //                 backgroundColor: Colors.transparent,
              //                 radius: 50,
              //                 child: Icon(
              //                   Icons.camera_alt_outlined,
              //                   color: Colors.white,
              //                   size: 60,
              //                 ),
              //                 // backgroundImage: AssetImage(
              //                 //   'assets/logo.png',
              //                 // ),
              //               ),
              //             ),
              //     ],
              //   ),
              // ),
              // TextButton(
              //   onPressed: () {
              //     selectImage();
              //   },
              //   child: const Text("Add an Image"),
              // ),
              const SizedBox(
                height: 100,
              ),
              TextInputFields(
                textEditingController: _usernameController,
                hintText: "Enter the Username",
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),
              TextInputFields(
                textEditingController: _emailController,
                hintText: "Enter the email",
                textInputType: TextInputType.emailAddress,
              ),

              const SizedBox(
                height: 20,
              ),
              TextInputFields(
                textEditingController: _bioController,
                hintText: "Enter the Bio",
                textInputType: TextInputType.text,
              ),
              const SizedBox(
                height: 20,
              ),
              TextInputFields(
                textEditingController: _passwordController,
                hintText: "Enter Password",
                isPass: true,
                textInputType: TextInputType.visiblePassword,
              ),
              const SizedBox(
                height: 20,
              ),
              TextInputFields(
                textEditingController: _passwordController,
                hintText: "Enter confirm Password",
                isPass: true,
                textInputType: TextInputType.visiblePassword,
              ),
              const SizedBox(
                height: 50,
              ),
              InkWell(
                onTap: () {
                  SignUpUser;
                  showSnackBar(SignUpUser().toString(), context);
                },
                child: Container(
                  width: double.infinity,
                  height: 58,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30),
                    image: const DecorationImage(
                        image: AssetImage(
                          'assets/buttonbg.png',
                        ),
                        fit: BoxFit.cover),
                  ),
                  child: _isLoading
                      ? const Center(
                          child: CircularProgressIndicator(
                            color: primaryColor,
                          ),
                        )
                      : Text(
                          "Join Podzter",
                          style: GoogleFonts.syne(
                            color: Colors.white,
                            fontSize: 22,
                          ),
                        ),
                ),
              ),
              const SizedBox(
                height: 58,
              ),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: "By Creating Account I Accept App's ",
                  style: const TextStyle(color: Color(0xFF85808E), fontSize: 16),
                  children: [
                    TextSpan(
                      text: "Terms And Condition",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => Container()),
                          );
                        },
                    ),
                    const TextSpan(
                      text: " With ",
                      style: TextStyle(color: Color(0xFF85808E)),
                    ),
                    TextSpan(
                      text: "Privacy Policy.",
                      style: const TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.of(context).push(
                            MaterialPageRoute(
                                builder: (context) => Container()),
                          );
                        },
                    ),
                  ],
                ),
              ),
              const Padding(
                padding:
                    EdgeInsets.symmetric(horizontal: 24.0, vertical: 15),
                child: Divider(
                  color: Colors.white54,
                  thickness: 0.5,
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: const Text(
                      "Already have an acount? ",
                      style: TextStyle(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                    ),
                    child: GestureDetector(
                      onTap: goToLoginScreen,
                      child: Text(
                        "Sign in",
                        style: TextStyle(
                          color: textColor,
                          fontWeight: FontWeight.bold,
                          decoration: TextDecoration.underline,
                          decorationColor: textColor,
                          fontSize: 16,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(
                height: 50,
              )
            ],
          ),
        ),
      ),
    );
  }
}
