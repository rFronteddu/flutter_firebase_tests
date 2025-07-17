import 'package:flutter/material.dart';
import '../components/my_button.dart';

import '../components/my_text_field.dart';
import '../components/my_text_field_credentials.dart';
import '../services/auth/auth_service.dart';

class RegisterPage extends StatelessWidget {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();
  final TextEditingController passwordConfirmTextController =
      TextEditingController();

  final Function()? onSignInTap;

  RegisterPage({super.key, required this.onSignInTap});

  // register
  void register(BuildContext context) {
    if (passwordTextController.text ==
        passwordConfirmTextController.text) {
      try {
        // passwords match => create users
        AuthService().signUpWithAEmailAndPassword(
          emailTextController.text,
          passwordTextController.text,
        );
      } catch (e) {
        showDialog(
          context: context,
          builder: (context) => AlertDialog(title: Text(e.toString())),
        );
      }
    } else {
      // no match show error
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text("Passwords don't match")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.surface,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // logo
            Icon(
              Icons.message,
              size: 50,
              color: Theme.of(context).colorScheme.primary,
            ),
            const SizedBox(height: 50),
            // welcome back
            Text(
              'Welcome back you have been missed!',
              style: TextStyle(
                color: Theme.of(context).colorScheme.primary,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 50),

            MyTextFieldCredentials(
              hintText: 'Email',
              obscure: false,
              textController: emailTextController,
            ),
            // email text-field
            const SizedBox(height: 10),

            // pw text-field
            MyTextFieldCredentials(
              hintText: 'Password',
              obscure: true,
              textController: passwordTextController,
            ),

            const SizedBox(height: 10),

            MyTextFieldCredentials(
              hintText: 'Confirm Password',
              obscure: true,
              textController: passwordConfirmTextController,
            ),
            const SizedBox(height: 25),

            // register button
            MyButton(text: "Register", onTap: () => register(context)),
            const SizedBox(height: 25),

            // register page
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have an account? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: onSignInTap,
                  child: Text(
                    "Login now",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
