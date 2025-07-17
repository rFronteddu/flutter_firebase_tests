import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  void logout() {
    FirebaseAuth.instance.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            children: [
              // drawer head
              DrawerHeader(child: Icon(Icons.favorite)),

              const SizedBox(height: 25),

              // home tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.home,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: const Text("H O M E"),
                  onTap: () {
                    // we are already here, just pop the drawer
                    Navigator.pop(context);
                  },
                ),
              ),

              // profile tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.person,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: const Text("P R O F I L E"),
                  onTap: () {
                    // we are already here, just pop the drawer
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/profile_page");
                  },
                ),
              ),

              // users tile
              Padding(
                padding: const EdgeInsets.only(left: 25.0),
                child: ListTile(
                  leading: Icon(
                    Icons.person_search,
                    color: Theme.of(context).colorScheme.inversePrimary,
                  ),
                  title: const Text("U S E R S"),
                  onTap: () {
                    // we are already here, just pop the drawer
                    Navigator.pop(context);
                    Navigator.pushNamed(context, "/users_page");
                  },
                ),
              ),

            ],
          ),
          // LOGOUT
          Padding(
            padding: const EdgeInsets.only(left: 25.0, bottom: 25.0),
            child: ListTile(
              leading: Icon(
                Icons.logout,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              title: const Text("L O G O U T"),
              onTap: () {
                // we are already here, just pop the drawer
                Navigator.pop(context);
                logout();
              },
            ),
          ),
        ],
      ),
    );
  }
}
