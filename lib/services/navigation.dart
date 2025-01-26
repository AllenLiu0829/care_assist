import 'package:go_router/go_router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:care_assist/views/menu_page.dart';
import 'package:care_assist/views/company_info_page.dart';
import 'package:care_assist/views/product_page.dart';
import 'package:care_assist/views/product_list_page.dart';
import 'package:care_assist/views/survey_page.dart';
import 'package:care_assist/view_models/company_info_list_vm.dart';
import 'package:care_assist/view_models/product_page_vm.dart';

final routerConfig = GoRouter(
  initialLocation: '/',
  routes: <RouteBase>[
    GoRoute(
      path: '/',
      name: 'menu',
      builder: (context, state) => const MenuPage(),
      routes: <RouteBase>[
        GoRoute(
          path: '/companyInfo',
          name: 'companyInfo',
          builder: (context, state) => const CompanyInfoPage(),
          routes: <RouteBase>[
            ShellRoute(
              builder:
                  (BuildContext context, GoRouterState state, Widget child) {
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
        GoRoute(
          path: '/productList',
          name: 'productList',
          builder: (context, state) => const ProductListPage(),
        ),
        GoRoute(
          path: '/survey',
          name: 'survey',
          builder: (context, state) => const SurveyPage(),
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
    _router.push('/companyInfo/$companyId/product');
    return;
  }

  void goCompanyInfoPage() {
    _router.pushNamed('companyInfo');
  }

  void goProductListPage() {
    _router.pushNamed('productList');
  }

  void goSurveyPage() {
    _router.pushNamed('survey');
  }
}
