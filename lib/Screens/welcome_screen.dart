import 'package:flutter/material.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: double.infinity,
        width: double.infinity,
        padding: EdgeInsets.symmetric(horizontal: 40),
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage(
                  'assets/background.png',
                ),
                fit: BoxFit.cover)),
        child: Image.asset('assets/logo.png'),
      ),
    );
  }
}




// import 'package:flutter/material.dart';

// class WelcomeScreen extends StatelessWidget {
//   const WelcomeScreen({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Stack(
//         children: [
//           Positioned(
//             left: -61,
//             top: 119,
//             child: Container(
//               width: 579,
//               height: 708,
//               decoration: BoxDecoration(
//                 gradient: LinearGradient(
//                   begin: Alignment(-0.5, 0.0),
//                   end: Alignment(0.5, 0.0),
//                   colors: [
//                     Color(0xFF66D6FF).withOpacity(0.5),
//                     Color(0xFF7652FA).withOpacity(0.5),
//                     Color(0xFF630EEF).withOpacity(0.5),
//                   ],
//                   stops: [0.0, 0.482, 1.0],
//                 ),
//               ),
//               transform: Matrix4.identity()
//                 ..translate(0.581, -0.002)
//                 ..rotateZ(68.439 * 3.1415927 / 180) // Rotation in radians
//                 ..scale(1.64, 1.578),
//             ),
//           ),

//           // Center(
//           //   child: Text(
//           //     'Podzter.',
//           //     style: TextStyle(
//           //       fontSize: 48,
//           //       fontWeight: FontWeight.bold,
//           //       color: Colors.white,
//           //       fontFamily: 'Cursive',
//           //     ),
//           //   ),
//           // ),
//         ],
//       ),
//     );
//   }
// }

// class PodzterScreen extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.black,
//       body: Stack(
//         children: [
//           Center(
//             child: Transform.translate(
//               offset: Offset(-61, 119),
//               child: CustomPaint(
//                 size: Size(579, 708),
//                 painter: UnionPainter(),
//               ),
//             ),
//           ),
//           Center(
//             child: Container(
//               alignment: Alignment.center,
//               child: Text(
//                 'Podzter',
//                 style: TextStyle(
//                   fontSize: 72,
//                   fontWeight: FontWeight.bold,
//                   color: Colors.white,
//                 ),
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }

// class UnionPainter extends CustomPainter {
//   @override
//   void paint(Canvas canvas, Size size) {
//     final paint = Paint();
//     final gradient = LinearGradient(
//       begin: Alignment.topCenter,
//       end: Alignment.bottomCenter,
//       colors: [
//         Color(0xFF66D6FF).withOpacity(0.5),
//         Color(0xFF7652FA).withOpacity(0.5),
//         Color(0xFF630EEF).withOpacity(0.5),
//       ],
//       stops: [0.0, 0.482, 1.0],
//     );
//     final rect = Rect.fromLTWH(0, 0, size.width, size.height);
//     paint.shader = gradient.createShader(rect);

//     final path = Path();
//     path.addRect(rect);

//     canvas.save();
//     canvas.translate(0.581, -0.002);
//     canvas.translate(size.width / 2, size.height / 2);
//     canvas.rotate(68.439 * 3.14159265359 / 180);
//     canvas.scale(1.64, 1.578);
//     canvas.translate(-size.width / 2, -size.height / 2);

//     canvas.drawPath(path, paint);
//     canvas.restore();
//   }

//   @override
//   bool shouldRepaint(covariant CustomPainter oldDelegate) {
//     return false;
//   }
// }
// // import 'package:flutter/material.dart';

// // class WelcomeScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: Colors.black,
// //       body: Center(
// //         child: Stack(
// //           children: [
// //             Container(
// //               padding: EdgeInsets.symmetric(horizontal: 50),
// //               decoration: BoxDecoration(
// //                 // gradient: RadialGradient(
// //                 //   colors: [
// //                 //     Color(0xFF0d0521),
// //                 //     Color(0xFF2f4e71),
// //                 //     Color(0xFF2d2667),
// //                 //     Color(0xFF301770),
// //                 //     Color(0xFF210650),
// //                 //     Color(0xFF0b011b),
// //                 //   ],
// //                 //   center: Alignment(0, 0),
// //                 //   radius: 1.0,
// //                 //   stops: [0.0, 0.4, 0.6, 0.7, 0.85, 1.0],
// //                 // ),

