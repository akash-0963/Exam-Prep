import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prep/pages/subject_list.dart';

import 'login_page.dart';

class HomePage extends StatelessWidget{

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      //print("is logged in");
      return SubjectPage();
    } else {
      //print("is not");
      return LoginPage();
    }
  }
}

