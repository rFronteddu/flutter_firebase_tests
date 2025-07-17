/*
This DB stores posts published in the app.
Stored in a collection called 'Posts' in Firebase

Each post contains
- a message
- email of user
- timestamp

 */

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirestoreDatabase {
  // current logged in user
  User? user = FirebaseAuth.instance.currentUser;

  // get collection of posts from firebase
  final CollectionReference posts = FirebaseFirestore.instance.collection('Posts');

  // post a message
  Future<void> addPost(String msg) {
    return posts.add( {
      'UserEmail': user!.email,
      'PostMessage': msg,
      'TimeStamp': Timestamp.now(),
    });
  }

  // read posts from db
  Stream<QuerySnapshot> getPostsStream () {
    final postsStream = FirebaseFirestore.instance.collection('Posts').orderBy(
      'TimeStamp', descending: true).snapshots();
    return postsStream;
  }

}