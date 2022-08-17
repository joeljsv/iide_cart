import 'package:flutter/material.dart';
import 'package:iide_cart/models/cart.dart';
import 'package:provider/provider.dart';

import '../../provider/cart_provider.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<CartPro> cartitems =
        Provider.of<CartProvider>(context).cartProducts;
    // cart screen
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cart'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            const Text(
              "Your Cart",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: ListView.builder(
                itemCount: cartitems.length,
                itemBuilder: (context, index) {
                  if (cartitems.isEmpty) {
                    return const Text(
                      "No Items in Cart",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    );
                  }
                  return cartDisplay(cartitems, index, context);
                },
              ),
            ),
            // total price
            const SizedBox(
              height: 10,
            ),
            Text(
              "Total: ${Provider.of<CartProvider>(context).totalPrice}",
              style: const TextStyle(
                  fontSize: 20, fontWeight: FontWeight.bold, color: Colors.red),
            ),
            // checkout button
            const SizedBox(
              height: 10,
            ),
            ElevatedButton(
              style: ButtonStyle(
                  shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                          side: const BorderSide(color: Colors.red)))),
              child: const Text(
                "Checkout",
                style: TextStyle(color: Colors.white),
              ),
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                  content: Text("Order confirmed"),
                ));
                Provider.of<CartProvider>(context, listen: false).clearCart();
              },
            ),
          ],
        ),
      ),
    );
  }

  Padding cartDisplay(
      List<CartPro> cartitems, int index, BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: ListTile(
        leading: CircleAvatar(
          backgroundImage: NetworkImage(cartitems[index].product.thumbnail),
        ),
        title: Text(cartitems[index].product.title),
        subtitle: Text(
            "Rs.${cartitems[index].product.price}X ${cartitems[index].quantity}"),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            Provider.of<CartProvider>(context, listen: false)
                .removeFromCart(cartitems[index]);
          },
        ),
      ),
    );
  }
}
