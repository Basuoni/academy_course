
import 'package:academycourse/src/config/app_route.dart';
import 'package:academycourse/src/config/app_theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Admin',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.mainTheme(),
      onGenerateRoute: AppGenerateRoute.onGenerateRoute,
    );
  }
}
