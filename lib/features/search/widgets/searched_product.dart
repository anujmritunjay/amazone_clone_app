import 'package:amazone_clone_app/common/widgets/stars.dart';
import 'package:amazone_clone_app/model/product.dart';
import 'package:flutter/material.dart';

class Searched extends StatelessWidget {
  final Product product;
  const Searched({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 10,
          ),
        ),
        const SizedBox(height: 10),
        Row(
          children: [
            Image.network(
              product.images[0],
              fit: BoxFit.contain,
              width: 135,
              height: 135,
            ),
            Column(
              children: [
                Container(
                  width: 235,
                  padding: const EdgeInsets.symmetric(horizontal: 10),
                  child: Text(
                    product.name,
                    style: const TextStyle(
                      fontSize: 16,
                    ),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: const Stars(
                    rating: 5,
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: Text(
                    '\$${product.price}',
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                    maxLines: 2,
                  ),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10),
                  child: const Text('Eligible for FREE Shipping'),
                ),
                Container(
                  width: 235,
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  child: const Text(
                    'In Stock',
                    style: TextStyle(
                      color: Colors.teal,
                    ),
                    maxLines: 2,
                  ),
                ),
              ],
            )
          ],
        ),
      ],
    );
  }
}
