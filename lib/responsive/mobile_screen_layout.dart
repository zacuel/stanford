import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:stanford/authentication/auth_controller.dart';
import 'package:stanford/models/citizen.dart';

import '../screens/create_article_screen.dart';

class MobileScreenLayout extends ConsumerStatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends ConsumerState<MobileScreenLayout> {
  @override
  Widget build(BuildContext context) {
    final citizen = ref.watch(citizenProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(citizen!.alias),
        leading: PopupMenuButton(
            onSelected: (value) {
              if (value == 'create') {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (_) => const CreateArticleScreen()));
              }
            },
            icon: const Icon(Icons.menu),
            itemBuilder: (BuildContext ctx) => [
                  const PopupMenuItem(
                    value: 'news',
                    child: Text('temporal feed'),
                  ),
                  const PopupMenuItem(
                    value: 'create',
                    child: Text('create new article'),
                  ),
                  const PopupMenuItem(
                    value: 'profile',
                    child: Text('see what you\'ve noticed'),
                  ),
                ]),
      ),
      body: const Placeholder(),
    );
  }
}
