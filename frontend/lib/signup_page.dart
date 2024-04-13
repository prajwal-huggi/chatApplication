
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:frontend/format.dart';
import 'package:frontend/funcs.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() {
    return _SignUpPageState();
  }
}

class _SignUpPageState extends State<SignUpPage> {
  TextEditingController usernameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Service service = Service();
  Format data = Format();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Signup'),
          leading: BackButton(onPressed: () => Navigator.of(context).pop()),
        ),
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              //Desired username
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Username"),
                  const SizedBox(width: 10),
                  Flexible(
                    child: TextField(
                      controller: usernameController,
                      decoration: const InputDecoration(hintText: 'Username'),
                    ),
                  ),
                ],
              ),
              //email
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Email'),
                  Flexible(
                    child: TextField(
                      controller: emailController,
                      decoration: const InputDecoration(hintText: 'E-mail'),
                    ),
                  ),
                ],
              ),
              //Enter Password
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Enter Password"),
                  Flexible(
                    child: TextField(
                      controller: passwordController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration:
                          const InputDecoration(hintText: 'Enter password'),
                    ),
                  ),
                ],
              ),
              //Confirm Password
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Confirm Password"),
                  Flexible(
                    child: TextField(
                      controller: confirmPasswordController,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration:
                          const InputDecoration(hintText: 'Confirm Password'),
                    ),
                  ),
                ],
              ),
              // Submit button
              ElevatedButton(
                onPressed: () {
                  data.username = usernameController.text;
                  data.email = emailController.text;
                  data.password = passwordController.text;
                  data.confirmPassword = confirmPasswordController.text;

                  // newUser(Format data, BuildContext: context);
                  newUser(data: data, context: context);
                },
                child: const Text('Submit'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
