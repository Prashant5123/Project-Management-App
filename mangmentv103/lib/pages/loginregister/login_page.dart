import 'dart:developer';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:mangmentv103/components/my_button.dart';
import 'package:mangmentv103/components/my_textfield.dart';
import 'package:mangmentv103/pages/loginregister/functions.dart';
import 'package:mangmentv103/pages/loginregister/regsiterpage.dart';
import 'package:mangmentv103/pages/primarypage.dart';

import 'package:mangmentv103/provider/credentialprovider/loginprovider.dart';
import 'package:mangmentv103/provider/credentialprovider/manager_provider.dart';
import 'package:mangmentv103/provider/credentialprovider/teamlead_provider.dart';
import 'package:provider/provider.dart';
import 'package:mangmentv103/provider/theme/theme_provider.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  @override
  void initState() {
    super.initState();

   

    // Set theme if required
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final themeProvider = Provider.of<ThemeProvider>(context, listen: false);
      if (!themeProvider.isDarkMode) {
        themeProvider.toggleTheme();
      }
    });
  }

  final TextEditingController _emailcontroller = TextEditingController();
  final TextEditingController _pwcontroller = TextEditingController();

  String level = "";
  int jobno = 0;
  bool _isLoading=false;

 
  void _clearTextField() {
    _formKey.currentState?.reset();
    _emailcontroller.clear();
    _pwcontroller.clear();
    setState(() {
    level = ""; // Reset radio selection
    jobno = 0;
  });
  }

  // Function to handle radio button selection
  void handleRadioValueChange(String? value) {
    setState(() {
      level = value!; // Set the selected value
      if (level == "Manager") {
        jobno = 1;
        print("Manager selected, jobno = $jobno");
      } else if (level == "Team_Lead") {
        jobno = 2;
        print("Team lead selected, jobno = $jobno");
      } else if (level == "Employee") {
        jobno = 3;
        print("Employee selected, jobno = $jobno");
      }
    });
  }

  final _formKey = GlobalKey<FormState>();

  void login(BuildContext context) async {
    final authService = AuthService();
    try {
      await authService.signInWithEmailPassword(
        _emailcontroller.text,
        _pwcontroller.text,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text(e.toString())),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Theme.of(context).colorScheme.primary,
      body: Stack(
        children: [
          Center(
            child: Form(
              key: _formKey,
              autovalidateMode:
                  AutovalidateMode.onUserInteraction, // Enable auto-validation
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.login_outlined,
                    size: 60,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  const SizedBox(height: 20),
          
                  Text(
                    "Welcome back, you've missed!",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.tertiary,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 25),
          
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Radio(
                        activeColor: Theme.of(context).colorScheme.inversePrimary,
                        value: "Employee",
                        groupValue: level,
                        onChanged: handleRadioValueChange,
                      ),
                      const Text("Employee", style: TextStyle(color: Colors.white)),
                      Radio(
                        activeColor: Theme.of(context).colorScheme.inversePrimary,
                        value: "Team_Lead",
                        groupValue: level,
                        onChanged: handleRadioValueChange,
                      ),
                      const Text(
                        "Team lead",
                        style: TextStyle(color: Colors.white),
                      ),
                      Radio(
                        activeColor: Theme.of(context).colorScheme.inversePrimary,
                        value: "Manager",
                        groupValue: level,
                        onChanged: handleRadioValueChange,
                      ),
                      const Text("Manager", style: TextStyle(color: Colors.white)),
                    ],
                  ),
          
                  const SizedBox(height: 25),
          
                  // Email TextField
                  MyTextField(
                    inputfromator: [],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your email';
                      }
                      if (!RegExp(
                        r'^[\w-\.]+@([\w-]+\.)+[\w]{2,4}',
                      ).hasMatch(value)) {
                        return 'Enter a valid email';
                      }
                      return null;
                    },
                    keyboardtype: TextInputType.emailAddress,
                    obscureText: false,
                    hintText: "Email",
                    controller: _emailcontroller,
                  ),
                  const SizedBox(height: 25),
          
                  // Password TextField
                  MyTextField(
                    inputfromator: [],
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter your password';
                      }
                      if (value.length < 6) {
                        return 'Password must be at least 6 characters long';
                      }
          
                      return null;
                    },
                    obscureText: true,
                    hintText: "Password",
                    controller: _pwcontroller,
                    keyboardtype: TextInputType.text,
                  ),
                  const SizedBox(height: 25),
          
                  // Login button
                  MyButton(
                    buttoncolor: Theme.of(context).colorScheme.inversePrimary,
                    text: "Login",
                    onTap: () async {
                      int valuetosend = jobno;
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
                        if (_emailcontroller.text.trim().isNotEmpty &&
                            _pwcontroller.text.trim().isNotEmpty &&
                            level != "") {

                              setState(() {
                                _isLoading=true;
                              });
                          FirebaseFirestore firebaseFirestore =
                              FirebaseFirestore.instance;
                          DocumentSnapshot response = await firebaseFirestore
                              .collection(level)
                              .doc(_emailcontroller.text)
                              .get();
                          if (response.exists) {
                            Map data = response.data() as Map;
                            log("${data}");
                            if (level == data["employee_role"]) {
                              try {
                                await FirebaseAuth.instance
                                    .signInWithEmailAndPassword(
                                        email: _emailcontroller.text.trim(),
                                        password: _pwcontroller.text.trim());

                                handleRadioValueChange(level);
          
                                Provider.of<LoginProvider>(
                                  context,
                                  listen: false,
                                ).setUserregter(
                                  UserData(
                                    email: _emailcontroller.text.trim(),
                                    password: _pwcontroller.text.trim(),
                                    userType: level,
                                    designation: jobno,
                                    name: data["name"],
                                   empid: int.tryParse(data["employee_id"].toString()),
                                  ),
                                );

                                
          
                                _clearTextField();
                                setState(() {
                                _isLoading=false;
                              });
                                Navigator.of(context).pushReplacement(MaterialPageRoute(builder:(context) => HomePage(),));
                              } on FirebaseAuthException catch (e) {
                                 setState(() {
                                _isLoading=false;
                              });
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(content: Text("${e.message}")));
                              }
                            }
                          } else {
                             setState(() {
                                _isLoading=false;
                              });
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                content:
                                    Text('Entered email or password is invalid.'),
                                backgroundColor: Colors.red,
                              ),
                            );
                          }
                        } else {
                          // Show error using setState or a SnackBar
                           setState(() {
                                _isLoading=false;
                              });
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Entered email or password is invalid.'),
                              backgroundColor: Colors.red,
                              behavior: SnackBarBehavior.floating,
                            ),
                          );
                        }
                      }
                    },
                  ),
                  const SizedBox(height: 25),
          
                  // Register link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Not a member?",
                        style: TextStyle(
                          fontSize: 18,
                          color: Theme.of(context).colorScheme.inversePrimary,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          _clearTextField();
                          Navigator.push(
                            context,
                            MaterialPageRoute(builder: (context) => Registerpage()),
                          );
                        },
                        child: Text(
                          " Register now",
                          style: TextStyle(
                            color: Theme.of(context).colorScheme.tertiary,
                            fontWeight: FontWeight.bold,
                            fontSize: 18,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          if (_isLoading)
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
