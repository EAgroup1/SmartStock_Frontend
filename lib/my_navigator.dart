
import 'package:flutter/material.dart';
import 'package:rlbasic/pantallas/company/company.dart';
import 'package:rlbasic/pantallas/company/config_company.dart';
import 'package:rlbasic/pantallas/deliverer/deliverer.dart';
import 'package:rlbasic/pantallas/login.dart';
import 'package:rlbasic/pantallas/register.dart';
import 'package:rlbasic/pantallas/termsAndConditions.dart';
import 'package:rlbasic/pantallas/user/config_user.dart';
import 'package:rlbasic/pantallas/user/delivery_menu.dart';
import 'package:rlbasic/pantallas/forgotPassword.dart';
import 'package:rlbasic/pantallas/createNewPassword.dart';
import 'package:rlbasic/pantallas/user/search_products.dart';

var routes = <String, WidgetBuilder>{
  "/login": (BuildContext context) => LoginPage(),
  "/company": (BuildContext context) => CompanyPage(),
  "/deliverer": (BuildContext context) => DelivererPage(),
  "/configuser": (BuildContext context) => ConfigUserPage(),
  "/register": (BuildContext context) => RegisterPage(),
  "/TermsConditions": (BuildContext context) => TermsAndConditionsPage(),
  "/configcompany": (BuildContext context) => ConfigCompanyPage(),
  "/user/searchproducts": (BuildContext context) => SearchProductsPage(),
  "/user/forgotpassword": (BuildContext context) => ForgotPasswordPage(),
  //"/createNewPassword": (BuildContext context) => ?Page(),
  //"/user": (BuildContext context) => UserPage(),
 // "/user/deliveries": (BuildContext context) => DeliveryMenu(id: String id),
};

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

  static void goToUserDeliveryMenu(BuildContext context) {
    Navigator.pushNamed(context, "/user/deliveries");
  }

  static void goToSearchProducts(BuildContext context) {
    Navigator.pushNamed(context, "/user/searchproducts");
  }

  static void goToForgotPassword(BuildContext context) {
    Navigator.pushNamed(context, "/user/forgotpassword");
  }

}
