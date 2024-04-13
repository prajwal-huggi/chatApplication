import 'package:flutter/material.dart';
import 'package:frontend/funcs.dart';

class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() {
    return _ForgetPasswordState();
  }
}

class _ForgetPasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();
  String errorMessage = '';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Forgot Password'),
        ),
        body: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              TextField(
                controller: emailController,
                decoration: const InputDecoration(
                  hintText: 'Enter email',
                ),
              ),
              const SizedBox(height: 16.0),
              ElevatedButton(
                // onPressed: () {
                //   String usernameOrEmail = usernameOrEmailController.text;
                //   if (usernameOrEmail.isNotEmpty) {
                //     // Send request to backend with username or email
                //     sendResetPasswordRequest(usernameOrEmail);
                //   } else {
                //     setState(() {
                //       errorMessage = 'Please enter username or email';
                //     });
                //   }
                // },
                onPressed: () {
                  logger.i(emailController.text);
                  passwordReset(emailController.text, context);
                },
                child: const Text('Submit'),
              ),
              const SizedBox(height: 8.0),
              Text(
                errorMessage,
                style: const TextStyle(
                  color: Colors.red,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
