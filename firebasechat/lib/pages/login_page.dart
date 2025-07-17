
import 'package:firebasechat/components/my_text_field_credentials.dart';
import 'package:flutter/material.dart';

import '../components/my_button.dart';
import '../services/auth/auth_service.dart';

class LoginPage extends StatelessWidget {
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController passwordTextController = TextEditingController();

  final Function()? onRegisterNowTap;

  LoginPage({super.key, required this.onRegisterNowTap});

  void login(BuildContext context) async {
    // get auth service
    final authService = AuthService();

    try {
      await authService.signInWithEmailPassword(
        emailTextController.text,
        passwordTextController.text,
      );
    } catch (e) {
      showDialog(
        context: context,
        builder: (context) => AlertDialog(title: Text(e.toString())),
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
              'Let\'s create an account for you',
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
            // email texfield
            const SizedBox(height: 10),

            // pw textfield
            MyTextFieldCredentials(
              hintText: 'Password',
              obscure: true,
              textController: passwordTextController,
            ),
            const SizedBox(height: 25),

            MyButton(text: "Login", onTap: () => login(context)),
            const SizedBox(height: 25),

            // register page
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Not a member? ",
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                GestureDetector(
                  onTap: onRegisterNowTap,
                  child: Text(
                    "Register now",
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
