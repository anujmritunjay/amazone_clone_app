import 'package:amazone_clone_app/common/widgets/bottom_bar.dart';
import 'package:amazone_clone_app/features/admin/screens/add_product_screen.dart';
import 'package:amazone_clone_app/features/auth/screens/auth_screen.dart';
import 'package:amazone_clone_app/features/home/screens/category_deals_screen.dart';
import 'package:amazone_clone_app/features/home/screens/home_screen.dart';
import 'package:amazone_clone_app/features/product_details/screens/product_details_screen.dart';
import 'package:amazone_clone_app/features/search/screens/search_screen.dart';
import 'package:amazone_clone_app/model/product.dart';
import 'package:flutter/material.dart';

Route<dynamic> generateRoute(RouteSettings routeSettings) {
  switch (routeSettings.name) {
    case AuthScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const AuthScreen(),
      );
    case HomeScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const HomeScreen(),
      );
    case BottomBar.routeName:
      return MaterialPageRoute(
        builder: (_) => const BottomBar(),
      );
    case AddProductScreen.routeName:
      return MaterialPageRoute(
        builder: (_) => const AddProductScreen(),
      );
    case CategoryDealsScreen.routeName:
      var category = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => CategoryDealsScreen(
          category: category,
        ),
      );
    case SearchScreen.routeName:
      var searchQuery = routeSettings.arguments as String;
      return MaterialPageRoute(
        builder: (_) => SearchScreen(
          searchQuery: searchQuery,
        ),
      );
    case ProductDetailScreen.routeName:
      var product = routeSettings.arguments as Product;
      return MaterialPageRoute(
        builder: (_) => ProductDetailScreen(
          product: product,
        ),
      );
    default:
      return MaterialPageRoute(
        builder: (_) => const Scaffold(
          body: Center(
            child: Text('Screen does not exists'),
          ),
        ),
      );
  }
}
