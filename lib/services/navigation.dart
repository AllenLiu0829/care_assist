import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'package:care_assist/views/product_page.dart';

final routerConfig = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'product',
      builder: (context, state) => const ProductPage(),
    ),
  ],
  debugLogDiagnostics: true,
  redirect: (context, state) {
    final currentPath = state.uri.path;
    if (currentPath == '/') {
      return '/';
    }
    return null;
  },
  errorBuilder: (context, state) => Scaffold(
    body: Center(
      child: Text('Page not found: ${state.uri.path}'),
    ),
  ),
);

class NavigationService {
  late final GoRouter _router;

  NavigationService() {
    _router = routerConfig;
  }

  void goMenuPage() {
    _router.goNamed('product');
    return;
  }
}
