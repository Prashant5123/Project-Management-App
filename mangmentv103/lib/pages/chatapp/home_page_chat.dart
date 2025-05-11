import 'package:flutter/material.dart';
import 'package:mangmentv103/components/my_drawer_chat.dart';
import 'package:mangmentv103/components/my_usertile.dart';
import 'package:mangmentv103/pages/chatapp/chatpage.dart';
import 'package:mangmentv103/pages/loginregister/functions.dart';
import 'package:mangmentv103/services/chats/chat_services.dart';

class HomePagechat extends StatelessWidget {
  HomePagechat({super.key});

  //chat & auth Services
  final chatService _chatServices = chatService();
  final AuthService _authService = AuthService();
  void logout() {
    final _auth = AuthService();
    _auth.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        foregroundColor: Colors.grey.shade700,
        title: const Text(
          "CHiTCHaT",
          style: TextStyle(
            color: Color.fromARGB(255, 33, 121, 34),
            fontWeight: FontWeight.bold,
          ),
        ),
        iconTheme: const IconThemeData(
          color: Color.fromARGB(255, 100, 100, 100),
        ),
      ),
      drawer: const MyDrawerchat(),
      drawerEnableOpenDragGesture: true,
      body: _buildUserList(),
    );
  }

  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatServices.getUserStream(),
      builder: (context, snapshot) {
        //error
        if (snapshot.hasError) {
          return const Text("Error");
        }

        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }

        //return ListView
        return ListView(
          children:
              snapshot.data!
                  .map<Widget>(
                    (userData) => _buildUserListItem(userData, context),
                  )
                  .toList(),
        );
      },
    );
  }

  Widget _buildUserListItem(
    Map<String, dynamic> userData,
    BuildContext context,
  ) {
    if (userData["email"] != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: userData["email"],
        onTap: () {
          //tapped on user -> go to chat page
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) => ChatPage(
                    receiverEmail: userData["email"],
                    receiverID: userData["uid"],
                  ),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
