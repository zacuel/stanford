// ignore_for_file: constant_identifier_names, non_constant_identifier_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stanford/authentication/auth_controller.dart';

const EMAIL_LABEL = 'bot';
const PASSWORD = 'testtest';

class AuthCheatsScreen extends ConsumerStatefulWidget {
  const AuthCheatsScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _AuthCheatsScreenState();
}

class _AuthCheatsScreenState extends ConsumerState<AuthCheatsScreen> {
  final _controller = TextEditingController();
  bool isNewUser = false;
  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  String getEmail(int number) {
    return "$EMAIL_LABEL$number@$EMAIL_LABEL.com";
  }

  void _pressButton() {
    int number = int.parse(_controller.text);
    if (number > 0 || number < 31) {
      ref
          .read(authControllerProvider.notifier)
          .signUpOrLogIn(getEmail(number), PASSWORD, isNewUser, context);
    } else {
      _controller.text = '';
      return;
    }
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("What is happening"),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : Center(
              child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  color: Colors.lime,
                  height: 100,
                  width: 200,
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    alignment: Alignment.bottomRight,
                    child: TextField(
                      controller: _controller,
                      keyboardType: TextInputType.number,
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                Checkbox(
                  value: isNewUser,
                  onChanged: (value) {
                    setState(() {
                      isNewUser = value!;
                    });
                  },
                ),
                ElevatedButton(
                  onPressed: _pressButton,
                  child: const Text(
                    "Go!",
                    style: TextStyle(fontSize: 20),
                  ),
                ),
                const SizedBox(
                  height: 200,
                )
              ],
            )),
    );
  }
}
