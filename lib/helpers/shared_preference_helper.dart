//import 'package:shared_preferences/shared_preferences.dart';
import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesHelper {
  static Future<bool> setLoginFlag(bool flag) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("isLoggedIn", flag);
  }

  static Future<bool> getLoginFlag() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("isLoggedIn") ?? false;
  }


  static Future<bool> setAccountsType(String accountsType) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("accounts_type", accountsType);
  }

  static Future<String> getAccountsType() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("accounts_type") ?? ''; // 4293467747
  }

  static Future<bool> setEmailAddress(String emailAddress) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("accounts_email_address", emailAddress);
  }

  static Future<String> getEmailAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("accounts_email_address") ?? ''; // 4293467747
  }

  static Future<bool> setToken(String? token) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("accesstoken", token!);
  }

  static Future<String> getToken() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("accesstoken") ?? ''; // 4293467747
  }

  static Future<bool> setLoginUserId(int userId) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setInt("loginUserId", userId);
  }

  static Future<int> getLoginUserId() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getInt("loginUserId") ?? 0;
  }

  static Future<bool> setLoginUserName(username) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("user_name", username ?? '');
  }

  static Future<String> getLoginUserName() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_name") ?? '';
  }

  static Future<bool> setLoginUserMobileNo(mobileno) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("user_mobile_no", mobileno ?? '');
  }

  static Future<String> getLoginUserMobileNo() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("user_mobile_no") ?? '';
  }


  static Future<bool> setUserAddress(String user_address) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString("address", user_address);
  }

  static Future<String> getUserAddress() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString("address") ?? ''; // 4293467747
  }

  static Future<bool> setIsCustomerAccount(bool isCustomerAccount) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("is_customer_account", isCustomerAccount);
  }

  static Future<bool> getIsCustomerAccount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("is_customer_account") ?? false;
  }

  static Future<bool> setIsAdminAccount(bool isAdminAccount) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("is_admin_account", isAdminAccount);
  }

  static Future<bool> getIsAdminAccount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("is_admin_account") ?? false;
  }

  static Future<bool> setIsSupplierAccount(bool isSupplierAccount) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("is_supplier_account", isSupplierAccount);
  }

  static Future<bool> getIsSupplierAccount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("is_supplier_account") ?? false;
  }

  static Future<bool> setIsDeliveryAccount(bool isDeliveryAccount) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setBool("is_delivery_account", isDeliveryAccount);
  }

  static Future<bool> getIsDeliveryAccount() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool("is_delivery_account") ?? false;
  }
}
