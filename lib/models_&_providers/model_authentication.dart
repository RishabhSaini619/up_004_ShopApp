import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'model_http_exception.dart';

class Authentication with ChangeNotifier {
  String authenticationToken;
  DateTime authenticationTokenExpiryDate;
  String authenticationUserId;

  Authentication({
    this.authenticationToken,
    this.authenticationTokenExpiryDate,
    this.authenticationUserId,
  });

  Future<void> userAuthentication(
    String userEmail,
    String userPassword,
    String urlSegment,
  ) async {
    final url =
        "https://identitytoolkit.googleapis.com/v1/accounts:$urlSegment?key=AIzaSyC2P-w8gQYHrDCLX-BLXm2n-0AUXvaJ-jk";
    try {
      final response = await http.post(
        url,
        body: jsonEncode(
          {
            'email': userEmail,
            'password': userPassword,
            'returnSecureToken': true,
          },
        ),
      );
      final responseData = jsonDecode(response.body);
      if (responseData['error'] != null) {
        throw HttpException(responseData['error']['message']);
      }
    } catch (error) {
      rethrow;
    }
  }

  Future<void> userRegister(String userEmail, String userPassword) async {
    return userAuthentication(userEmail, userPassword, "signUp");
  }

  Future<void> userLogIn(String userEmail, String userPassword) async {
    return userAuthentication(userEmail, userPassword, "signInWithPassword");
  }
}
