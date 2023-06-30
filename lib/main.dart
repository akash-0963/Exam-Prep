import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:prep/pages/fill_info.dart';
import 'package:prep/pages/paper_list.dart';
import 'package:prep/pages/signup_page.dart';


import 'package:prep/pages/subject_list.dart';
import 'firebase_options.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';

Future<void> main() async {


  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
       options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Prep",
      routes: {
        '/': (context) => HomePage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => SignupPage(),
        '/fill': (context) => FillInfoPage(),
        '/subject': (context) => SubjectPage(),
        // '/papers': (context) => PreviousPapersPage(subjectId: ''),
      },
    );
  }
}


