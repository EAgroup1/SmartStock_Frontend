
import 'package:flutter/material.dart';
import 'package:rlbasic/pantallas/bankData.dart';
import 'package:rlbasic/pantallas/company/company.dart';
import 'package:rlbasic/pantallas/company/config_company.dart';
import 'package:rlbasic/pantallas/company/list_Stored_Products_Company.dart';
import 'package:rlbasic/pantallas/company/send_products.dart';
import 'package:rlbasic/pantallas/company/store_products.dart';
import 'package:rlbasic/pantallas/company/store_products_form.dart';
import 'package:rlbasic/pantallas/deliverer/deliverer.dart';
import 'package:rlbasic/pantallas/login.dart';
import 'package:rlbasic/pantallas/register.dart';
import 'package:rlbasic/pantallas/termsAndConditions.dart';
import 'package:rlbasic/pantallas/user/config_user.dart';
import 'package:rlbasic/pantallas/user/delivery_menu.dart';
import 'package:rlbasic/pantallas/forgotPassword.dart';
import 'package:rlbasic/pantallas/createNewPassword.dart';
import 'package:rlbasic/pantallas/user/principal_page_User.dart';
//user webchat views
import 'package:rlbasic/pantallas/webChatHomepage.dart';
import 'package:rlbasic/pantallas/webChat.dart';
//main list & subviews of this
import 'package:rlbasic/pantallas/user/listStoredProducts.dart';
import 'package:rlbasic/pantallas/user/salaryStoredProducts.dart';
import 'package:rlbasic/pantallas/user/selectStoredProducts.dart';
import 'package:rlbasic/pantallas/user/search_products.dart';
import 'package:rlbasic/pantallas/user/user.dart';

var routes = <String, WidgetBuilder>{
  "/login": (BuildContext context) => LoginPage(),
  "/company": (BuildContext context) => CompanyPage(),
  "/deliverer": (BuildContext context) => DelivererPage(),
  "/configuser": (BuildContext context) => ConfigUserPage(),
  "/register": (BuildContext context) => RegisterPage(),
  "/TermsConditions": (BuildContext context) => TermsAndConditionsPage(),
  "/configcompany": (BuildContext context) => ConfigCompanyPage(),
  "/user/searchproducts": (BuildContext context) => SearchProductsPage(),
  "/forgotpassword": (BuildContext context) => ForgotPasswordPage(),
  "/createnewpassword": (BuildContext context) => CreateNewPassword(),
  "/chathomepage": (BuildContext context) => AllChatsPage(),
  //"/chathomepage/webchat": (BuildContext context) => ChatPage(),
  "/user/lotlist": (BuildContext context) => ListProdPage(),
  "/user/lotlist/charts": (BuildContext context) => SalaryProductsGraph(),
  "/user/lotlist/selectedone": (BuildContext context) => SelProd(),
  "/user": (BuildContext context) => UserPage(),
  "/user/deliveries": (BuildContext context) => DeliveryMenu(),
  "/bankdata": (BuildContext context) => BankDataPage(),
  "/company/sendproducts": (BuildContext context) => SendProductsPage(),
  "/company/storeproducts": (BuildContext context) => StoreProductsPage(),
  "/company/storeproducts/add": (BuildContext context) => StoreProductsForm(),
  "/company/storeproductsstoredbyusers": (BuildContext context) => SearchMyStorageProductsPage(),
  "/dataGenericUser": (BuildContext context) => DataGenericUserPage(),
  

 
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

   static void goToBankData(BuildContext context) {
    Navigator.pushNamed(context, "/bankdata");
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

  static void goToCreateNewPassword(BuildContext context) {
    Navigator.pushNamed(context, "/user/createnewpassword");
  }

  static void goToWebChatHomepage(BuildContext context) {
    Navigator.pushNamed(context, "/chathomepage");
  }

  // static void goToWebChat(BuildContext context) {
  //   Navigator.pushNamed(context, "/chathomepage/webchat");
  // }

  static void goToLotList(BuildContext context) {
    Navigator.pushNamed(context, "/user/lotlist");
  }

  static void goToChartsLotList(BuildContext context) {
    Navigator.pushNamed(context, "/user/lotlist/charts");
  }

  static void goToSelecteOneLotList(BuildContext context) {
    Navigator.pushNamed(context, "/user/lotlist/selectedone");
  }

   static void goToSendProducts(BuildContext context) {
    Navigator.pushNamed(context, "/company/sendproducts");
  }

   static void goToStoreProducts(BuildContext context) {
    Navigator.pushNamed(context, "/company/storeproducts");
  }

  static void goToStoreProductsStoredByUsers(BuildContext context) {
    Navigator.pushNamed(context, "/company/storeproductsstoredbyusers");
  }

  static void goToStoreProductsAdd(BuildContext context) {
    Navigator.pushNamed(context, "/company/storeproducts/add");
  }

  static void goToDataUserGeneric(BuildContext context) {
    Navigator.pushNamed(context, "/dataGenericUser");
  }

}
