import 'dart:developer';

import 'package:academycourse/src/config/app_route.dart';
import 'package:academycourse/src/core/utils/app_colors.dart';
import 'package:academycourse/src/core/widgets/app_button.dart';
import 'package:academycourse/src/features/auth/presentation/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

class OtpScreen extends StatelessWidget {
  const OtpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 40),
              Container(
                  margin: const EdgeInsets.symmetric(vertical: 20),
                  width: double.infinity,
                  height: 180,
                  child: SvgPicture.asset("assets/phone_verified.svg")),
              const SizedBox(height: 10),
              const Text(
                'Phone Verification',
                style: TextStyle(fontSize: 22, color: Colors.black),
              ),
              const SizedBox(height: 10),
              const Text(
                'You will receive a message through the number 01000836735',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(horizontal: 20),
                child: PinCodeTextField(
                  textInputAction: TextInputAction.go,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.underline,
                    borderRadius: BorderRadius.circular(5),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeFillColor: Colors.white,
                    selectedColor: AppColors.mainColor,
                    selectedFillColor: Colors.grey,
                    inactiveColor: Colors.grey,
                    activeColor: AppColors.mainColor,
                  ),
                  appContext: context,
                  length: 6,
                  cursorColor: AppColors.mainColor,
                  onChanged: (value) {},
                  onCompleted: (v) {
                    sendCode(v,context);
                  },
                  autoFocus: true,
                ),
              ),
              const SizedBox(height: 20),
              AppButton(
                  color: AppColors.mainColor,
                  child: const Text(
                    "Verification",
                    style: TextStyle(fontSize: 18),
                  ),
                  onPressed: () {})
            ],
          ),
        ),
      ),
    );
  }

  static String verificationId = "";
  static String name = "";
  static String password = "";
  static String phone = "";
  void sendCode(String code, BuildContext context) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: code);
      await FirebaseAuth.instance
          .signInWithCredential(credential)
          .then((value) {
        log(value.user.toString());
        FirebaseFirestore.instance.collection('users').add({
          "name" : name,
          "password" :password,
          "phone":phone
        }).then((value) {
          HomeScreen.name = name;
          Navigator.pushNamedAndRemoveUntil(context,AppRoute.homeRoute , (route) => false);
        });
      });
    } on FirebaseException catch (e) {
      return;
    } catch (e) {
      log(e.toString());
      return;
    }
  }
}
