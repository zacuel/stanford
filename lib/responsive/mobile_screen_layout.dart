import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:routemaster/routemaster.dart';
import 'package:stanford/authentication/auth_controller.dart';
import '../screens/locale_articles_page.dart';
import '../utils/type_defs.dart';

class MobileScreenLayout extends ConsumerStatefulWidget {
  const MobileScreenLayout({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _MobileScreenLayoutState();
}

class _MobileScreenLayoutState extends ConsumerState<MobileScreenLayout> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  

  @override
  Widget build(BuildContext context) {
    final citizen = ref.watch(citizenProvider);
    return Scaffold(
      appBar: AppBar(
        title: Text(citizen!.alias),
        leading: PopupMenuButton(
            onSelected: (value) {
              if (value == 'create') {
                Routemaster.of(context).push('/create-article');
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
      body: PageView(
        controller: _pageController,
        children: const [
          LocaleArticlesPage(Locale.local),
          LocaleArticlesPage(Locale.state),
          LocaleArticlesPage(Locale.national),
          LocaleArticlesPage(Locale.global),
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dnd_forwardslash),
            backgroundColor: Colors.grey,
            label: 'local',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dnd_forwardslash),
            backgroundColor: Colors.grey,
            label: 'Michigan',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dnd_forwardslash),
            backgroundColor: Colors.grey,
            label: 'USA',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.dnd_forwardslash),
            backgroundColor: Colors.grey,
            label: 'World',
          ),
        ],
        onTap: (value) {
          _pageController.jumpToPage(value);
        },
        showUnselectedLabels: true,
      ),
    );
  }
}
