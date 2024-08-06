// import 'package:flutter/material.dart';
// import 'package:convex_bottom_bar/convex_bottom_bar.dart';
// import 'package:insta_clone/utils/GlobalVariables.dart';

// class MobileScreenLayout extends StatefulWidget {
//   const MobileScreenLayout({super.key});

//   @override
//   State<MobileScreenLayout> createState() => _MobileScreenLayoutState();
// }

// class _MobileScreenLayoutState extends State<MobileScreenLayout> {
//   int _selectedIndex = 0;
//   late PageController _pageController;

//   @override
//   void initState() {
//     super.initState();
//     _pageController = PageController(initialPage: _selectedIndex);
//   }

//   @override
//   void dispose() {
//     _pageController.dispose();
//     super.dispose();
//   }

//   List<Widget> _buildScreens() {
//     // Ensure homeScreenItems is defined and contains a list of widgets
//     return homeScreenItems;
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: PageView(
//         controller: _pageController,
//         onPageChanged: (index) {
//           setState(() {
//             _selectedIndex = index;
//           });
//         },
//         children: _buildScreens(),
//       ),
//       bottomNavigationBar: ConvexAppBar(
//         style: TabStyle.fixed,
//         activeColor: Colors.white,
//         backgroundColor: Colors.black87,
//         shadowColor: Colors.white24,

//         // color: colors,
//         // height: 80,
//         items: [
//           const TabItem(
//               icon: Icon(
//                 Icons.home_outlined,
//                 size: 30,
//               ),
//               title: ''),
//           const TabItem(
//               icon: Icon(
//                 Icons.search_outlined,
//                 size: 30,
//               ),
//               title: ''),
//           TabItem(
//             icon: Container(
//               height: 100,
//               width: 100,
//               decoration: const BoxDecoration(
//                 shape: BoxShape.circle,
//                 gradient: LinearGradient(
//                   colors: [
//                     Color(0xFF0D1B2A), // Dark blue color
//                     Color(0xFF3A0CA3), // Purple color
//                     Color(0xFF7209B7), // Another shade of purple
//                     Color(0xFF560BAD), // Yet another shade of purple
//                     Color(0xFF480CA8), // Deep purple color
//                     // Color(0xFF0d0521), // Dark purple color
//                     // Color(0xFF2f4e71), // Blue color
//                     // Color(0xFF2d2667), // Another shade of purple
//                     // Color(0xFF301770), // Deep purple color
//                     // Color(0xFF210650), // Darker purple color
//                     // Color(0xFF0b011b), // Almost black color
//                   ],
//                   begin: Alignment.topCenter,
//                   end: Alignment.bottomCenter,
//                   // stops: [0.0, 0.25, 0.5, 0.75, 1.0], // Adjust stops as needed
//                   // stops: [
//                   //   0.0,
//                   //   0.2,
//                   //   0.4,
//                   //   0.6,
//                   //   0.8,
//                   //   1.0
//                   // ], // Adjust stops as needed
//                 ),
//               ),
//               child: const Icon(
//                 Icons.add,
//                 size: 30,
//                 color: Colors.white,
//               ),
//             ),
//             // title: '',
//           ),
//           const TabItem(
//               icon: Icon(
//                 Icons.message_outlined,
//                 size: 30,
//               ),
//               title: ''),
//           const TabItem(
//               icon: Icon(
//                 Icons.person_outline,
//                 size: 30,
//               ),
//               title: ''),
//         ],
//         initialActiveIndex: _selectedIndex,
//         onTap: (int index) {
//           setState(() {
//             _selectedIndex = index;
//             _pageController.jumpToPage(index);
//           });
//         },
//       ),
//     );
//   }
// }

// class CustomShapeClipper extends CustomClipper<Path> {
//   @override
//   Path getClip(Size size) {
//     var path = Path();
//     // Define the path that matches the image shape
//     // Example path definition
//     path.moveTo(0, 0);
//     path.lineTo(size.width * 0.75, 0);
//     path.quadraticBezierTo(
//       size.width * 0.9,
//       size.height * 0.1,
//       size.width,
//       size.height * 0.25,
//     );
//     path.lineTo(size.width, size.height);
//     path.lineTo(size.width * 0.25, size.height);
//     path.quadraticBezierTo(
//       size.width * 0.1,
//       size.height * 0.9,
//       0,
//       size.height * 0.75,
//     );
//     path.close();

//     return path;
//   }

//   @override
//   bool shouldReclip(CustomClipper<Path> oldClipper) {
//     return false;
//   }
// }

// class MyApp2 extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         appBar: AppBar(
//           title: Text('Custom Color Example'),
//           backgroundColor: Color(0xFFF9595F), // Use the color here
//         ),
//         body: Center(
//           child: Container(
//             width: 100,
//             height: 100,
//             color: Color(0xFFF9595F), // Use the color here
//           ),
//         ),
//       ),
//     );
//   }
// }
