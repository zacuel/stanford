// // ignore_for_file: constant_identifier_names, non_constant_identifier_names
// import 'package:firebase_core/firebase_core.dart';
// import '';

// const EMAIL_LABEL = 'bot';
// const PASSWORD = 'testtest';

// class AuthCheats {
//   final AuthMethods _authMethods = AuthMethods();

//   String getEmail(int number) {
//     return "$EMAIL_LABEL$number@$EMAIL_LABEL.com";
//   }

//   getBot(String? number) async {
//     int NUMBER = 1;
//     if (number != null && int.tryParse(number) != null) {
//       NUMBER = int.parse(number);
//       if (NUMBER > 0 && NUMBER < 100) {
//         try {
//           await _authMethods.logIn(getEmail(NUMBER), PASSWORD);
//           return;
//         } on FirebaseException catch (e) {
//           throw e.message!;
//         } catch (e) {
//           if (e.toString() == 'Error') {
//             try {
//               await _authMethods.createNewCitizenAccount(
//                   getEmail(NUMBER), PASSWORD);
//               return;
//             } catch (e) {
//               return;
//             }
//           }
//         }
//       } else {
//         await _authMethods.logIn(getEmail(1), PASSWORD);
//       }
//     } else {
//       await _authMethods.logIn(getEmail(1), PASSWORD);
//     }
//   }
// }
