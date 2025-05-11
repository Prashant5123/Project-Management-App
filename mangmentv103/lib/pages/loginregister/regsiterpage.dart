import 'dart:developer';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mangmentv103/components/my_textfield.dart';
import 'package:mangmentv103/components/my_button.dart';

import 'package:mangmentv103/pages/loginregister/syncpage.dart';
import 'package:mangmentv103/provider/credentialprovider/loginprovider.dart';
import 'package:provider/provider.dart';
import 'package:mangmentv103/pages/loginregister/functions.dart';

class Registerpage extends StatefulWidget {
  const Registerpage({super.key});

  @override
  State<Registerpage> createState() => _RegisterpageState();
}

class _RegisterpageState extends State<Registerpage> {
  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pwcontroller = TextEditingController();
  final TextEditingController _confirmcontroller = TextEditingController();
  final TextEditingController _empidcontroller = TextEditingController();

  final TextEditingController _namecontroller = TextEditingController();

  String level = "";
  int jobno = 0;

  void clearTextField(){
    _emailcontroller.clear();
    _pwcontroller.clear();
    _namecontroller.clear();
    _empidcontroller.clear();
    level="";
    _emailcontroller.clear();
    _confirmcontroller.clear();

  }

  // Function to handle radio button selection
  void handleRadioValueChange(String? value) {
    setState(() {
      level = value!;
      if (level == "Manager") {
        jobno = 1;
      } else if (level == "Team lead") {
        jobno = 2;
      } else if (level == "Employee") {
        jobno = 3;
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  void register(BuildContext context, dynamic _jobnocontroller) async {
    final auth = AuthService();

    if (_pwcontroller.text == _confirmcontroller.text) {
      try {
        // Await the result of signUpWithEmailPassword
        await auth.signUpWithEmailPassword(
          _emailcontroller.text,
          _pwcontroller.text,
          _namecontroller.text, // Add your TextEditingController for name
          int.parse(_jobnocontroller.text), // Convert jobno to int
          _empidcontroller.text,
        );

        // Optional: Navigate or show success dialog
        showDialog(
          context: context,
          builder: (context) =>
              const AlertDialog(title: Text("Registration Successful")),
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text("Error: $e")),
        );
      }
    } else {
      showDialog(
        context: context,
        builder: (context) =>
            const AlertDialog(title: Text("Passwords don't match")),
      );
    }
  }

  bool isLoading=false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          Center(
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                autovalidateMode:
                    AutovalidateMode.onUserInteraction, // Enable auto-validation
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      Icons.app_registration_rounded,
                      size: 60,
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                    const SizedBox(height: 20),
                    const Text(
                      "Let's Create an Account for You",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 19,
                      ),
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Row(
                          children: [
                            Radio(
                              activeColor:
                                  Theme.of(context).colorScheme.inversePrimary,
                              value: "Employee",
                              groupValue: level,
                              onChanged: handleRadioValueChange,
                            ),
                            const Text(
                              "Employee",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor:
                                  Theme.of(context).colorScheme.inversePrimary,
                              value: "Team_Lead",
                              groupValue: level,
                              onChanged: handleRadioValueChange,
                            ),
                            const Text(
                              "Teamlead",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                              activeColor:
                                  Theme.of(context).colorScheme.inversePrimary,
                              value: "Manager",
                              groupValue: level,
                              onChanged: handleRadioValueChange,
                            ),
                            const Text(
                              "Manager",
                              style: TextStyle(color: Colors.white),
                            ),
                          ],
                        ),
                      ],
                    ),
                    const SizedBox(height: 25),
                    MyTextField(
                      inputfromator: [],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your name and surname';
                        }
                        List<String> words = value.trim().split(' ');
                        if (words.length != 2) {
                          return 'Please Enter you Name Surname';
                        }
                        for (var word in words) {
                          if (!RegExp(r'^[a-zA-Z]+$').hasMatch(word)) {
                            return 'Only alphabets (uppercase and lowercase) are allowed';
                          }
                        }
                        return null;
                      },
                      keyboardtype: TextInputType.text,
                      obscureText: false,
                      hintText: "Name",
                      controller: _namecontroller,
                    ),
                    const SizedBox(height: 25),
                    MyTextField(
                      inputfromator: [],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your email';
                        }
                        if (!RegExp(
                          r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}',
                        ).hasMatch(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                      keyboardtype: TextInputType.emailAddress,
                      obscureText: false,
                      hintText: "Email",
                      controller: _emailcontroller,
                    ),
                    const SizedBox(height: 25),
                    MyTextField(
                      inputfromator: [],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your password';
                        }
                        return null;
                      },
                      keyboardtype: TextInputType.text,
                      obscureText: true,
                      hintText: "Password",
                      controller: _pwcontroller,
                    ),
                    const SizedBox(height: 25),
                    MyTextField(
                      inputfromator: [],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please confirm your password';
                        }
                        if (value != _pwcontroller.text) {
                          return 'Passwords do not match';
                        }
                        return null;
                      },
                      keyboardtype: TextInputType.text,
                      obscureText: true,
                      hintText: "Confirm Password",
                      controller: _confirmcontroller,
                    ),
                    const SizedBox(height: 25),
                    MyTextField(
                      inputfromator: [FilteringTextInputFormatter.digitsOnly],
                      validator: (value) {
                        if (value!.isEmpty) {
                          return 'Please enter your employee ID';
                        }
                        return null;
                      },
                      keyboardtype: TextInputType.number,
                      hintText: "Employee ID",
                      obscureText: false,
                      controller: _empidcontroller,
                    ),
                    const SizedBox(height: 25),
                    MyButton(
                      buttoncolor: Theme.of(context).colorScheme.inversePrimary,
                      text: "Register",
                      onTap: () async {
                        log(level);
                    
                        if (level.isEmpty) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Please select your role (Employee, Team lead, or Manager).',
                              ),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                          return; // Exit early if no role is selected
                        }
          
                        if (_formKey.currentState!.validate()) {
                          if(_emailcontroller.text.trim().isNotEmpty && _namecontroller.text.trim().isNotEmpty &&_pwcontroller.text.trim().isNotEmpty && _pwcontroller.text.trim()==_confirmcontroller.text.trim() &&_empidcontroller.text.trim().isNotEmpty && level!=""){
                          log("hiii");
                            setState(() {
                        isLoading=true;
                      });
                          try {
                            UserCredential userCredential = await FirebaseAuth
                                .instance
                                .createUserWithEmailAndPassword(
                                    email: _emailcontroller.text.trim(),
                                    password: _pwcontroller.text.trim());
          
                            Map<String, dynamic> data = {
                              "name": _namecontroller.text.trim(),
                              "email": _emailcontroller.text.trim(),
                              "employee_id": _empidcontroller.text.trim(),
                              "employee_role": level
                            };
                            FirebaseFirestore firebaseFirestore =
                                FirebaseFirestore.instance;
                            await firebaseFirestore
                                .collection(level)
                                .doc(_emailcontroller.text)
                                .set(data);
          
                            Provider.of<LoginProvider>(
                              context,
                              listen: false,
                            ).setUserregter(
                              UserData(
                                email: _emailcontroller.text.trim(),
                                password: _pwcontroller.text.trim(),
                                name: _namecontroller.text.trim(),
                                designation: jobno,
                                userType: level,
                                empid: int.tryParse(_empidcontroller.text.trim()) ??
                                    101,
                              ),
                            );
                            
                            clearTextField();
                            setState(() {
                              isLoading=false;
                            });
                            Navigator.pop(context);
                          } on FirebaseAuthException catch (e) {
                            setState(() {
                              isLoading=false;
                            });
                            ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(content: Text("${e.message}")));
                            log("$e");
                          }
                        }}
                      },
                    ),
                    const SizedBox(height: 25),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          "Already a member?",
                          style: TextStyle(
                            fontSize: 18,
                            color: Theme.of(context).colorScheme.inversePrimary,
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            "Login",
                            style: TextStyle(
                              fontSize: 18,
                              color: Theme.of(context).colorScheme.tertiary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),

          if (isLoading)
          Container(
            color: Colors.black.withOpacity(0.3),
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 5, sigmaY: 5),
                  child: Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.7),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const CircularProgressIndicator(),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
