import 'package:flutter/material.dart';
import 'package:mangmentv103/components/aboutpage.dart';
import 'package:mangmentv103/components/my_settingpage.dart';

import 'package:mangmentv103/pages/loginregister/functions.dart'
    show AuthService;
import 'package:mangmentv103/pages/loginregister/login_page.dart';
import 'package:mangmentv103/pages/primarypage.dart';
import 'package:mangmentv103/provider/credentialprovider/loginprovider.dart';
import 'package:provider/provider.dart';

// ignore: must_be_immutable
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    LoginProvider loginprovider = Provider.of<LoginProvider>(context);
    Widget pagetosend() {
      if (loginprovider.userdata!.designation == 1) {
        return HomePage();
      } else if (loginprovider.userdata!.designation == 2) {
        return HomePage();
      } else {
        return HomePage();
      }
    }

    return Drawer(
      backgroundColor: Colors.transparent,
      //Color.fromRGBO(222, 223, 225, 255),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              const SizedBox(height: 25),
              ClipOval(
                child: Image.asset(
                  "assets/jpg/splash.jpg",
                  width: 200,
                  height: 200,
                  fit:
                      BoxFit
                          .cover, // Adjusts the image to fit within the circle
                ),
              ),
              const SizedBox(height: 20),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 5.0)],
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.home),
                      SizedBox(width: 5.0),
                      Text(
                        "HOME ",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => pagetosend()),
                  );
                },
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 5.0)],
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.settings),
                      SizedBox(width: 5.0),
                      Text(
                        "Setting ",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => SettingsPage()),
                  );
                },
              ),
              GestureDetector(
                child: Container(
                  decoration: BoxDecoration(
                    boxShadow: [BoxShadow(blurRadius: 5.0)],
                    color: Theme.of(context).colorScheme.secondary,
                    borderRadius: BorderRadius.circular(12),
                  ),
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      const Icon(Icons.group),
                      SizedBox(width: 5.0),
                      Text(
                        "About Us ",
                        style: TextStyle(
                          fontSize: 17,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ],
                  ),
                ),
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => aboutpage()),
                  );
                },
              ),
            ],
          ),
          GestureDetector(
            child: Container(
              decoration: BoxDecoration(
                boxShadow: [BoxShadow(blurRadius: 5.0)],
                color: Theme.of(context).colorScheme.secondary,
                borderRadius: BorderRadius.circular(12),
              ),
              margin: const EdgeInsets.all(20),
              padding: const EdgeInsets.all(16),
              child: Row(
                children: [
                  const Icon(Icons.logout, color: Color.fromARGB(255, 0, 0, 0)),
                  SizedBox(width: 5.0),
                  Text(
                    "LOGOUT ",
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.red,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
            onTap: () {
              Navigator.pop(context);
              final auth = AuthService();
              auth.signOut();
              print("Logout succesfull");
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
    );
  }
}
