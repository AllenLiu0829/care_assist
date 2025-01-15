import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:care_assist/firebase_options.dart';

import 'package:care_assist/services/navigation.dart';
import 'package:care_assist/views_models/company_info_list_vm.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        Provider<NavigationService>(
          create: (_) => NavigationService(),
        ),
        ChangeNotifierProvider<CompanyInfoViewModel>(
          create: (_) => CompanyInfoViewModel(),
        ),
      ],
      child: SafeArea(
        child: MaterialApp.router(
          theme: ThemeData.light().copyWith(
            colorScheme: ColorScheme.fromSeed(
              seedColor: Colors.lime,
            ),
          ),
          routerConfig: routerConfig,
          restorationScopeId: 'app',
        ),
      ),
    );
  }
}
