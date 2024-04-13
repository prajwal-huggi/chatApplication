import 'package:flutter/material.dart';
import 'package:frontend/format.dart';
import 'package:frontend/funcs.dart';
import 'package:frontend/signup_page.dart';
import 'package:frontend/forget_password_page.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() {
    return _LoginState();
  }
}

class _LoginState extends State<Login> {
  Format data = Format();
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
          body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            //Username
            Row(
              children: [
                const Text("Username: "),
                const SizedBox(width: 10),
                Flexible(
                  child: TextField(
                    onChanged: (text) {
                      data.username = text;
                    },
                    decoration:
                        const InputDecoration(hintText: "Enter Username"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            //Password
            Row(
              children: [
                const Text("Password:"),
                const SizedBox(width: 10),
                Flexible(
                  child: TextField(
                    obscureText: true,
                    enableSuggestions: false,
                    autocorrect: false,
                    onChanged: (text) {
                      data.password = text;
                    },
                    decoration: const InputDecoration(hintText: "Password"),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 10),
            //Forget Submit and SignUp button
            Row(
              children: [
                //Forget Password
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ForgetPassword()));
                  },
                  child: const Text('Forget Password'),
                ),
                const SizedBox(width: 10),

                //Submit Button
                ElevatedButton(
                  onPressed: () {
                    validateAndOtpPage(data, context);
                  },
                  child: const Text('Submit'),
                ),
                const SizedBox(width: 10),

                //SignUp Page
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SignUpPage()));
                  },
                  child: const Text("Sign Up"),
                ),
              ],
            )
          ],
        ),
      )),
    );
  }
}
