import 'package:amazone_clone_app/common/widgets/bottom_bar.dart';
import 'package:amazone_clone_app/constants/global_variables.dart';
import 'package:amazone_clone_app/features/admin/screens/admin_screen.dart';
import 'package:amazone_clone_app/features/auth/screens/auth_screen.dart';
import 'package:amazone_clone_app/features/auth/services/auth_service.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AuthService authService = AuthService();

  @override
  void initState() {
    authService.getUserData(context);
    super.initState();
  }

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
      home: Scaffold(
        // appBar: AppBar(
        //   title: const Text('Hello'),
        // ),
        body: Provider.of<UserProvider>(context).user.token.isNotEmpty
            ? Provider.of<UserProvider>(context).user.type == 'user'
                ? const BottomBar()
                : const AdminScreen()
            : const AuthScreen(),
      ),
    );
  }
}
