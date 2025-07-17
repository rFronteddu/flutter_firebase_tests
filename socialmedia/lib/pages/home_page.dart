import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/components/my_drawer.dart';
import 'package:socialmedia/components/my_list_tile.dart';
import 'package:socialmedia/components/my_post_button.dart';
import 'package:socialmedia/components/my_text_field.dart';
import 'package:socialmedia/database/firestore.dart';

class HomePage extends StatelessWidget {
  HomePage({super.key});

  final FirestoreDatabase db = FirestoreDatabase();

  TextEditingController newPostController = TextEditingController();

  void postMessage() {
    // post only if there is something in the text field
    if (newPostController.text.isNotEmpty) {
      db.addPost(newPostController.text);
    }
    newPostController.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      appBar: AppBar(
        title: const Text("W A L L"),
        backgroundColor: Colors.transparent,
        foregroundColor: Theme.of(context).colorScheme.inversePrimary,
      ),
      drawer: const MyDrawer(),
      body: Column(
        children: [
          // text field box for user to type
          Padding(
            padding: const EdgeInsets.all(25),
            child: Row(
              children: [
                Expanded(
                  child: MyTextField(
                    hintText: "Say something",
                    obscureText: false,
                    textEditingController: newPostController,
                  ),
                ),
                MyPostButton(onTap: postMessage),
              ],
            ),
          ),

          // posts
          StreamBuilder(
            stream: db.getPostsStream(),
            builder: (context, snapshot) {
              // show loading circle
              if (snapshot.connectionState == ConnectionState.waiting) {
                return CircularProgressIndicator();
              }

              // get all posts
              final posts = snapshot.data!.docs;

              // no data
              if (snapshot.data == null || posts.isEmpty) {
                return const Center(
                  child: Padding(
                    padding: EdgeInsets.all(25.0),
                    child: Text("Nothing to see... Post something!"),
                  ),
                );
              }
              // return as list

              return Expanded(
                child: ListView.builder(
                  itemCount: posts.length,
                  itemBuilder: (context, index) {
                    // get individual post
                    final post = posts[index];

                    // get data from post
                    String msg = post['PostMessage'];
                    String userEmail = post['UserEmail'];
                    Timestamp timestamp = post['TimeStamp'];

                    // return as tile
                    return MyListTile(title: msg, subtitle: userEmail);
                  },
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
