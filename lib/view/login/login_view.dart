import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:food_delivery/common/color_extension.dart';
import 'package:food_delivery/common/extension.dart';
import 'package:food_delivery/common/globs.dart';
import 'package:food_delivery/common_widget/round_button.dart';
import 'package:food_delivery/view/login/rest_password_view.dart';
import 'package:food_delivery/view/login/sing_up_view.dart';
import 'package:food_delivery/view/on_boarding/on_boarding_view.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

import '../../common/service_call.dart';
import '../../common_widget/round_icon_button.dart';
import '../../common_widget/round_textfield.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  TextEditingController txtPhone = TextEditingController();
  TextEditingController txtPassword = TextEditingController();
  FirebaseAuth auth = FirebaseAuth.instance;

  bool isButtonClicked = false;
  bool codeSent = false; // Add this variable to track code sent status
  int countdown = 60; // Initial countdown value in seconds
  String verificationId = ''; // Add this variable to store the verificationId
  late List<TextEditingController?> otpControllers;
  bool cancelCountdown = false;

  // Start the countdown timer
  void startCountdownTimer() {
    const oneSecond = Duration(seconds: 1);
    Timer.periodic(oneSecond, (timer) {
      if (countdown == 0 || cancelCountdown) {
        timer.cancel();
      } else {
        setState(() {
          countdown--;
        });
      }
    });
  }

  // Empty all controllers of otpControllers
  void emptyControllers() {
    for (var controller in otpControllers) {
      controller!.clear();
    }
  }

  // Retry option: Trigger the verification process again
  void retryVerification() {
    setState(() {
      codeSent = false;
      countdown = 30; // Reset countdown value
    });
    serviceCallLogin({
      "phone": "+228${txtPhone.text}"
    }); // Trigger verification process again
  }

  @override
  Widget build(BuildContext context) {
    // var media = MediaQuery.of(context).size;

    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 25, horizontal: 25),
            child: isButtonClicked
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      OtpTextField(
                        handleControllers: (controllers) {
                          otpControllers = controllers;
                        },
                        numberOfFields: 6,
                        fieldWidth: 40,
                        showFieldAsBox: false,
                        onCodeChanged: (String code) {
                          // Handle validation or checks for the entered OTP code
                        },
                        onSubmit: (String verificationCode) async {
                          // This callback is triggered when the OTP code is completely entered
                          // Handle the verification process here
                          // Create a PhoneAuthCredential with the code
                          // print(verificationCode);
                          try {
                            PhoneAuthCredential credential =
                                PhoneAuthProvider.credential(
                                    verificationId: verificationId,
                                    smsCode: verificationCode);
                            emptyControllers();
                            // Sign the user in (or link) with the credential
                            await upsertUserWithCredential(credential);
                          } catch (e) {
                            mdShowAlert(
                              "Erreur",
                              "Code invalide, veuillez reessayer",
                              () {
                                emptyControllers();
                              },
                            );
                          }
                        },
                      ),
                      const SizedBox(height: 20),
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                            'Demander un nouveau code dans: $countdown secondes'),
                      ),
                      countdown == 0
                          ? ElevatedButton(
                              onPressed: retryVerification,
                              style: ElevatedButton.styleFrom(
                                foregroundColor: TColor.primary,
                                backgroundColor: Colors
                                    .white, // Text color of the button when enabled
                              ),
                              child: const Text('Resend Code'),
                            )
                          : Container(),
                    ],
                  )
                : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(
                        height: 64,
                      ),
                      Text(
                        "Connexion",
                        style: TextStyle(
                            color: TColor.primaryText,
                            fontSize: 30,
                            fontWeight: FontWeight.w800),
                      ),
                      Text(
                        "Enter les infos pour se connecter",
                        style: TextStyle(
                            color: TColor.secondaryText,
                            fontSize: 14,
                            fontWeight: FontWeight.w500),
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      RoundTextfield(
                        hintText: "Votre Numéro",
                        controller: txtPhone,
                        keyboardType: TextInputType.phone,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      // RoundTextfield(
                      //   hintText: "Mot de Passe",
                      //   controller: txtPassword,
                      //   obscureText: true,
                      // ),
                      const SizedBox(
                        height: 25,
                      ),
                      RoundButton(
                          title: "Connexion",
                          onPressed: () {
                            btnLogin();
                          }),
                      const SizedBox(
                        height: 4,
                      ),
                      // TextButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => const ResetPasswordView(),
                      //       ),
                      //     );
                      //   },
                      //   child: Text(
                      //     "Mot de Passe oublié?",
                      //     style: TextStyle(
                      //         color: TColor.secondaryText,
                      //         fontSize: 14,
                      //         fontWeight: FontWeight.w500),
                      //   ),
                      // ),
                      // const SizedBox(
                      //   height: 30,
                      // ),
                      // Text(
                      //   "ou Connexion Via",
                      //   style: TextStyle(
                      //       color: TColor.secondaryText,
                      //       fontSize: 14,
                      //       fontWeight: FontWeight.w500),
                      // ),
                      // const SizedBox(
                      //   height: 30,
                      // ),
                      // RoundIconButton(
                      //   icon: "assets/img/facebook_logo.png",
                      //   title: "Facebook",
                      //   color: const Color(0xff367FC0),
                      //   onPressed: () {},
                      // ),
                      // const SizedBox(
                      //   height: 25,
                      // ),
                      // RoundIconButton(
                      //   icon: "assets/img/google_logo.png",
                      //   title: "Google",
                      //   color: const Color(0xffDD4B39),
                      //   onPressed: () {},
                      // ),
                      // const SizedBox(
                      //   height: 80,
                      // ),
                      // TextButton(
                      //   onPressed: () {
                      //     Navigator.push(
                      //       context,
                      //       MaterialPageRoute(
                      //         builder: (context) => const SignUpView(),
                      //       ),
                      //     );
                      //   },
                      //   child: Row(
                      //     mainAxisSize: MainAxisSize.min,
                      //     children: [
                      //       Text(
                      //         "Première fois? ",
                      //         style: TextStyle(
                      //             color: TColor.secondaryText,
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.w500),
                      //       ),
                      //       Text(
                      //         "Inscription",
                      //         style: TextStyle(
                      //             color: TColor.primary,
                      //             fontSize: 14,
                      //             fontWeight: FontWeight.w700),
                      //       ),
                      //     ],
                      //   ),
                      // ),
                    ],
                  ),
          ),
        ),
      ),
    );
  }

  bool isPhoneNumber(String input) {
    final phoneRegex =
        RegExp(r'^\+?[0-9]+$'); // Define your phone number regex here

    return phoneRegex.hasMatch(input);
  }

  //TODO: Action
  void btnLogin() {
    if (!isPhoneNumber(txtPhone.text)) {
      mdShowAlert(Globs.appName, MSG.enterPhone, () {});
      return;
    }

    // if (txtPassword.text.length < 6) {
    //   mdShowAlert(Globs.appName, MSG.enterPassword, () {});
    //   return;
    // }

    endEditing();

    // Handle backend
    serviceCallLogin({
      "phone": txtPhone.text,
      "password": txtPassword.text,
      "push_token": ""
    });
  }

  Future<void> upsertUserWithCredential(PhoneAuthCredential credential) async {
    setState(() {
      cancelCountdown = true;
    });
    await auth.signInWithCredential(credential);

    ServiceCall.post({"firebase_id": auth.currentUser?.uid}, SVKey.svSignUp,
        withSuccess: (responseObj) async {
      Globs.hideHUD();
      print("hey");
      Globs.udSet(responseObj[KKey.payload] as Map? ?? {}, Globs.userPayload);
      Globs.udBoolSet(true, Globs.userLogin);

      Navigator.pushAndRemoveUntil(
          context,
          MaterialPageRoute(
            builder: (context) => const OnBoardingView(),
          ),
          (route) => false);
    }, failure: (err) async {
      Globs.hideHUD();
      mdShowAlert(Globs.appName, err.toString(), () {});
    });
  }

  //TODO: ServiceCall

  Future<void> serviceCallLogin(Map<String, dynamic> parameter) async {
    // Globs.showHUD();
    setState(() {
      isButtonClicked = true;
    });
    startCountdownTimer();
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+228${txtPhone.text}',
      verificationCompleted: (PhoneAuthCredential credential) async {
        print('code complete');
        // ANDROID ONLY!
        setState(() {
          codeSent =
              true; // Set codeSent to true when verification is completed
        });
        // Sign the user in (or link) with the auto-generated credential
        await upsertUserWithCredential(credential);
      },
      verificationFailed: (FirebaseAuthException e) {
        print(e.code);
        if (e.code == 'invalid-phone-number') {
          Globs.hideHUD();
          mdShowAlert(
              Globs.appName, 'The provided phone number is not valid.', () {});
        }

        // Handle other errors
      },
      codeSent: (String incomingVerificationId, int? resendToken) {
        // Update the UI - wait for the user to enter the SMS code
        print('code sent');
        setState(() {
          verificationId = incomingVerificationId;
          codeSent = true; // Set codeSent to true when code is sent
        });
        // String smsCode = '123456';
      },
      codeAutoRetrievalTimeout: (String verificationId) {
        setState(() {
          codeSent = false; // Set codeSent to false on timeout
        });
        // Globs.hideHUD();
        // mdShowAlert(Globs.appName, 'Auto-resolution timed out for verification',
        //     () {
        //   startCountdownTimer();
        //   //Here we would like to recall the serviceCallLogin function if the codeSent callback fails as well.
        // });
      },
    );
  }
}
