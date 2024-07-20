import 'package:carousel_slider/carousel_slider.dart';
import 'package:exam_e_commerce/extensions.dart';
import 'package:exam_e_commerce/utils/product_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DetailPage extends StatefulWidget {
  const DetailPage({super.key});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    Map<String, dynamic> Product =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    return Scaffold(
      appBar: AppBar(
        leading: GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: const Icon(
            CupertinoIcons.back,
          ),
        ),
        title: const Text("Detail Page"),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('cart_page');
            },
            icon: const Icon(
              CupertinoIcons.cart,
            ),
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Column(
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      backgroundImage: NetworkImage(
                        Product['thumbnail'],
                      ),
                    ),
                    SizedBox(
                      width: size.width * 0.050,
                    ),
                    Text(
                      Product['brand'] ?? "Local",
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 18,
                      ),
                    ),
                    Spacer(),
                    Text(
                      Product['rating'].toString(),
                      style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    RatingBar.builder(
                      allowHalfRating: true,
                      initialRating: Product['rating'].toDouble(),
                      itemCount: 5,
                      itemSize: 26,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                      onRatingUpdate: (rating) {},
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Image(
              image: NetworkImage(
                Product['thumbnail'],
              ),
            ),
            SizedBox(
              height: size.height * 0.03,
            ),
            Align(
              alignment: Alignment.center,
              child: Text(
                Product['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.w700,
                  fontSize: 24,
                ),
              ),
            ),
            SizedBox(
              height: 22,
            ),
            Text(
              Product['description'],
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(
              height: size.height * 0.02,
            ),
            Row(
              children: [
                Text(
                  "- ${Product['discountPercentage']}%",
                  style: const TextStyle(
                    color: Colors.red,
                    fontWeight: FontWeight.w500,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.02,
                ),
                Text(
                  "\$ ${Product['price']}",
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ],
            ),
            Row(
              children: [
                const Text(
                  "M.R.P : ",
                  style: TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ),
                SizedBox(
                  width: size.width * 0.02,
                ),
                Text(
                  "\$ ${double.parse((Product['price'] / (1 - Product['discountPercentage'] / 100)).toString()).of2}",
                  style: const TextStyle(
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.lineThrough,
                    fontSize: 16,
                  ),
                ),
              ],
            ),
            SizedBox(
              height: size.height * 0.10,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          if (!cartItem.contains(Product)) {
            cartItem.add(Product);
            Product['qty'] = 1;
          }
        },
        child: const Icon(CupertinoIcons.cart_badge_plus),
      ),
    );
  }
}
