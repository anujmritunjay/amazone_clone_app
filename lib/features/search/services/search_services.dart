// ignore_for_file: use_build_context_synchronously

import 'dart:convert';

import 'package:amazone_clone_app/constants/error_handling.dart';
import 'package:amazone_clone_app/constants/global_variables.dart';
import 'package:amazone_clone_app/constants/utils.dart';
import 'package:amazone_clone_app/model/product.dart';
import 'package:amazone_clone_app/providers/user_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:http/http.dart' as http;

class SearchServices {
  Future<List<Product>> fetchSearchedProduct({
    required BuildContext context,
    required String searchQuery,
  }) async {
    List<Product> productList = [];
    final userProvider = Provider.of<UserProvider>(context, listen: false);
    try {
      http.Response res = await http.get(
        Uri.parse('$uri/product/search/$searchQuery'),
        headers: {
          "Content-Type": "application/json; charset=UTF-8",
          "auth-token": userProvider.user.token
        },
      );
      httpErrorHandle(
          response: res,
          onSuccess: () {
            for (var i = 0; i < jsonDecode(res.body).length; i++) {
              productList.add(
                Product.fromJson(
                  jsonEncode(jsonDecode(res.body)[i]),
                ),
              );
            }
          },
          context: context);
    } catch (e) {
      showSnackbar(context, e.toString());
    }
    return productList;
  }
}
