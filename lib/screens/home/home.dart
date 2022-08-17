
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/cart_provider.dart';
import '../../provider/product_provider.dart';
import 'products_sisplay.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Future<String> getData() async {
    await Provider.of<ProductProvider>(context, listen: false)
        .fetchAndSetProducts();
    return "done";
  }

  @override
  Widget build(BuildContext context) {
    // future builder to get data from api

    return FutureBuilder(
      future: getData(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
              actions: [
                InkWell(
                  onTap: () => Navigator.pushNamed(context, '/cart'),
                  child: Chip(
                    padding: const EdgeInsets.all(10),
                    avatar: const Icon(Icons.shopping_cart),
                    labelPadding: const EdgeInsets.all(5),
                    backgroundColor: Colors.indigo,
                    label: Text(
                        '${Provider.of<CartProvider>(context).itemCont}',
                        style: const TextStyle(color: Colors.white)),
                  ),
                ),
              ],
            ),
            body: const ProductDisplay(),
          );
        } else {
          return Scaffold(
            appBar: AppBar(
              title: const Text('Home'),
            ),
            body: const Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
    );
  }
}
