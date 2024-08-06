import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class ExpertSelectionScreen extends StatefulWidget {
  const ExpertSelectionScreen({Key? key}) : super(key: key);

  @override
  State<ExpertSelectionScreen> createState() => _ExpertSelectionScreenState();
}

class _ExpertSelectionScreenState extends State<ExpertSelectionScreen> {
  final List<String> categories = [
    'Art',
    'Music',
    'Design',
    'Business',
    'Literature',
    'Fitness & Health',
    'Movies & TV',
    'Sports',
    'Nerds',
    'News',
    'Travel',
    'Food & Cooking',
    'Religion & Spirituality'
  ];
  final List<String> selectedCategories = [
    'Music',
    'Fitness & Health',
    'Religion & Spirituality'
  ];
  bool isGuestSelected = true;

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      const SystemUiOverlayStyle(
        systemNavigationBarColor: Colors.black,
        statusBarColor: Color.fromRGBO(0, 0, 0, 0.50),
        systemNavigationBarIconBrightness: Brightness.light,
      ),
    );
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/profilebg.png'), // Your background image
            fit: BoxFit.cover,
          ),
        ),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 24),
                Text(
                  "Let's get to know you!",
                  maxLines: 2,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.syne(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 25),
                Text(
                  'Help us tailor your experience by telling us about yourself.',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.syne(
                    fontSize: 18,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 38),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildChoiceButton('I\'m a Guest',
                        isSelected: isGuestSelected),
                    const SizedBox(width: 16),
                    _buildChoiceButton('I\'m a Host',
                        isSelected: !isGuestSelected),
                  ],
                ),
                const SizedBox(height: 32),
                Text(
                  "I'm an expert in:",
                  style: GoogleFonts.syne(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'You can change these any time.',
                  style: GoogleFonts.syne(
                    fontSize: 18,
                    color: Colors.white70,
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: SingleChildScrollView(
                    child: Wrap(
                      alignment: WrapAlignment.center,
                      spacing: 10.0,
                      runSpacing: 10.0,
                      children: categories.map((category) {
                        bool isSelected = selectedCategories.contains(category);
                        return GestureDetector(
                          onTap: () {
                            setState(() {
                              if (isSelected) {
                                selectedCategories.remove(category);
                              } else {
                                selectedCategories.add(category);
                              }
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 10),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? Colors.white
                                  : Colors.white.withOpacity(0.15),
                              borderRadius: BorderRadius.circular(25),
                              // image: isSelected
                              //     ? DecorationImage(
                              //         image: AssetImage('assets/buttonbg.png'),
                              //         fit: BoxFit.cover,
                              //       )
                              //     : null,
                            ),
                            child: Text(
                              category,
                              style: GoogleFonts.inter(
                                color: isSelected ? Colors.black : Colors.white,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                ElevatedButton(
                  onPressed: () {
                    // Handle save action
                  },
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 14.0),
                    backgroundColor: Colors.transparent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                  ),
                  child: Ink(
                    decoration: BoxDecoration(
                      image: const DecorationImage(
                        image: AssetImage(
                            'assets/buttonbg.png'), // Your button background image
                        fit: BoxFit.cover,
                      ),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    child: Container(
                      alignment: Alignment.center,
                      height: 58,
                      width: double.infinity,
                      child: Text(
                        'Save',
                        style:
                            GoogleFonts.syne(color: Colors.white, fontSize: 22),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildChoiceButton(String text, {required bool isSelected}) {
    return GestureDetector(
      onTap: () {
        setState(() {
          isGuestSelected = text == 'I\'m a Guest';
        });
      },
      child: Container(
        height: 50,
        width: MediaQuery.of(context).size.width * 0.42,
        // padding: EdgeInsets.symmetric(horizontal: 20),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          image: isSelected
              ? const DecorationImage(
                  image: AssetImage(
                      'assets/buttonbg.png'), // Your selected button background image
                  fit: BoxFit.cover,
                )
              : null,
          color: isSelected ? null : Colors.white.withOpacity(0.15),
        ),
        child: Center(
          child: Text(
            text,
            style: GoogleFonts.inter(
              color: Colors.white,
              fontSize: 22,
            ),
          ),
        ),
      ),
    );
  }
}
