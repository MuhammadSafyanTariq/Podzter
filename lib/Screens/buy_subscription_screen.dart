import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:insta_clone/Widgets/icon_widget.dart';

class MembershipScreen extends StatefulWidget {
  const MembershipScreen({super.key});

  @override
  _MembershipScreenState createState() => _MembershipScreenState();
}

class _MembershipScreenState extends State<MembershipScreen> {
  String _selectedMembership = "Free With Ads";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/Mshipbg.png'),
            fit: BoxFit.cover,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.06),
                IconWidget(
                  assetPath: 'membership',
                  size: 140,
                ),
                SizedBox(height: MediaQuery.of(context).size.height * 0.02),
                Text(
                  'Choose Your Membership',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.syne(
                    color: Colors.white,
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                const Text(
                  'Premium members enjoy a completely ad-free experience',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white70,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(height: 30),
                _buildMembershipOption(
                  'Annual',
                  ' \$23.99 per year',
                  ' \$1.99 / Mo',
                ),
                const SizedBox(height: 20),
                _buildMembershipOption(
                  'Monthly',
                  ' \$23.99 per year',
                  null,
                ),
                const SizedBox(height: 20),
                _buildMembershipOption(
                  'Free With Ads',
                  'Enjoy all essential features, with ads.',
                  null,
                ),
                const SizedBox(height: 40),
                InkWell(
                  onTap: () {},
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
                    child: Text(
                      "Continue",
                      style: GoogleFonts.syne(
                        color: Colors.white,
                        fontSize: 22,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  'Renews automatically, Cancel anytime.',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildMembershipOption(String title, String subtitle, String? badge) {
    return Stack(
      children: [
        GestureDetector(
          onTap: () {
            setState(() {
              _selectedMembership = title;
            });
          },
          child: Container(
            margin: badge.toString().length > 6
                ? EdgeInsets.fromLTRB(0, 14, 0, 2.5)
                : EdgeInsets.symmetric(vertical: 2.5),
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: _selectedMembership == title
                  ? const Color(0xFF6A00F4).withOpacity(0.2)
                  : Colors.white.withOpacity(0.25),
              border: Border.all(
                color: _selectedMembership == title
                    ? const Color(0xFF6A00F4)
                    : Colors.white.withOpacity(0.25),
              ),
              borderRadius: BorderRadius.circular(30),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                if (_selectedMembership == title)
                  Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      image: const DecorationImage(
                          image: AssetImage(
                            'assets/buttonbg.png',
                          ),
                          fit: BoxFit.cover),
                    ),
                    child: const Icon(
                      Icons.check,
                      size: 18,
                      // color: Color(0xFF6A00F4),
                    ),
                  ),
                if (_selectedMembership != title)
                  Container(
                    height: 28,
                    width: 28,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 1)),
                  ),
                Center(
                  child: SizedBox(
                    width: MediaQuery.of(context).size.width * 0.60,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          title,
                          textAlign: TextAlign.center,
                          style: GoogleFonts.syne(
                            color: Colors.white,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 5),
                        Text(
                          subtitle,
                          textAlign: TextAlign.center,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  width: 28,
                ),
              ],
            ),
          ),
        ),
        if (badge != null)
          Positioned(
            right: 20,
            top: 0,
            child: Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: Container(
                height: 32,
                width: 110,
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(30),
                  image: const DecorationImage(
                      image: AssetImage(
                        'assets/buttonbg.png',
                      ),
                      fit: BoxFit.cover),
                ),
                child: Text(
                  badge,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 12,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
      ],
    );
  }
}
