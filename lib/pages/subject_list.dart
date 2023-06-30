// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
//
// class SubjectPage extends StatelessWidget{
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(),
//       body: Center(
//           child: Text("subject page")
//       ),
//       drawer: Drawer(
//         child: ListView(
//           children: [
//               ListTile(
//               leading: Icon(Icons.logout),
//               title: Text('Logout'),
//               onTap: () async {
//                 Navigator.pop(context); // Close the drawer
//                 await _logout(context); // Call the logout method
//               },
//             ),
//           ]
//         )
//       ),
//     );
//   }
// }
//




import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:prep/pages/paper_list.dart';
import 'package:prep/pages/pdfviewPage.dart';

class SubjectPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Subjects'),
      ),

      drawer: Drawer(
          child: ListView(
            children: [
                ListTile(
                leading: Icon(Icons.logout),
                title: Text('Logout'),
                onTap: () async {
                  Navigator.pop(context); // Close the drawer
                  await _logout(context); // Call the logout method
                },
              ),
            ]
          )
      ),

      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('subjects').snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final subjects = snapshot.data!.docs;

          return ListView.builder(
            itemCount: subjects.length,
            itemBuilder: (context, index) {
              final subject = subjects[index];
              //print(subject.id);
              return ListTile(
                title: Text(subject['name']),
                onTap: () {
                  print(subject.id);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                     builder: (context) => PreviousPapersPage(subjectId: subject.id),
                     //  builder: (context) => PdfViewerPage(),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}


Future<void> _logout(BuildContext context) async {
  try {
    await FirebaseAuth.instance.signOut();
    // Redirect the user to the login page or any other desired screen
    // You can use Navigator.pushReplacementNamed() or Navigator.pushReplacement() to navigate
    // to the login page while replacing the current route.
    Navigator.pushNamedAndRemoveUntil(context, '/', (route) => false);
    print("signed out");
  } catch (e) {
    print('Error during logout: $e');
    // Handle any errors that occur during logout
  }
}
