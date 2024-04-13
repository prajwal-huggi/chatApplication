import 'package:flutter/material.dart';
import 'package:frontend/home_page.dart';
import 'package:email_otp/email_otp.dart';
import 'package:logger/logger.dart';

class OtpPage extends StatefulWidget {
  const OtpPage({super.key, required this.email});
  final String email;

  @override
  State<OtpPage> createState() {
    return _OtpPageState();
  }
}

class _OtpPageState extends State<OtpPage> {
  late final String userEmail;
  TextEditingController userEmailController = TextEditingController();
  TextEditingController otpController = TextEditingController();
  EmailOTP myAuth = EmailOTP();

  @override
  void initState() {
    super.initState();
    userEmail = widget.email;
    // userEmail = '21bt04040@gsfcuniversity.ac.in';
    Logger().i("INITSTATE $userEmail");
    sendOtp();
  }

  Future<void> sendOtp() async {
    final email = userEmail;
    myAuth.setConfig(
      appEmail: "kashmirapatel2004@gmail.com",
      appName: "Email OTP",
      userEmail: email,
      otpLength: 6,
      otpType: OTPType.digitsOnly,
    );

    myAuth.setSMTP(
      host: "smtp.gmail.com",
      auth: true,
      username: "kashmirapatel2004@gmail.com",
      password: "pdmh oxzu jcvo spmi",
      secure: "TLS",
      port: 587,
    );
    myAuth.setTheme(theme: "v1");

    if (myAuth.sendOTP() == true) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("OTP has been sent"),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Oops, OTP send failed"),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('OTP Verification'),
        leading: BackButton(
          onPressed: () => Navigator.of(context).pop(),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'OTP has been sent to $userEmail',
              style: const TextStyle(fontSize: 16),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: otpController,
                decoration: const InputDecoration(hintText: "Enter OTP"),
              ),
            ),
            ElevatedButton(
              onPressed: () async {
                if (await myAuth.verifyOTP(otp: otpController.text) == true) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("OTP is verified"),
                    ),
                  );

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const HomePage(),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text("Invalid OTP"),
                    ),
                  );
                }
              },
              child: const Text("Verify"),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:flutter/material.dart';
// import 'package:email_otp/email_otp.dart';
// import 'package:dummy/home_page.dart';
// import 'package:logger/logger.dart';

// class OtpPage extends StatefulWidget {
//   const OtpPage({Key? key, required this.email}) : super(key: key);
//   final String email;

//   @override
//   _OtpPageState createState() => _OtpPageState();
// }

// class _OtpPageState extends State<OtpPage> {
//   late final String userEmail;
//   TextEditingController otpController = TextEditingController();
//   EmailOTP myAuth = EmailOTP();

//   @override
//   void initState() {
//     super.initState();
//     userEmail = widget.email;
//     Logger().i(userEmail);
//     sendOtp();
//   }

//   Future<void> sendOtp()async {
//     myAuth.setConfig(
//       appEmail: "kashmirapatel2004@gmail.com",
//       appName: "Email OTP",
//       userEmail: userEmail,
//       otpLength: 6,
//       otpType: OTPType.digitsOnly,
//     );

//     myAuth.setSMTP(
//       host: "smtp.gmail.com",
//       auth: true,
//       username: "kashmirapatel2004@gmail.com",
//       password: "pdmh oxzu jcvo spmi",
//       secure: "TLS",
//       port: 587,
//     );
//     myAuth.setTheme(theme: "v1");

//     if (myAuth.sendOTP() == true) {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("OTP has been sent"),
//         ),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(
//           content: Text("Oops, OTP send failed"),
//         ),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('OTP Verification'),
//         leading: BackButton(
//           onPressed: () => Navigator.of(context).pop(),
//         ),
//       ),
//       body: Padding(
//         padding: const EdgeInsets.all(15),
//         child: Column(
//           mainAxisAlignment: MainAxisAlignment.center,
//           children: [
//             Text(
//               'OTP has been sent to $userEmail',
//               style: TextStyle(fontSize: 16),
//             ),
//             Padding(
//               padding: const EdgeInsets.all(8.0),
//               child: TextFormField(
//                 controller: otpController,
//                 decoration: const InputDecoration(hintText: "Enter OTP"),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () async {
//                 if (await myAuth.verifyOTP(otp: otpController.text) == true) {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text("OTP is verified"),
//                     ),
//                   );

//                   Navigator.push(
//                     context,
//                     MaterialPageRoute(
//                       builder: (context) => const HomePage(),
//                     ),
//                   );
//                 } else {
//                   ScaffoldMessenger.of(context).showSnackBar(
//                     const SnackBar(
//                       content: Text("Invalid OTP"),
//                     ),
//                   );
//                 }
//               },
//               child: const Text("Verify"),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
