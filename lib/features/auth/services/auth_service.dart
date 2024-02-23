// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazone_clone_app/common/widgets/bottom_bar.dart';
import 'package:amazone_clone_app/constants/error_handling.dart';
import 'package:amazone_clone_app/constants/global_variables.dart';
import 'package:amazone_clone_app/constants/utils.dart';
import 'package:amazone_clone_app/features/home/screens/home_screen.dart';
import 'package:amazone_clone_app/model/user.dart';
import 'package:amazone_clone_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  void singUpUser({
    required BuildContext context,
    required String email,
    required String name,
    required String password,
  }) async {
    try {
      User user = User(
        id: '',
        name: name,
        email: email,
        password: password,
        address: '',
        type: '',
        token: '',
        cart: [],
      );

      http.Response res = await http.post(Uri.parse('$uri/auth/sign-up'),
          body: user.toJson(),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      httpErrorHandle(
          response: res,
          onSuccess: () {
            showSnackbar(context,
                'Account has been created, Login with same credentials.');
          },
          context: context);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void singInUser({
    required BuildContext context,
    required String email,
    required String password,
  }) async {
    try {
      http.Response res = await http.post(Uri.parse('$uri/auth/log-in'),
          body: jsonEncode({'email': email, 'password': password}),
          headers: <String, String>{
            'Content-Type': 'application/json; charset=UTF-8'
          });
      httpErrorHandle(
          response: res,
          onSuccess: () async {
            var userData = jsonEncode(jsonDecode(res.body)['data']);
            final SharedPreferences prefs =
                await SharedPreferences.getInstance();
            Provider.of<UserProvider>(context, listen: false).setUser(userData);
            var token = jsonDecode(userData)['token'];
            await prefs.setString('auth-token', token);
            Navigator.pushNamedAndRemoveUntil(
                context, BottomBar.routeName, (route) => false);
          },
          context: context);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }

  void getUserData(BuildContext context) async {
    try {
      final SharedPreferences prefs = await SharedPreferences.getInstance();
      String? authToken = prefs.getString('auth-token');

      if (authToken == null) {
        prefs.setString('auth-token', '');
      }

      http.Response userRes = await http.get(Uri.parse('$uri/auth/me'),
          headers: <String, String>{
            'Content-Type': 'application/json;charset=UTF-8',
            'auth-token': authToken!
          });
      var isSuccess = jsonDecode(userRes.body)['success'];
      if (isSuccess) {
        var userData = jsonEncode(jsonDecode(userRes.body)['data']);
        var userProvider = Provider.of<UserProvider>(context, listen: false);
        userProvider.setUser(userData);
      } else {
        prefs.setString('auth-token', '');
      }
    } catch (e) {
      showSnackbar(context, e.toString());
    }
  }
}
