import 'package:amazone_clone_app/constants/global_variables.dart';
import 'package:amazone_clone_app/features/auth/screens/auth_screen.dart';
import 'package:amazone_clone_app/providers/user_provider.dart';
import 'package:amazone_clone_app/router.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MultiProvider(providers: [
    ChangeNotifierProvider(
      create: (context) => UserProvider(),
    ),
  ], child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Amazon clone',
      theme: ThemeData(
        scaffoldBackgroundColor: GlobalVariables.backgroundColor,
        appBarTheme: const AppBarTheme(
          elevation: 0,
          iconTheme: IconThemeData(color: Colors.black),
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
        ),
        primarySwatch: Colors.blue,
        colorScheme:
            const ColorScheme.light(primary: GlobalVariables.secondaryColor),
        useMaterial3: true,
      ),
      onGenerateRoute: (settings) => generateRoute(settings),
      home: const Scaffold(
          // appBar: AppBar(
          //   title: const Text('Hello'),
          // ),
          body: AuthScreen()),
    );
  }
}
