import 'package:firebasechat/components/my_drawer.dart';
import 'package:firebasechat/services/auth/auth_service.dart';
import 'package:firebasechat/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

import '../components/user_tile.dart';
import 'chat_page.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  // chat and auth service
  final ChatService _chatService = ChatService();
  final AuthService _authService = AuthService();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Home')),
      drawer: MyDrawer(),
      body: _buildUserList(),
    );
  }

  // build a list of users except for the current logged in user
  Widget _buildUserList() {
    return StreamBuilder(
      stream: _chatService.getUsersStream(),
      builder: (context, snapshot) {
        // error
        if (snapshot.hasError) {
          return const Text("Error");
        }
        // loading..
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Text("Loading..");
        }

        // return list view
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
    // display all users except current user
    final email = userData["email"];
    final receiverID = userData['uid'];
    if (email != _authService.getCurrentUser()!.email) {
      return UserTile(
        text: email,
        onTap: () {
          // tapped on a user => go to chat
          Navigator.push(
            context,
            MaterialPageRoute(
              builder:
                  (context) =>
                      ChatPage(receiverEmail: email, receiverID: receiverID),
            ),
          );
        },
      );
    } else {
      return Container();
    }
  }
}
