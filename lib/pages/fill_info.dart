import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class FillInfoPage extends StatefulWidget {
  @override
  _FillInfoPageState createState() => _FillInfoPageState();
}

class _FillInfoPageState extends State<FillInfoPage> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  // final _rollNoController = TextEditingController();
  String _branchController = 'CS';// = TextEditingController();
  String _batchController = '21-25';// = TextEditingController();
  // final _prnNumberController = TextEditingController();
  final _phoneNumberController = TextEditingController();
  String _yearOfStudyController = 'FY';// = TextEditingController();
  late User? user;
  late String email;

  @override
  void initState() {
    super.initState();
    user = FirebaseAuth.instance.currentUser;
    email = user?.email ?? '';
  }

  @override
  void dispose() {
    _nameController.dispose();
    // _rollNoController.dispose();
    // _branchController.dispose();
    // _batchController.dispose();
    // _prnNumberController.dispose();
    _phoneNumberController.dispose();
    // _yearOfStudyController.dispose();
    super.dispose();
  }

  void _createStudent(String studentId) {
    if (_formKey.currentState!.validate()) {
      FirebaseFirestore.instance
          .collection('users')
          .doc(studentId)
          .set({
        'name': _nameController.text,
        // 'rollNo': _rollNoController.text,
        'branch': _branchController.toString(),
        'batch': _batchController.toString(),
        // 'prnNumber': _prnNumberController.text,
        'email': email,
        'phone': _phoneNumberController.text,
        'yearOfStudy': _yearOfStudyController.toString(),
        // 'outStandingFees':100,
        // 'totalFees':100
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('Success'),
            duration: Duration(seconds: 5),
          ),
        );
        Navigator.pushReplacementNamed(context, '/');
      }).catchError((error) {
        String errorMessage = 'An error occurred. Please try again later.';
        if (error is FirebaseException) {
          switch (error.code) {
            case 'permission-denied':
              errorMessage = 'Insufficient permissions.';
              break;
            case 'invalid-argument':
              errorMessage = 'Invalid field value.';
              break;
            case 'unavailable':
              errorMessage = 'Network connectivity issue.';
              break;
            case 'already-exists':
              errorMessage = 'Document already exists.';
              break;
          // Add more cases for specific error codes if needed
          }
        } else if (error is FirebaseAuthException) {
          errorMessage = 'Authentication error. Please check your credentials.';
        } else if (error is PlatformException) {
          errorMessage = 'Platform error occurred. ${error.message}';
        } else if (error is SocketException) {
          errorMessage = 'Network error occurred. Please check your internet connection.';
        } else if (error is FormatException) {
          errorMessage = 'Format error occurred. Invalid data format.';
        }
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(errorMessage),
            duration: Duration(seconds: 5),
          ),
        );
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final User? user = FirebaseAuth.instance.currentUser;
    final String studentId = user?.uid ?? '';


    return Scaffold(
      appBar: AppBar(
        title: Text('Create Student'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                ListTile(
                  title: TextFormField(
                    controller: _nameController,
                    decoration: InputDecoration(labelText: 'Name'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the name';
                      }
                      return null;
                    },
                  ),
                ),
                // ListTile(
                //   title: TextFormField(
                //     controller: _rollNoController,
                //     decoration: InputDecoration(labelText: 'Roll No'),
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return 'Please enter the roll number';
                //       }
                //       return null;
                //     },
                //   ),
                // ),
                // ListTile(
                //   title: TextFormField(
                //     controller: _prnNumberController,
                //     decoration: InputDecoration(labelText: 'PRN Number'),
                //     validator: (value) {
                //       if (value!.isEmpty) {
                //         return 'Please enter the PRN number';
                //       }
                //       return null;
                //     },
                //   ),
                // ),

                ListTile(
                  title: Text("Batch"),
                  subtitle: DropdownButton<String>(

                    value: _batchController,

                    items: <String>['18-22', '19-23', '20-24', '21-25']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 30),
                        ),
                      );
                    }).toList(),
                    // Step 5.
                    onChanged: (String? newValue) {
                      setState(() {
                        _batchController = newValue!;
                      });
                    },
                  ),
                ),

                ListTile(
                  title: Text("Branch"),
                  subtitle: DropdownButton<String>(

                    value: _branchController,

                    items: <String>['CS', 'CSBS', 'IT', 'ENTC', 'ET', 'ME', 'CE', 'AR']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 30),
                        ),
                      );
                    }).toList(),
                    // Step 5.
                    onChanged: (String? newValue) {
                      setState(() {
                        _branchController = newValue!;
                      });
                    },
                  ),
                ),

                ListTile(
                  title: Text("Year"),
                  subtitle: DropdownButton<String>(

                    value: _yearOfStudyController,

                    items: <String>['FY', 'SY', 'TY', 'Final Year']
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(
                          value,
                          style: TextStyle(fontSize: 30),
                        ),
                      );
                    }).toList(),
                    // Step 5.
                    onChanged: (String? newValue) {
                      setState(() {
                        _yearOfStudyController = newValue!;
                      });
                    },
                  ),
                ),

                ListTile(
                  title: TextFormField(
                    controller: _phoneNumberController,
                    decoration: InputDecoration(labelText: 'Phone Number'),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return 'Please enter the Phone Number';
                      }
                      return null;
                    },
                  ),
                ),
                ElevatedButton(
                  onPressed: (){
                    _createStudent(studentId);
                  },
                  child: Text('Create'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
