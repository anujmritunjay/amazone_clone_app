import 'dart:convert';

import 'package:amazone_clone_app/constants/utils.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void httpErrorHandle(
    {required http.Response response,
    required VoidCallback onSuccess,
    required BuildContext context}) {
  switch (response.statusCode) {
    case 200:
      onSuccess();
      break;
    case 400:
      showSnackbar(context, jsonDecode(response.body)['message']);
      break;
    case 500:
      showSnackbar(context, jsonDecode(response.body)['message']);
      break;
    default:
      showSnackbar(context, jsonDecode(response.body)['message']);
      break;
  }
}
