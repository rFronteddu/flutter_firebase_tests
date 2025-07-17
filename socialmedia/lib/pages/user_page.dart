import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/components/my_list_tile.dart';
import 'package:socialmedia/helper/helper_functions.dart';

import '../components/my_back_button.dart';

class UsersPage extends StatelessWidget {
  const UsersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection("Users").snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            displayMsgToUser("Something went wrong", context);
          } else if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          if (snapshot.data == null) {
            return const Text("No Data");
          }

          final users = snapshot.data!.docs;
          return Column(
            children: [

              const Padding(
                padding: EdgeInsets.only(top: 50.0, left: 25),
                child: Row(children: [MyBackButton()]),
              ),
              const SizedBox(height: 25),

              Expanded(
                child: ListView.builder(
                  padding: EdgeInsets.all(0),
                  itemCount: users.length,
                  itemBuilder: (context, index) {
                    final user = users[index];
                    String username = user['username'];
                    String email = user['email'];
                    return MyListTile(title: username, subtitle: email);
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
