import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:laundri/auth/login_page.dart';
import 'package:laundri/config/app_color.dart';
import 'package:laundri/config/app_session.dart';
import 'package:laundri/page/dashboard_page.dart';

void main() {
  runApp(
    ProviderScope(child: const MainApp()),
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: Colors.blue,
        scaffoldBackgroundColor: const Color.fromARGB(255, 255, 255, 255),
        colorScheme: const ColorScheme.light(
          primary: AppColor.primary,
          secondary: AppColor.secondary,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ButtonStyle(
            backgroundColor: const MaterialStatePropertyAll(Colors.blue),
            shape: MaterialStatePropertyAll(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            padding: const MaterialStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 16, vertical: 14),
            ),
            textStyle: const MaterialStatePropertyAll(TextStyle(fontSize: 15)),
          ),
        ),
      ),
      // home: const RegisterPage()
      home: FutureBuilder(
        future: AppSession.getUser(),
        builder: (context, snapshot) {
          if (snapshot.data == null) {
            return const LoginPage();
          }
          return const Dashboard();
        },
      ),
    );
  }
}
