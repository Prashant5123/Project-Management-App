import 'package:flutter/material.dart';
import 'package:mangmentv103/pages/chatapp/home_page_chat.dart';
import 'package:mangmentv103/pages/chatapp/settingpage_chat.dart'
    show SettingsPage;
import 'package:mangmentv103/pages/loginregister/functions.dart';

class MyDrawerchat extends StatelessWidget {
  const MyDrawerchat({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.background,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              const SizedBox(height: 20),
              const Padding(
                padding: EdgeInsets.only(left: 8.0, top: 50),
                child: Icon(Icons.message, size: 40, color: Colors.green),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text("H O M E"),
                  leading: const Icon(
                    Icons.home,
                    color: Color.fromARGB(255, 56, 55, 55),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => HomePagechat()),
                    );
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  title: const Text("S E T T I N G S"),
                  leading: const Icon(
                    Icons.settings,
                    color: Color.fromARGB(255, 56, 55, 55),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => SettingsPage()),
                    );
                  },
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(left: 25.0),
            child: ListTile(
              title: const Text(
                "BACK WARD",
                style: TextStyle(color: Colors.red),
              ),
              leading: const Icon(
                Icons.logout,
                color: Color.fromARGB(255, 56, 55, 55),
              ),
              onTap: () {
                Navigator.pop(context);
                Navigator.pop(context);
              },
            ),
          ),
        ],
      ),
    );
  }
}
