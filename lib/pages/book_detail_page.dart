import 'package:flutter/material.dart';
import 'package:shelf_mobil_frontend/types/book.dart';

class BookDetailPage extends StatefulWidget {
  const BookDetailPage({super.key});
  @override
  State<BookDetailPage> createState() => _BookDetailPageState();
}

class _BookDetailPageState extends State<BookDetailPage> {
  int currentIndex = 0;
  static final List<String> images = Book.getImages();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("BOOK NAME"),
      ),
      body: Container(
        padding: const EdgeInsets.all(25),
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            tileMode: TileMode.mirror,
            colors: [
              Color.fromARGB(70, 255, 131, 220),
              Color.fromARGB(70, 246, 238, 243),
              Color.fromARGB(70, 76, 185, 252),
            ],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height*0.3,
                  width: double.infinity,
                  child: PageView.builder(
                    onPageChanged: (index) {
                      setState(() {
                        currentIndex = index % images.length;
                      });
                    },
                    itemBuilder: ((context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: SizedBox(
                          child: Image.network(
                            images[index % images.length].toString(),
                            fit: BoxFit.contain,
                          ),
                        ),
                      );
                    }),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    for (var i = 0; i < images.length; i++)
                      buildIndicator(currentIndex == i)
                  ],
                ),
                const SizedBox(
                  height: 18,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width*0.36,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(220, 255, 255, 255),
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton.icon(
                          style: const ButtonStyle(),
                          onPressed: () {},
                          icon: const Icon(Icons.add_shopping_cart,
                              color: Colors.black),
                          label: const Text(
                            "Add to Shelf",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                    Container(
                      height: 45,
                      width: MediaQuery.of(context).size.width*0.43,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(220, 255, 255, 255),
                        border: Border.all(
                          color: Colors.black,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: TextButton.icon(
                          style: const ButtonStyle(),
                          onPressed: () {},
                          icon: const Icon(Icons.favorite_border,
                              color: Colors.black),
                          label: const Text(
                            "Add to Favorites",
                            style: TextStyle(
                                color: Colors.black,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          )),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width*0.65,
                  height: MediaQuery.of(context).size.height*0.12,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(220, 255, 255, 255),
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Column(
                    children: [
                      IntrinsicHeight(
                        child: Row(
                          children: const [
                            Icon(Icons.menu_book_rounded),
                            VerticalDivider(
                              endIndent: 0,
                              thickness: 1,
                            ),
                            Text("NAME OF THE BOOK"),
                          ],
                        ),
                      ),
                      IntrinsicHeight(
                        child: Row(
                          children: const [
                            Icon(Icons.person),
                            VerticalDivider(
                              endIndent: 0,
                              thickness: 1,
                            ),
                            Text("NAME OF THE AUTHOR"),
                          ],
                        ),
                      ),
                      IntrinsicHeight(
                        child: Row(
                          children: const [
                            Icon(Icons.description),
                            VerticalDivider(
                              endIndent: 0,
                              thickness: 1,
                            ),
                            Text("NUMBER OF PAGES"),
                          ],
                        ),
                      ),
                      IntrinsicHeight(
                        child: Row(
                          children: const [
                            Icon(Icons.library_books),
                            VerticalDivider(
                              endIndent: 0,
                              thickness: 1,
                            ),
                            Text("NAME OF THE CATEGORY"),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10, top: 5),
                  width: MediaQuery.of(context).size.width*0.65,
                  height: MediaQuery.of(context).size.height*0.12,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(220, 255, 255, 255),
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text("DETAILED INFORMATION ABOUT BOOKS"),
                ),
                const SizedBox(
                  height: 8,
                ),
                Container(
                  padding: const EdgeInsets.only(left: 10),
                  width: MediaQuery.of(context).size.width*0.5,
                  height: MediaQuery.of(context).size.height*0.05,
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(220, 255, 255, 255),
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: IntrinsicHeight(
                    child: Row(
                      children: const [
                        Icon(Icons.local_shipping),
                        VerticalDivider(
                          endIndent: 0,
                          thickness: 1,
                        ),
                        Text("SHIPMENT TYPE")
                      ],
                    ),
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Container(
                  decoration: BoxDecoration(
                    color: const Color.fromARGB(220, 255, 255, 255),
                    border: Border.all(
                      color: Colors.black,
                    ),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: TextButton.icon(
                    style: const ButtonStyle(
                        fixedSize: MaterialStatePropertyAll(Size(180, 50))),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.account_circle,
                      size: 30,
                      color: Colors.black,
                    ),
                    label: const Text(
                      "NAME OF THE OWNER",
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 15,
                          fontWeight: FontWeight.bold),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildIndicator(bool isSelected) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1),
      child: Container(
        height: isSelected ? 12 : 8,
        width: isSelected ? 12 : 8,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: isSelected ? Colors.black : Colors.grey,
        ),
      ),
    );
  }
}
