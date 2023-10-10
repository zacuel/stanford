import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'theme/pallete.dart';
import 'package:stanford/authentication/auth_controller.dart';
import 'package:stanford/authentication/auth_repository.dart';
import 'package:stanford/models/citizen.dart';
import 'package:stanford/router.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
          apiKey: "AIzaSyCb-pUeYdOHQ4TVml2Vf9CusPzOU8Y2vJg",
          authDomain: "stanford-c9258.firebaseapp.com",
          projectId: "stanford-c9258",
          storageBucket: "stanford-c9258.appspot.com",
          messagingSenderId: "114798246639",
          appId: "1:114798246639:web:e104bae08cf6b30b35791a"),
    );
  } else {
    await Firebase.initializeApp();
  }
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {
  const MyApp({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  Citizen? citizenUser;

  void getData(WidgetRef ref, User data) async {
    citizenUser =
        await ref.watch(authRepositoryProvider).getUserData(data.uid).first;
    ref.read(citizenProvider.notifier).update((state) => citizenUser);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ref.watch(authStateChangeProvider).when(
        data: (data) => MaterialApp.router(
              //TODO figure out theming button theme, etc.
              theme: Pallete.pastelTheme,
              routerDelegate: RoutemasterDelegate(
                routesBuilder: (context) {
                  if (data != null) {
                    getData(ref, data);
                    if (citizenUser != null) {
                      return loggedInRoute;
                    }
                  }
                  return loggedOutRoute;
                },
              ),
              routeInformationParser: const RoutemasterParser(),
              title: 'Hello World!',
            ),
        error: (error, stackTrace) => const Center(child: Text('error')),
        loading: () => const Center(
              child: CircularProgressIndicator(),
            ));
  }
}
