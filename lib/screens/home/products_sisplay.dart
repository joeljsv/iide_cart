import 'package:flutter/material.dart';
import 'package:iide_cart/provider/cart_provider.dart';
import 'package:provider/provider.dart';

import '../../models/product.dart';
import '../../provider/product_provider.dart';

class ProductDisplay extends StatelessWidget {
  const ProductDisplay({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // grid view to display products
    final List<Product> products = Provider.of<ProductProvider>(context).items;
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: GridView.builder(
        // physics: const BouncingScrollPhysics(),
        itemCount: products.length,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 3 / 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
        ),
        itemBuilder: (context, index) {
          return ProductItem(pro: products[index]);
        },
      ),
    );

    // list view to display products
  }
}

// product item widget
class ProductItem extends StatelessWidget {
  final Product pro;
  // ignore: use_key_in_widget_constructors
  const ProductItem({required this.pro});
  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(10),
      child: GridTile(
        header: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: CircleAvatar(
                radius: 18,
                child: IconButton(
                  icon: const Icon(Icons.shopping_cart_checkout),
                  color: Colors.white,
                  onPressed: () {
                    Provider.of<CartProvider>(context, listen: false)
                        .addToCart(pro);
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text("${pro.title} added to cart"),
                      duration: const Duration(milliseconds: 500),
                    ));
                  },
                ),
              ),
            ),
          ],
        ),
        footer: GridTileBar(
          backgroundColor: Colors.black87,
          // leading: Consumer<ProductProvider>(
          //   builder: (context, product, child) => IconButton(
          //     icon: Icon(
          //       product.isFavorite(id) ? Icons.favorite : Icons.favorite_border,
          //     ),
          //     color: Theme.of(context).accentColor,
          //     onPressed: () {
          //       product.toggleFavorite(id);
          //     },
          //   ),
          // ),
          trailing: Text(
            '₹${pro.price}',
            textAlign: TextAlign.center,
            style: const TextStyle(color: Colors.white),
          ),
          title: Text(
            pro.title,
            textAlign: TextAlign.center,
          ),
        ),
        child: Image.network(
          pro.thumbnail,
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}
