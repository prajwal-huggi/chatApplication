import 'package:frontend/format.dart';
import 'package:frontend/login_page.dart';
import 'package:frontend/otp_page.dart';
import 'package:frontend/service.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';

import 'package:logger/logger.dart';

Logger logger = Logger();
Service service = Service();

Future<void> validateAndOtpPage(Format data, BuildContext context) async {
  // Validation
  // If user exist
  // if password correct
  // go to otp page

  Future<bool> emailAndPassword =
      service.validateUser(data.username, data.password);
  if (await emailAndPassword) {
    // Get an email with the help of username
    // Future<String> email= service.getEmail(data.username);
    // Future<String> email = service.getEmail(data.username);
    String email = await service.getEmail(data.username);

    // Logger().i("funcs:   ${email} and ${data.username}");
    
    Logger().i("The value of the email is $email");
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => OtpPage(email: email),
      ),
    );
  } else {
    // Fluttertoast.showToast(
    //     msg: "Username or password is incorrect",
    //     toastLength: Toast.LENGTH_SHORT,
    //     gravity: ToastGravity.BOTTOM,
    //     timeInSecForIosWeb: 1,
    //     // backgroundColor: Colors.blue,
    //     // textColor: Colors.black,
    //     fontSize: 16.0);
  }

  // logger.i(data.username);
  // logger.i(data.password);
}

Future<void> newUser(
    {required Format data, required BuildContext context}) async {
  // if password correct
  //First we will check whether the password and confirm password are same or not because we don't need database for it
  if (data.password != data.confirmPassword) {
    logger.i("Password and confirm password mismatch");
    //Create a custom toast to tell the user that the password entered is incorrect
    // Fluttertoast.showToast(
    //   msg: "The password entered is incorrect",
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.BOTTOM,
    //   timeInSecForIosWeb: 1,
    //   // backgroundColor: Colors.blue,
    //   // textColor: Colors.black,
    //   fontSize: 16.0,
    // );
    // Fluttertoast.showToast(
    //   msg: "The password entered is incorrect",
    //   toastLength: Toast.LENGTH_SHORT,
    //   gravity: ToastGravity.BOTTOM,
    //   timeInSecForIosWeb: 1,
    //   // backgroundColor: Colors.blue,
    //   // textColor: Colors.black,
    //   fontSize: 16.0,
    // );
  }

  //It means password and confirm password are same
  else {
    Future<bool> dataStore =
        service.saveUser(data.username, data.email, data.password);
    if (await dataStore) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const Login(),
        ),
      );
    } else {
      //Create a custom toast to tell the user that whether username or email is duplicated
      // Fluttertoast.showToast(
      //     msg: "Username or email is duplicate",
      //     toastLength: Toast.LENGTH_SHORT,
      //     gravity: ToastGravity.BOTTOM,
      //     timeInSecForIosWeb: 1,
      //     // backgroundColor: Colors.blue,
      //     // textColor: Colors.black,
      //     fontSize: 16.0);
    }
  }
}

void passwordReset(String email, BuildContext context) async {
    String baseURL = 'http://locahost:8080'; // Error
    String url = '$baseURL/forgot-password?usernameOrEmail=$email';
    try {
      var response = await http.post(
        Uri.parse(url),
      );

      if (response.statusCode == 200) {
        // Handle the response from the backend
        print('Password reset email sent successfully.');
      } else {
        // Handle other status codes (e.g., 404 for user not found)
        print(
            'Failed to send password reset email. Status code: ${response.statusCode}');
      }
    } catch (error) {
      // Handle any errors that occur during the request
      print('Error sending password reset request: $error');
    }
  }