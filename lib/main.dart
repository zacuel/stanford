import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stanford/authentication/auth_controller.dart';
import 'package:stanford/authentication/auth_repository.dart';
import 'package:stanford/models/citizen.dart';
import 'responsive/mobile_screen_layout.dart';
import 'responsive/responsive_layout_screen.dart';
import 'responsive/web_screen_layout.dart';
import 'package:stanford/authentication/auth_cheats/auth_cheats_screen.dart';

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
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (BuildContext context, AsyncSnapshot<User?> snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              getData(ref, snapshot.data!);
              return const ResponsiveLayout(
                webScreenLayout: WebScreenLayout(),
                mobileScreenLayout: MobileScreenLayout(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            }
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return const AuthCheatsScreen();
        },
      ),
    );
  }
}
