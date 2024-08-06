import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:insta_clone/Resource/Auth_Methods.dart';
import 'package:insta_clone/Screens/login_Screen.dart';
import 'package:insta_clone/Screens/main_screen.dart';
import 'package:insta_clone/Widgets/custom_nav_bar.dart';
import 'package:insta_clone/Widgets/edit_image_widget.dart';
import 'package:insta_clone/Widgets/text_input_feilds.dart';
import 'package:insta_clone/utils/colors.dart';

import '../responsive/responsive_screen_layout.dart';
import '../responsive/web_screen_layout.dart';
import '../utils/utils.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  final TextEditingController _emailController =
      TextEditingController(text: "safyantariq4@gmail.com");
  final TextEditingController _passwordController =
      TextEditingController(text: "sunny123");
  final TextEditingController _bioController =
      TextEditingController(text: "Hey I am a podztar");
  final TextEditingController _inetesetsController =
      TextEditingController(text: "Coding, Art");
  final TextEditingController _firstNameController =
      TextEditingController(text: "Safyan");
  final TextEditingController _lastNameController =
      TextEditingController(text: "Tariq");
  final TextEditingController _spotifyController =
      TextEditingController(text: "www.myspotifylinnk.com");
  final TextEditingController _appleController =
      TextEditingController(text: "www.myApplelinnk.com");
  final TextEditingController _youtubeController =
      TextEditingController(text: "www.myYTlinnk.com");
  final TextEditingController _websiteController =
      TextEditingController(text: "www.safyan.com");
  final TextEditingController _usernameController =
      TextEditingController(text: "Sunny");
  final TextEditingController _genderCtrl = TextEditingController(text: "Male");
  Uint8List? _image;
  bool _isLoading = false;
  final AuthMethods _authMethods = AuthMethods();
  final PageController _pageController = PageController();
  int _selectedIndex = 0;

  void _onItemSelected(int index) {
    setState(() {
      _selectedIndex = index;
      _pageController.jumpToPage(index);
    });
  }

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
          builder: (context) => ResponsiveLayout(
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
    return Stack(
      children: [
        SafeArea(
          child: Scaffold(
            body: SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'assets/profilebg.png',
                      ),
                      fit: BoxFit.cover),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Icon(
                              Icons.arrow_back_outlined,
                              size: 30,
                            ),
                            Text(
                              "Edit Profile",
                              style: GoogleFonts.syne(
                                  fontWeight: FontWeight.bold, fontSize: 24),
                            ),
                            const SizedBox(
                              width: 30,
                            )
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                      ProfilePictureWithEditIcon(
                          imageUrl:
                              'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQWUem1ykMgZrm7P2GNRhID1fnipTWf1kQ1dA&s',
                          onEdit: () {}),
                      const SizedBox(
                        height: 40,
                      ),
                      TextInputFields(
                        textEditingController: _firstNameController,
                        hintText: "First Name",
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextInputFields(
                        textEditingController: _lastNameController,
                        hintText: "Last Name",
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextInputFields(
                        textEditingController: _usernameController,
                        hintText: "Username",
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextInputFields(
                        textEditingController: _emailController,
                        hintText: "Email",
                        textInputType: TextInputType.emailAddress,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextInputFields(
                        textEditingController: _bioController,
                        hintText: "Bio",
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextInputFields(
                        textEditingController: _inetesetsController,
                        hintText: "Interests",
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextInputFields(
                        textEditingController: _spotifyController,
                        hintText: "Spotify Link",
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextInputFields(
                        textEditingController: _youtubeController,
                        hintText: "Youtube Link",
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextInputFields(
                        textEditingController: _websiteController,
                        hintText: "Website Link",
                        textInputType: TextInputType.text,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextInputFields(
                        textEditingController: _genderCtrl,
                        hintText: 'Gender',
                        textInputType: TextInputType.text,
                        isGenderField: true,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      TextInputFields(
                        textEditingController: _passwordController,
                        hintText: "Password",
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
                                  "Save",
                                  style: GoogleFonts.syne(
                                    color: Colors.white,
                                    fontSize: 22,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      const Text(
                        "Cancel",
                        style: TextStyle(fontSize: 16),
                      ),
                      const SizedBox(
                        height: 50,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 0,
          right: 0,
          child: CustomNavBar(
            onItemSelected: _onItemSelected,
            selectedIndex: _selectedIndex,
          ),
        ),
      ],
    );
  }
}
