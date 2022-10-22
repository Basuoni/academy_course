import 'dart:developer';

import 'package:academycourse/src/features/auth/presentation/pages/home.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../../config/app_route.dart';
import '../../../../core/utils/app_colors.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_text_field.dart';

class SignInScreen extends StatelessWidget {
  SignInScreen({Key? key}) : super(key: key);
 final formKey = GlobalKey<FormState>();
  final phoneCon = TextEditingController();
  final passwordCon = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Form(
          key: formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  'Sign In',
                  style: TextStyle(fontSize: 25, color: Colors.black),
                ),
                Container(
                    margin: const EdgeInsets.symmetric(vertical: 20),
                    width: double.infinity,
                    height: 150,
                    child: SvgPicture.asset("assets/sign_in.svg")),
                const SizedBox(height: 10),
                const Text(
                  'Sign in to view and manage your products',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                ),
                const SizedBox(height: 15),
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
                    child: const Text(
                      'Sign In',
                      style: TextStyle(fontSize: 18),
                    ),
                    onPressed: () async{
                      if (formKey.currentState!.validate()) {
                        bool value = await check();
                        if (value) {
                          // ignore: use_build_context_synchronously
                          Navigator.pushNamedAndRemoveUntil(context,AppRoute.homeRoute , (route) => false);
                        } else {
                          phoneCon.text = "";
                          passwordCon.text = "";
                        }
                      }
                    }),
                InkWell(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoute.signUpRoute);
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: const [
                      Text(
                        "Don't have an account? ",
                        style: TextStyle(fontSize: 15, color: Colors.grey),
                      ),
                      Text(
                        " Sign up",
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
  }

  Future<bool> check() async {
    final res = await FirebaseFirestore.instance
        .collection('users')
        .where("phone", isEqualTo: phoneCon.text)
        .where("password", isEqualTo: passwordCon.text)
        .get();
    bool ret = false;
    for (var element in res.docs) {
      ret = true;
      HomeScreen.name = element.data()["name"];
      log(element.toString());
    }
    return ret;
  }
}
