// ignore_for_file: use_build_context_synchronously

import 'package:amazone_clone_app/constants/error_handling.dart';
import 'package:amazone_clone_app/constants/global_variables.dart';
import 'package:amazone_clone_app/constants/utils.dart';
import 'package:amazone_clone_app/model/user.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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
}
