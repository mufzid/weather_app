// import 'package:flutter/material.dart';
// import 'package:path/path.dart';

// onLogoutPressed() async {
//     showDialog(
//       context: 
//       builder: (context) => AlertDialog(
//         surfaceTintColor: Colors.black,
//         backgroundColor: Colors.white,
//         title: const Text('Are you sure want to Logout?'),
//         content: const Text('You want to login after you logot from the page'),
//         actions: [
//           TextButton(
//             onPressed: () => Navigator.pop(context, false),
//             child: const Text(
//               'Cancel',
//               style: TextStyle(color: Color.fromARGB(255, 203, 16, 3)),
//             ),
//           ),
//           TextButton(
//             onPressed: () => Navigator.pushNamed(context, "/welcome"),
//             child: const Text(
//               'Log Out',
//               style: TextStyle(color: Colors.black),
//             ),
//           ),
//         ],
//       ),
//     );
//   }