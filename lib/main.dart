import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/settings_page.dart';
import 'package:provider/provider.dart';
import 'pages/about_page.dart';
import 'pages/tasks_page.dart';
import 'pages/app_state.dart';
import 'pages/consent_page.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'pages/auth_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'pages/survey_page.dart';


class AuthWrapper extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, authSnapshot) {

        if (authSnapshot.connectionState == ConnectionState.waiting) {
          return Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        if (!authSnapshot.hasData) {
          return AuthPage(); // не вошёл
        }

        // 👇 пользователь есть → проверяем анкету
        String uid = FirebaseAuth.instance.currentUser!.uid;

        return FutureBuilder(
          future: FirebaseFirestore.instance
              .collection('users')
              .doc(uid)
              .get(),
          builder: (context, snapshot) {

            if (snapshot.connectionState == ConnectionState.waiting) {
              return Scaffold(
                body: Center(child: CircularProgressIndicator()),
              );
            }

            if (!snapshot.hasData || !snapshot.data!.exists) {
              return ConsentPage(); // 👈 анкета не заполнена
            }

            return HomePage(); // 👈 всё ок
          },
        );
      },
    );
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("START");
  await Firebase.initializeApp();
  print("FIREBASE INIT DONE");
  runApp(
      ChangeNotifierProvider(
        create: (_) => AppState(),
        child: MyApp(), // 👈 ВСЁ приложение внутри Provider
      ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      
      debugShowCheckedModeBanner: false,
      
      
      initialRoute: '/',

      routes: {
        '/home': (context) => HomePage(),
        '/settings': (context) => SettingsPage(),
        '/about': (context) => AboutPage(),
        '/tasks': (context) => TasksPage(),
      },
      title: 'Flutter Demo',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.green),
      ),
      home: AuthWrapper(),
    );
  }
}


