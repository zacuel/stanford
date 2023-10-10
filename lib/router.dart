import 'package:flutter/material.dart';
import 'package:routemaster/routemaster.dart';
import 'authentication/auth_cheats/auth_cheats_screen.dart';
import 'responsive/mobile_screen_layout.dart';
import 'responsive/responsive_layout_screen.dart';
import 'responsive/web_screen_layout.dart';
import 'screens/create_article_screen.dart';

final loggedOutRoute = RouteMap(
  routes: {
    '/': (route) => const MaterialPage(child: AuthCheatsScreen()),
  },
);

final loggedInRoute = RouteMap(routes: {
  '/': (route) => const MaterialPage(
      child: ResponsiveLayout(
          webScreenLayout: WebScreenLayout(),
          mobileScreenLayout: MobileScreenLayout())),
  '/create-article': (route) =>
      const MaterialPage(child: CreateArticleScreen()),
});
