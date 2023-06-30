import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter_pdfview/flutter_pdfview.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'package:prep/pages/pdfviewPage.dart';

class PreviousPapersPage extends StatelessWidget {
  final String subjectId;

  PreviousPapersPage({required this.subjectId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Previous Papers'),
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance
            .collection('subjects')
            .doc(subjectId)
            .collection('previousPapers')
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }
          final previousPapers = snapshot.data!.docs;

          return ListView.builder(
            itemCount: previousPapers.length,
            itemBuilder: (context, index) {
              final paper = previousPapers[index];
              return ListTile(
                title: Text(paper['title']),
                onTap: () async {
                  var pdfUrl = paper['url'];
                  //var pdfUrl = 'http://www.pdf995.com/samples/pdf.pdf';
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => PdfViewerPage(url: pdfUrl),
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