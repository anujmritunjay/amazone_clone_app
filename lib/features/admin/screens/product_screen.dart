import 'package:amazone_clone_app/common/widgets/loader.dart';
import 'package:amazone_clone_app/features/account/widgets/single_product.dart';
import 'package:amazone_clone_app/features/admin/screens/add_product_screen.dart';
import 'package:amazone_clone_app/features/admin/services/admin_service.dart';
import 'package:amazone_clone_app/model/product.dart';
import 'package:flutter/material.dart';

class ProductScreen extends StatefulWidget {
  const ProductScreen({super.key});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  List<Product>? products;
  AdminService adminService = AdminService();

  void navigateToAddProduct() {
    Navigator.pushNamed(context, AddProductScreen.routeName).then((value) {
      if (value == true) {
        fetchAllProducts();
      }
    });
  }

  void fetchAllProducts() async {
    products = await adminService.fetchAllProducts(context);
    setState(() {});
  }

  void deleteProduct(productData, index) {
    adminService.deleteProduct(context, productData, () {
      products!.removeAt(index);
      setState(() {});
    });
  }

  @override
  void initState() {
    fetchAllProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return products == null
        ? const Loader()
        : Scaffold(
            body: GridView.builder(
              itemCount: products!.length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2),
              itemBuilder: (context, index) {
                final productData = products![index];
                return Column(
                  children: [
                    SizedBox(
                      height: 140,
                      child: SingleProduct(
                        image: productData.images[0],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: Text(
                            productData.name,
                            overflow: TextOverflow.ellipsis,
                            maxLines: 2,
                          ),
                        ),
                        IconButton(
                          onPressed: () => deleteProduct(productData, index),
                          icon: const Icon(
                            Icons.delete_outline,
                          ),
                        ),
                      ],
                    ),
                  ],
                );
              },
            ),
            floatingActionButton: SizedBox(
              height: 70,
              width: 70,
              child: FloatingActionButton(
                backgroundColor: const Color.fromARGB(255, 29, 201, 192),
                tooltip: 'Add a Product',
                foregroundColor: Colors.black,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(50)),
                onPressed: navigateToAddProduct,
                child: const Icon(Icons.add),
              ),
            ),
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
          );
  }
}
