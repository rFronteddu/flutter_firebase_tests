import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:socialmedia/components/my_button.dart';
import 'package:socialmedia/components/my_text_field.dart';
import 'package:socialmedia/helper/helper_functions.dart';

class RegisterPage extends StatefulWidget {
  final void Function()? onTap;

  RegisterPage({super.key, required this.onTap});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final TextEditingController userTextController = TextEditingController();

  final TextEditingController emailTextController = TextEditingController();

  final TextEditingController passwordTextController = TextEditingController();

  final TextEditingController confirmPasswordTextController =
      TextEditingController();

  void register() async {
    // show loading circle
    showDialog(
      context: context,
      builder: (context) => const Center(child: CircularProgressIndicator()),
    );

    // make sure password and confirm password match
    if (passwordTextController.text != confirmPasswordTextController.text) {
      // pop loading circle
      Navigator.pop(context);

      // show error to user
      displayMsgToUser("Passwords don't match.", context);
    } else {
      // try creating the user
      try {
        // create user
        UserCredential? userCredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(
          email: emailTextController.text,
          password: passwordTextController.text,
        );
        // pop loading circle
        Navigator.pop(context);
      } on FirebaseAuthException catch (e) {
        Navigator.pop(context);
        displayMsgToUser(e.code, context);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(25.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // logo
              Icon(
                Icons.person,
                size: 80,
                color: Theme.of(context).colorScheme.inversePrimary,
              ),
              const SizedBox(height: 25),

              //title
              Text("M I N I M A L", style: TextStyle(fontSize: 20)),
              const SizedBox(height: 50),

              // user
              MyTextField(
                hintText: "username",
                obscureText: false,
                textEditingController: userTextController,
              ),
              const SizedBox(height: 10),

              // email
              MyTextField(
                hintText: "email",
                obscureText: false,
                textEditingController: emailTextController,
              ),
              const SizedBox(height: 10),

              // password
              MyTextField(
                hintText: "password",
                obscureText: true,
                textEditingController: passwordTextController,
              ),
              const SizedBox(height: 10),

              // password
              MyTextField(
                hintText: "confirm password",
                obscureText: true,
                textEditingController: confirmPasswordTextController,
              ),
              const SizedBox(height: 10),

              // forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // sign in button
              MyButton(text: "Register", onTap: register),
              const SizedBox(height: 25),

              // no account? register here
              Row(
                children: [
                  Text(
                    "Already have an account?",
                    style: TextStyle(
                      color: Theme.of(context).colorScheme.inversePrimary,
                    ),
                  ),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      " Login Here",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
