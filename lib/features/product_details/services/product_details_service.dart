// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:io';

import 'package:amazone_clone_app/constants/error_handling.dart';
import 'package:amazone_clone_app/constants/global_variables.dart';
import 'package:amazone_clone_app/constants/utils.dart';
import 'package:amazone_clone_app/model/product.dart';
import 'package:amazone_clone_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class ProductDetailsServices {
  void rateProduct(
      {required BuildContext context,
      required Product product,
      required double rating}) async {
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.post(
        Uri.parse('$uri/product/product-rating'),
        headers: {
          'Content-Type': 'application/json; charset=UTF-8',
          'auth-token': userProvider.user.token
        },
        body: jsonEncode({"id": product.id, "rating": rating}),
      );
      httpErrorHandle(response: res, onSuccess: () {}, context: context);
    } catch (e) {
      print(e.toString());
      showSnackbar(context, e.toString());
    }
  }
}
