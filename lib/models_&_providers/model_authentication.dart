import 'dart:convert';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

class Authentication with ChangeNotifier {
  String authenticationToken;
  DateTime authenticationTokenExpiryDate;
  String authenticationUserId;

  Authentication({
    this.authenticationToken,
    this.authenticationTokenExpiryDate,
    this.authenticationUserId,
  });

  Future<void> userRegister(String userEmail, String userPassword) async {
    const url =
        "https://identitytoolkit.googleapis.com/v1/accounts:signUp?key=AIzaSyC2P-w8gQYHrDCLX-BLXm2n-0AUXvaJ-jk";
   final response = await http.post(
      url,
      body: jsonEncode(
        {
          'email':userEmail,
          'password' :userPassword,
          'returnSecureToken':true,
        },
      ),
    );
   print(jsonDecode(response.body));
  }
}
