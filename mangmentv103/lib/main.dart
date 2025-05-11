
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mangmentv103/pages/loginregister/login_page.dart';
import 'package:mangmentv103/provider/credentialprovider/manager_provider.dart';
import 'package:mangmentv103/provider/credentialprovider/teamlead_provider.dart';
import 'package:mangmentv103/provider/theme/theme_provider.dart';
import 'package:mangmentv103/provider/credentialprovider/loginprovider.dart';
import 'package:provider/provider.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: FirebaseOptions(apiKey: "AIzaSyCx6_PlT0zmmS3Kb_rGD1zXBnjZcVO1bp0", appId: "1:917192798201:android:b979a61fb4d8732a579728", messagingSenderId: "917192798201", projectId: "project-management-b27c8"));
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => LoginProvider()),
        ChangeNotifierProvider(create:(context)=>ManagerProvider()),
        ChangeNotifierProvider(create: (context)=>TeamleadProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => ThemeProvider(),
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'Splash Screen Example',
            theme: themeProvider.themeData,
            initialRoute: '/',
            home: LoginPage(),
          );
        },
      ),
    );
  }
}
