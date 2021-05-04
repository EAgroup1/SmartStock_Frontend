import 'package:flutter/material.dart';

class MyNavigator {
  static void goToLogin(BuildContext context) {
    Navigator.pushNamed(context, "/login");
  }

  static void goToUser(BuildContext context) {
    Navigator.pushNamed(context, "/user");
  }

  static void goToCompany(BuildContext context) {
    Navigator.pushNamed(context, "/company");
  }

  static void goToConfigUser(BuildContext context) {
    Navigator.pushNamed(context, "/configuser");
  }

   static void goToConfigCompany(BuildContext context) {
    Navigator.pushNamed(context, "/configcompany");
  }
   static void goToConfigDeliverer(BuildContext context) {
    Navigator.pushNamed(context, "/configdeliverer");
  }

  static void goToDeliverer(BuildContext context) {
    Navigator.pushNamed(context, "/deliverer");
  }

  static void goToRegister(BuildContext context) {
    Navigator.pushNamed(context, "/register");
  }

  static void goToTerms(BuildContext context) {
    Navigator.pushNamed(context, "/TermsConditions");
  }
}
