// ignore_for_file: depend_on_referenced_packages

import 'dart:convert';
import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'model_http_exception.dart';

class Authentication with ChangeNotifier {
  String authenticationToken;
  DateTime authenticationTokenExpiryDate;
  String authenticationUserId;
  Timer authenticationTimer;

  bool get isAuthenticated {
    return getAuthenticationToken != null;
  }

  String get getAuthenticationUserId {
    return authenticationUserId;
  }

  String get getAuthenticationToken {
    if (authenticationTokenExpiryDate != null &&
        authenticationTokenExpiryDate.isAfter(DateTime.now()) &&
        authenticationToken != null) {
      return authenticationToken;
    }
    return null;
  }

  Future<void> userAuthentication(String userEmail, String userPassword, String urlSegment) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyC2P-w8gQYHrDCLX-BLXm2n-0AUXvaJ-jk";
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'email': userEmail,
            'password': userPassword,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = json.decode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
      authenticationToken = responseData['idToken'];
      authenticationUserId = responseData['localId'];
      authenticationTokenExpiryDate = DateTime.now().add(
        Duration(
          seconds: int.parse(
            responseData['expiresIn'],
          ),
        ),
      );
      autoLogOut;
      notifyListeners();
      final sharedPreferences = await SharedPreferences.getInstance();
      final storedUserData = json.encode(
        {
          'Authentication Token': authenticationToken,
          'authentication User Id': authenticationUserId,
          'authentication Token Expiry Date':
              authenticationTokenExpiryDate.toIso8601String(),
        },
      );
      sharedPreferences.setString('storedUserData', storedUserData);
    } catch (error) {
      rethrow;
    }
  }



  Future<void> userRegister(String userEmail, String userPassword) async {
    return userAuthentication(
      userEmail,
      userPassword,
      "signUp",
    );
  }

  Future<void> userLogIn(String userEmail, String userPassword) async {
    return userAuthentication(
      userEmail,
      userPassword,
      "signInWithPassword",
    );
  }
  Future<bool> autoLogIn() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (!sharedPreferences.containsKey('storedUserData')) {
      return false;
    }
    final extractedUserData = json.decode(
      sharedPreferences.getString('storedUserData'),
    ) as Map<String, Object>;
    final expireDate =
    DateTime.parse(extractedUserData['authentication Token Expiry Date']);

    if (expireDate.isBefore(DateTime.now())) {
      return false;
    }
    authenticationToken = extractedUserData['authentication Token'];
    authenticationUserId = extractedUserData['authentication User Id'];
    authenticationTokenExpiryDate = expireDate;
    notifyListeners();
    autoLogOut();
    return true;
  }
  Future<void> userLogOut() async {
    authenticationUserId = null;
    authenticationToken = null;
    authenticationTokenExpiryDate = null;
    if (authenticationTimer != null) {
      authenticationTimer.cancel();
      authenticationTimer = null;
    }
    notifyListeners();
    final prefs = await SharedPreferences.getInstance();
    // prefs.remove('storedUserData'); //clear specific data
    prefs.clear(); //clear all data
  }


  void autoLogOut() {
    if (authenticationTimer != null) {
      authenticationTimer.cancel();
    }
    final timeLeft = authenticationTokenExpiryDate.difference(DateTime.now()).inSeconds;
    authenticationTimer = Timer(
      Duration(seconds: timeLeft),
      userLogOut,
    );
  }
}