// //                 gradient: LinearGradient(
// //                   colors: [
// //                     // Color(0xFF0D1B2A), // Dark blue color
// //                     // Color(0xFF3A0CA3), // Purple color
// //                     // Color(0xFF7209B7), // Another shade of purple
// //                     // Color(0xFF560BAD), // Yet another shade of purple
// //                     // Color(0xFF480CA8), // Deep purple color
// //                     Color(0xFF0d0521), // Dark purple color
// //                     // Color(0xFF2f4e71), // Blue color
// //                     Color(0xFF2d2667), // Another shade of purple
// //                     Color(0xFF301770), // Deep purple color
// //                     Color(0xFF210650), // Darker purple color
// //                     Color(0xFF0b011b), // Almost black color
// //                   ],
// //                   begin: Alignment.topCenter,
// //                   end: Alignment.bottomCenter,
// //                   // stops: [0.0, 0.25, 0.5, 0.75, 1.0], // Adjust stops as needed
// //                   // stops: [
// //                   //   0.0,
// //                   //   0.2,
// //                   //   0.4,
// //                   //   0.6,
// //                   //   0.8,
// //                   //   1.0
// //                   // ], // Adjust stops as needed
// //                 ),
// //               ),
// //               child: Center(
// //                   child: Image(
// //                 image: AssetImage('assets/logo.png'),
// //               )),
// //             ),
// //             // Positioned(
// //             //   top: 200,
// //             //   left: 50,
// //             //   child: Container(
// //             //     height: 150,
// //             //     width: 150,
// //             //     // color: Colors.black,
// //             //     decoration: BoxDecoration(
// //             //         shape: BoxShape.circle,
// //             //         color: Color(0xFF2f4e71).withOpacity(0.50), // Blue color
// //             //         boxShadow: [
// //             //           BoxShadow(
// //             //               color: Color(0xFF2f4e71),
// //             //               blurRadius: 50,
// //             //               blurStyle: BlurStyle.outer)
// //             //         ]),
// //             //   ),
// //             // )
// //           ],
// //         ),
// //       ),
// //     );
// //   }
// // }

// // class GradientScreen extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       body: Stack(
// //         children: [
// //           Positioned.fill(
// //             child: Container(
// //               decoration: BoxDecoration(
// //                 gradient: RadialGradient(
// //                   colors: [
// //                     Color(0xFF2f4e71).withOpacity(0.5),
// //                     Colors.transparent,
// //                   ],
// //                   radius: 0.8,
// //                   center: Alignment(-0.5, -0.5),
// //                   stops: [0.0, 1.0],
// //                 ),
// //               ),
// //             ),
// //           ),
// //           Container(
// //             decoration: BoxDecoration(
// //               gradient: LinearGradient(
// //                 colors: [
// //                   Color(0xFF0b011b),
// //                   Color(0xFF210650),
// //                   Color(0xFF2f4e71),
// //                   Color(0xFF301770),
// //                   Color(0xFF2d2667),
// //                   Color(0xFF0d0521),
// //                 ],
// //                 begin: Alignment.topCenter,
// //                 end: Alignment.bottomCenter,
// //               ),
// //             ),
// //           ),
// //           Positioned.fill(
// //             child: Container(
// //               decoration: BoxDecoration(
// //                 gradient: RadialGradient(
// //                   colors: [
// //                     Color(0xFF301770).withOpacity(0.5),
// //                     Colors.transparent,
// //                   ],
// //                   radius: 0.8,
// //                   center: Alignment(0.5, -0.5),
// //                   stops: [0.0, 1.0],
// //                 ),
// //               ),
// //             ),
// //           ),
// //           Positioned.fill(
// //             child: Container(
// //               decoration: BoxDecoration(
// //                 gradient: RadialGradient(
// //                   colors: [
// //                     Color(0xFF0d0521).withOpacity(0.5),
// //                     Colors.transparent,
// //                   ],
// //                   radius: 0.8,
// //                   center: Alignment(0, 0.5),
// //                   stops: [0.0, 1.0],
// //                 ),
// //               ),
// //             ),
// //           ),
// //           Container(
// //             padding: EdgeInsets.symmetric(horizontal: 50),
// //             child: Center(
// //                 child: Image(
// //               image: AssetImage('assets/logo.png'),
// //             )),
// //           ),
// //         ],
// //       ),
// //     );
// //   }
// // }
