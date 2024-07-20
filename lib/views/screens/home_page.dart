import 'package:exam_e_commerce/utils/product_utils.dart';
import 'package:flexible_grid_view/flexible_grid_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

String Selected = "All";
RangeValues sliderValue = const RangeValues(1, 5000);

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              Navigator.of(context).pushNamed('cart_page');
            },
            icon: const Icon(
              Icons.shopping_cart,
              size: 34,
            ),
          )
        ],
      ),
      drawer: const Drawer(
        child: Column(
          children: [
            SizedBox(
              height: 30,
            ),
            Text(
              "Welcome",
              style: TextStyle(fontSize: 26),
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          top: 10,
        ),
        child: Column(
          children: [
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Explore",
                style: TextStyle(fontSize: 44, fontWeight: FontWeight.bold),
              ),
            ),
            const Align(
              alignment: Alignment.topLeft,
              child: Text(
                "Fashion is all about beauty",
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey,
                ),
              ),
            ),
            const SizedBox(
              height: 26,
            ),
            Row(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: DropdownButton(
                    borderRadius: BorderRadius.circular(20),
                    padding: const EdgeInsets.all(10),
                    value: Selected,
                    onChanged: (val) {
                      setState(
                        () {
                          Selected = val.toString();
                        },
                      );
                    },
                    items: [
                      const DropdownMenuItem(
                        value: "All",
                        child: Text(
                          "All Product",
                          style: TextStyle(fontSize: 20),
                        ),
                      ),
                      ...allCategories.map((e) => DropdownMenuItem(
                            value: e,
                            child: Text(
                              e
                                  .replaceFirst(e[0], e[0].toUpperCase())
                                  .toString(),
                              style: const TextStyle(fontSize: 20),
                            ),
                          )),
                    ],
                  ),
                ),
                const Spacer(),
                Visibility(
                  visible: Selected != "All",
                  child: ActionChip(
                    onPressed: () {
                      setState(() {
                        Selected = "All";
                      });
                    },
                    avatar: const Icon(Icons.clear),
                    label: const Text("Clear"),
                  ),
                ),
                const SizedBox(
                  width: 16,
                ),
              ],
            ),
            Visibility(
              visible: Selected != "All",
              child: Row(
                children: [
                  Text(
                    "From\n${sliderValue.start.toInt()}",
                    textAlign: TextAlign.center,
                  ),
                  Expanded(
                    child: RangeSlider(
                        labels: RangeLabels(
                          sliderValue.start.toInt().toString(),
                          sliderValue.end.toInt().toString(),
                        ),
                        min: 1,
                        max: 5000,
                        values: sliderValue,
                        onChanged: (val) {
                          sliderValue = val;
                          setState(() {});
                        }),
                  ),
                  Text(
                    "To\n${sliderValue.end.toInt()}",
                    textAlign: TextAlign.center,
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                ],
              ),
            ),
            Expanded(
              child: FlexibleGridView(
                axisCount: GridLayoutEnum.twoElementsInRow,
                crossAxisSpacing: 10,
                mainAxisSpacing: 8,
                children: allProduct
                    .map((e) => SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Column(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  Navigator.of(context)
                                      .pushNamed('detail_page', arguments: e);
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  margin: const EdgeInsets.only(bottom: 10),
                                  height: size.height * 0.4,
                                  width: size.width * 0.45,
                                  decoration: const BoxDecoration(
                                    borderRadius: BorderRadius.all(
                                      Radius.circular(16),
                                    ),
                                    boxShadow: [
                                      BoxShadow(
                                        color: Colors.grey,
                                        blurRadius: 10,
                                        offset: Offset(5, 5),
                                      ),
                                    ],
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    children: [
                                      Image(
                                        image: NetworkImage(e['thumbnail']),
                                      ),
                                      Text(
                                        e['title'],
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black87,
                                        ),
                                        maxLines: 2,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: Text(
                                          "\$ ${e['price'].toString()}",
                                          style: const TextStyle(
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.black54),
                                        ),
                                      ),
                                      const Spacer(),
                                      Align(
                                        alignment: Alignment.bottomRight,
                                        child: RatingBar.builder(
                                          initialRating: e['rating'],
                                          minRating: 1,
                                          direction: Axis.horizontal,
                                          allowHalfRating: true,
                                          itemCount: 5,
                                          itemSize: 24,
                                          itemPadding:
                                              const EdgeInsets.symmetric(
                                                  horizontal: 4.0),
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                            Icons.star,
                                            color: Colors.amber,
                                          ),
                                          onRatingUpdate: (rating) {
                                            print(rating);
                                          },
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ))
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
