import 'package:academycourse/src/config/app_route.dart';
import 'package:academycourse/src/core/utils/app_colors.dart';
import 'package:academycourse/src/core/widgets/app_button.dart';
import 'package:academycourse/src/core/widgets/app_text_field.dart';
import 'package:academycourse/src/features/auth/presentation/pages/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignUpScreen extends StatelessWidget {
  SignUpScreen({Key? key}) : super(key: key);
  final nameCon = TextEditingController();
  final phoneCon = TextEditingController();
  final passwordCon = TextEditingController();
  var formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Sign Up',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: double.infinity,
                    height: 150,
                    child: SvgPicture.asset("assets/sign_up.svg")),
                const SizedBox(height: 10),
                const Text(
                  'Sign up and start taking advantage of the administrator app',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 15),
                AppTextField(
                    hint: "Name",
                    prefixIcon: Icons.person_outline,
                    txtController: nameCon),
                AppTextField(
                  hint: "Phone",
                  type: TextInputType.phone,
                  prefixIcon: Icons.phone_outlined,
                  txtController: phoneCon,
                  validator: (it) {
                    if (it?.isEmpty == true) return 'Phone must not be empty';
                    if (it?.length != 11) {
                      return 'The phone number must be 11 digits';
                    }
                    return null;
                  },
                ),
                AppTextField(
                    isPassword: true,
                    hint: "Password",
                    prefixIcon: Icons.lock_outline,
                    txtController: passwordCon),
                AppButton(
                    color: AppColors.mainColor,
                    child: const Text('Sign Up'),
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        sendSMS(phoneCon.text,context);
                      }
                    }),
                InkWell(
                  onTap: () {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoute.signInRoute, (route) => false);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Already have an account? ",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      Text(
                        " Log in",
                        style:
                            TextStyle(fontSize: 15, color: AppColors.mainColor),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
    // international Phone Number Input
  }

  Future<void> sendSMS(String phoneNumber, BuildContext context) async {
    await FirebaseAuth.instance.verifyPhoneNumber(
      phoneNumber: '+2$phoneNumber',
      timeout: const Duration(seconds: 120),
      verificationCompleted: (PhoneAuthCredential credential) {},
      verificationFailed: (FirebaseAuthException e) {},
      codeSent: (String verificationId, int? resendToken) {
        OtpScreen.verificationId = verificationId;
        OtpScreen.name = nameCon.text;
        OtpScreen.password = passwordCon.text;
        OtpScreen.phone = phoneNumber;
        Navigator.pushNamed(context, AppRoute.otpRoute);
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }
}
