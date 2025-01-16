import 'package:care_assist/views/product_page.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';

import 'package:care_assist/views/company_info_page.dart';
import 'package:care_assist/views_models/company_info_list_vm.dart';
import 'package:care_assist/views_models/product_page_vm.dart';
import 'package:provider/provider.dart';

final routerConfig = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'companyInfo',
      builder: (context, state) => const CompanyInfoPage(),
      routes: <RouteBase>[
        ShellRoute(
          builder: (BuildContext context, GoRouterState state, Widget child) {
            return ChangeNotifierProxyProvider<CompanyInfoViewModel,
                ProductViewModel>(
              create: (_) => ProductViewModel(
                companyId: state.pathParameters['companyId']!,
              ),
              update: (_, companyInfoViewModel, prevProductInfoViewModel) =>
                  prevProductInfoViewModel!
                    ..updateViewModel(companyInfoViewModel.companyInfos),
              child: child,
            );
          },
          routes: [
            GoRoute(
              path: ':companyId/product',
              name: 'product',
              builder: (context, state) => const ProductPage(),
            ),
          ],
        ),
      ],
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

  void goProductPage(String companyId) {
    _router.go('/$companyId/product');
    return;
  }
}
