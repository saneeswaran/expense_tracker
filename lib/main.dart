import 'package:expense_tracker/firebase_options.dart';
import 'package:expense_tracker/providers/expense_provider.dart';
import 'package:expense_tracker/screens/bottom%20nav%20bar/bottom_navi_bar.dart';
import 'package:expense_tracker/screens/onboard/onboard_page.dart';
import 'package:expense_tracker/screens/splash/splash_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(
    MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => ExpenseProvider())],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'expense tracker',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primaryColor: const Color.fromRGBO(79, 152, 147, 1)),
      home: StreamBuilder(
        stream: FirebaseAuth.instance.idTokenChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const SplashPage();
          } else if (snapshot.hasData) {
            return const BottomNaviBar();
          } else {
            return const OnboardPage();
          }
        },
      ),
    );
  }
}
