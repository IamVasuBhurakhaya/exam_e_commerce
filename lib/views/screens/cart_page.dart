import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/product_utils.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  double totalPrice = 0;

  @override
  void initState() {
    super.initState();
    calculateTotalPrice();
  }

  void calculateTotalPrice() {
    totalPrice = 0;
    cartItem.forEach((elem) {
      totalPrice += (elem['price'] * elem['qty']);
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        // leading: IconButton(
        //   onPressed: () {
        //     Navigator.of(context)
        //         .pushNamedAndRemoveUntil('home_page', (route) => false);
        //   },
        //   icon: const Icon(
        //     CupertinoIcons.back,
        //   ),
        // ),
        title: const Text("Cart Page"),
      ),
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: cartItem.isEmpty
                ? const Center(
                    child: Image(
                      image: NetworkImage(
                        "https://i.pinimg.com/originals/81/c4/fc/81c4fc9a4c06cf57abf23606689f7426.jpg",
                      ),
                    ),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        ...cartItem
                            .map(
                              (e) => Container(
                                margin: const EdgeInsets.only(bottom: 16),
                                padding: const EdgeInsets.all(16),
                                height: size.height * 0.25,
                                width: size.width * 0.9,
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                  ),
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(14),
                                  ),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.2),
                                      spreadRadius: 2,
                                      blurRadius: 5,
                                      offset: const Offset(0, 3),
                                    ),
                                  ],
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      children: [
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(8),
                                          child: Image(
                                            image: NetworkImage(
                                              e['thumbnail'],
                                            ),
                                            height: 120,
                                            width: 120,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 15,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                e['title'],
                                                style: const TextStyle(
                                                  fontSize: 20,
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                              const SizedBox(height: 5),
                                              Text(
                                                '\$${e['price'].toStringAsFixed(2)}',
                                                style: const TextStyle(
                                                  fontSize: 24,
                                                  color: Colors.green,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(height: 10),
                                    Row(
                                      children: [
                                        Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                if (e['qty'] <= 1) {
                                                  cartItem.remove(e);
                                                } else {
                                                  e['qty']--;
                                                }
                                                calculateTotalPrice();
                                              });
                                            },
                                            icon: const Icon(Icons.remove),
                                            iconSize: 20,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Text(
                                          e['qty'].toString(),
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                        const SizedBox(width: 10),
                                        Container(
                                          height: 35,
                                          width: 35,
                                          decoration: BoxDecoration(
                                            border:
                                                Border.all(color: Colors.grey),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          child: IconButton(
                                            onPressed: () {
                                              setState(() {
                                                e['qty']++;
                                                calculateTotalPrice();
                                              });
                                            },
                                            icon: const Icon(Icons.add),
                                            iconSize: 20,
                                          ),
                                        ),
                                        const Spacer(),
                                        IconButton(
                                          onPressed: () {
                                            setState(() {
                                              cartItem.remove(e);
                                              calculateTotalPrice();
                                            });
                                          },
                                          icon: const Icon(Icons.delete),
                                          iconSize: 26, // Adjust icon size
                                        ),
                                        const SizedBox(
                                          width: 16,
                                        ),
                                        Text(
                                          '\$${(e['price'] * e['qty']).toInt().toString()}',
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            )
                            .toList(),
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: Container(
                            margin: const EdgeInsets.all(10),
                            padding: const EdgeInsets.all(16),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(color: Colors.grey.shade300),
                              borderRadius: BorderRadius.circular(10),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.2),
                                  spreadRadius: 3,
                                  blurRadius: 5,
                                  offset: const Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const Text(
                                  'Total:',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                Text(
                                  '\$${totalPrice.toStringAsFixed(2)}',
                                  style: const TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}
