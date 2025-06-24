import 'package:flutter/material.dart';
import 'package:socialmedia/components/my_button.dart';
import 'package:socialmedia/components/my_text_field.dart';

class LoginPage extends StatefulWidget {
  final void Function()? onTap;

  const LoginPage({super.key, required this.onTap});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailTextController = TextEditingController();

  final TextEditingController passwordTextController = TextEditingController();

  void login() async {
    showDialog(context: context,
        builder: (context) => const Center(
          child: CircularProgressIndicator(),
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .surface,
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
                color: Theme
                    .of(context)
                    .colorScheme
                    .inversePrimary,
              ),
              const SizedBox(height: 25),

              //title
              Text("M I N I M A L", style: TextStyle(fontSize: 20)),
              const SizedBox(height: 50),

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

              // forgot password
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    "Forgot password?",
                    style: TextStyle(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .secondary,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 25),

              // sign in button
              MyButton(text: "Login", onTap: login),
              const SizedBox(height: 25),

              // no account? register here
              Row(
                children: [
                  Text("Don't have an account?",
                    style: TextStyle(
                      color: Theme
                          .of(context)
                          .colorScheme
                          .inversePrimary,
                    ),),
                  GestureDetector(
                    onTap: widget.onTap,
                    child: Text(
                      " Register Here",
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
