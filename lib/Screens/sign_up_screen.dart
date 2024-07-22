import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/Resource/Auth_Methods.dart';
import 'package:insta_clone/Screens/login_Screen.dart';
import 'package:insta_clone/Widgets/text_input_feilds.dart';
import 'package:insta_clone/utils/colors.dart';

import '../responsive/mobile_screen_layout.dart';
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
          builder: (context) => const ResponsiveLayout(
              webScreenLayout: WebScreenLayout(),
              mobileScreenLayout: MobileScreenLayout()),
        ),
      );
    }
    return res;
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
            ),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.blue.shade900, Colors.black],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
              ),
            ),
            width: double.infinity,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Image(
                  image: AssetImage(
                    'assets/logo.png',
                  ),
                  height: 150,
                ),

                InkWell(
                  onTap: () {
                    selectImage();
                  },
                  child: Stack(
                    children: [
                      _image != null
                          ? CircleAvatar(
                              radius: 100,
                              backgroundImage: MemoryImage(_image!),
                            )
                          : Container(
                              decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(color: Colors.white)),
                              child: const CircleAvatar(
                                backgroundColor: Colors.transparent,
                                radius: 50,
                                child: Icon(
                                  Icons.camera_alt_outlined,
                                  color: Colors.white,
                                  size: 60,
                                ),
                                // backgroundImage: AssetImage(
                                //   'assets/logo.png',
                                // ),
                              ),
                            ),
                    ],
                  ),
                ),
                // TextButton(
                //   onPressed: () {
                //     selectImage();
                //   },
                //   child: const Text("Add an Image"),
                // ),
                const SizedBox(
                  height: 50,
                ),
                TextInputFeilds(
                  textEditingController: _usernameController,
                  hintText: "Please enter the Username",
                  textInputType: TextInputType.text,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextInputFeilds(
                  textEditingController: _emailController,
                  hintText: "Please enter the email",
                  textInputType: TextInputType.emailAddress,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextInputFeilds(
                  textEditingController: _passwordController,
                  hintText: "Please enter the password",
                  isPass: true,
                  textInputType: TextInputType.visiblePassword,
                ),
                const SizedBox(
                  height: 20,
                ),
                TextInputFeilds(
                  textEditingController: _bioController,
                  hintText: "Please enter the Bio",
                  textInputType: TextInputType.text,
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
                    width: 200,
                    height: 50,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 12),
                    decoration: const ShapeDecoration(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(
                          Radius.circular(30),
                        ),
                      ),
                      color: Color.fromRGBO(13, 71, 161, 1),
                    ),
                    child: _isLoading
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: primaryColor,
                            ),
                          )
                        : const Text(
                            "Sign up",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold),
                          ),
                  ),
                ),
                SizedBox(
                  height: screenHeight * 0.05,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: const Text("Already have an acount? "),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                      ),
                      child: GestureDetector(
                        onTap: goToLoginScreen,
                        child: const Text(
                          "Sign in",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
