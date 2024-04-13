// import 'dart:convert';

// import 'package:http/http.dart' as http;
// import 'package:logger/logger.dart';

// Logger logger = Logger();

// class Service {
//   //Creating the method to save user
//   Future<void> saveUser(String username, String email, String password) async {
//     Logger().i("ENTER IN SERVICE AND saveUser method");
//     // //create url
//     // var uri = Uri.parse("http://localhost:8080/register");

//     // //header
//     // Map<String, String> headers = {"Content-Type": "application/json"};
//     // //body
//     // Map data = {
//     //   'username': username,
//     //   'email': email,
//     //   'password': password,
//     // };
// //conver the above data into json
//     // var body = json.encode(data);
//     // Logger().i(" Hello ");
//     // var response = await http.post(uri, headers: headers, body: body);

//     // //print the response body
//     // logger.i(response.body);

//     // return response;
//     try {
//       final url = Uri.parse("http://localhost:8080/register");
//       var dict = {
//         'username': username,
//         'email': email,
//         'password': password,
//       };

//       final response = await http.post(url, body: json.encode(dict));

//       if (response.statusCode == 200) {
//         logger.i("Data sent successfully");
//       } else {
//         logger.i("data not set");
//       }
//     } catch (error) {
//       logger.e("Catch Error: $error");
//     }
//   }
// }

import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:logger/logger.dart';

Logger logger = Logger();

class Service {
  // Creating the method to save user
  Future<bool> saveUser(String username, String email, String password) async {
    logger.i("Signup Page: User's info is checking and storing it in mysql");

    try {
      final url = Uri.parse("http://10.0.2.2:8080/register");
      var data = {
        'username': username,
        'email': email,
        'password': password,
      };

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        bool isUnique = jsonDecode(response.body);
        if (isUnique) {
          logger.i("Data stored in mysql successfully");
        } else {
          logger.i("username or email is registered");
        }
        return isUnique;
      } else {
        logger.e("Failed to send data. Status code: ${response.statusCode}");
        return false;
      }
    } catch (error) {
      logger.e("Catch Error: $error");
      return false;
    }
  }

  //Validating the user and jumping on the OTP page
  Future<bool> validateUser(String username, String password) async {
    logger.i("Login Page: User is validating ");

    try {
      final url = Uri.parse("http://10.0.2.2:8080/validate");
      var data = {
        'username': username,
        'password': password,
      };

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      );
      logger.i(response);

      if (response.statusCode == 200) {
        bool isValidate = jsonDecode(response.body);
        if (isValidate) {
          logger.i("User is validated and now jump to opt page");
        } else {
          logger.i("Eighter Username of Password is incorrect");
        }
        return isValidate;
      } else {
        logger.e("Failed to send data");
        return false;
      }
    } catch (error) {
      logger.e("Catch Error: $error");
      return false;
    }
  }

  //Getting the email to send the email from login page to otp page
  Future<String> getEmail(String username) async {
    logger.i("Getting the email");
    try {
      final url = Uri.parse("http://10.0.2.2:8080/getEmail");
      var data = {
        'username': username,
      };

      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(data),
      );

      if (response.statusCode == 200) {
        // logger.e("Insiee the if condition");
        String email = response.body;
        // String email = jsonDecode(response.body);
        // logger.e("email: $getEmail");
        // return getEmail;
        logger.i("sending reposnse " + email);
        return email;
        // return "21bt04027@gsfcuniversity.ac.in";
      } else {
        return "Failed";
      }
    } catch (error) {
      logger.e("Catch Error: $error");
      return "Catch Error: $error";
    }
  }
}
