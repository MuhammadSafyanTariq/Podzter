import 'package:flutter/material.dart';

class MembershipOption extends StatefulWidget {
  @override
  _MembershipOptionState createState() => _MembershipOptionState();
}

class _MembershipOptionState extends State<MembershipOption> {
  String _selectedMembership = 'Free With Ads';

  Widget _buildMembershipOption(String title, String subtitle, String? badge) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMembership = title;
        });
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: _selectedMembership == title
              ? const Color(0xFF6A00F4).withOpacity(0.2)
              : Colors.transparent,
          border: Border.all(
            color: _selectedMembership == title
                ? const Color(0xFF6A00F4)
                : Colors.white.withOpacity(0.25),
          ),
          borderRadius: BorderRadius.circular(30),
        ),
        child: Row(
          children: [
            if (badge != null)
              Padding(
                padding: const EdgeInsets.only(right: 10.0),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF6A00F4), Color(0xFFAB00F4)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(20),
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
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  subtitle,
                  style: const TextStyle(
                    color: Colors.white70,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
            const Spacer(),
            if (_selectedMembership == title)
              const Icon(
                Icons.check_circle,
                color: Color(0xFF6A00F4),
              ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _buildMembershipOption('Annual', '\$23.99 per year', '1.99 / Mo'),
            _buildMembershipOption('Monthly', '\$23.99 per year', null),
            _buildMembershipOption('Free With Ads',
                'Enjoy all essential features, with ads.', null),
          ],
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: MembershipOption(),
  ));
}
