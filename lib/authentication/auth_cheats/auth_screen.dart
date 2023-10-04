// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'auth_cheats.dart';

// class AuthScreen extends StatefulWidget {
//   const AuthScreen({super.key});

//   @override
//   State<AuthScreen> createState() => _AuthScreenState();
// }

// class _AuthScreenState extends State<AuthScreen> {
//   final _controller = TextEditingController();

//   @override
//   dispose() {
//     super.dispose();
//     _controller.dispose();
//   }

//   _pressButton() {
//     AuthCheats().getBot(_controller.text);
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text("What is happening"),
//       ),
//       body: Center(
//           child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Container(
//             color: Colors.lime,
//             height: 100,
//             width: 200,
//             child: Container(
//               padding: const EdgeInsets.all(20),
//               alignment: Alignment.bottomRight,
//               child: TextField(
//                 controller: _controller,
//                 keyboardType: TextInputType.number,
//               ),
//             ),
//           ),
//           const SizedBox(height: 100),
//           ElevatedButton(
//             onPressed: _pressButton,
//             child: const Text(
//               "Go!",
//               style: TextStyle(fontSize: 20),
//             ),
//           ),
//           const SizedBox(
//             height: 200,
//           )
//         ],
//       )),
//     );
//   }
// }
