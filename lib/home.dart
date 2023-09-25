import 'dart:math';
import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_pesanan_fix/services/menu.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<List<MenuData>> futureMenuData;
  Map<int, int> quantityMap = {}; // Menyimpan jumlah untuk setiap id

  @override
  void initState() {
    super.initState();
    futureMenuData = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      // Makanan
      body: FutureBuilder<List<MenuData>>(
          future: futureMenuData,
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else {
              final menuDataList = snapshot.data;
              return ListView.builder(
                  itemCount: menuDataList!.length,
                  itemBuilder: (context, index) {
                    final menuData = menuDataList[index];
                    int quantity = quantityMap[menuData.id] ?? 0;
                    {
                      final menuData = menuDataList[index];
                      int quantity = quantityMap[menuData.id] ?? 0;
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SizedBox(
                          height: 89,
                          child: Card(
                            elevation: 1,
                            margin: const EdgeInsets.only(left: 20, right: 20),
                            color: Colors.grey[200],
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    children: [
                                      const Padding(
                                        padding: EdgeInsets.only(left: 3),
                                      ),
                                      Card(
                                        elevation: 0,
                                        color: Colors.grey[300],
                                        child: SizedBox(
                                          height: 75,
                                          width: 75,
                                          //
                                          // Image
                                          //
                                          child: Image.network(menuData.gambar),
                                        ),
                                      ),
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          //
                                          // Nama
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                top: 8, left: 4),
                                            child: Text(
                                              menuData.nama,
                                              style:
                                                  const TextStyle(fontSize: 24),
                                            ),
                                          ),

                                          //
                                          // Rp
                                          Padding(
                                            padding: const EdgeInsets.only(
                                                left: 4.0, top: 2),
                                            child: Row(
                                              children: [
                                                const Text(
                                                  'Rp',
                                                  style: TextStyle(
                                                    color: Colors.teal,
                                                    fontWeight: FontWeight.bold,
                                                    fontSize: 18,
                                                  ),
                                                ),

                                                //
                                                // Harga
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          left: 5),
                                                  child: Text(
                                                    '${menuData.harga}',
                                                    style: const TextStyle(
                                                      color: Colors.teal,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 18,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),

                                          //
                                          // Icon
                                          const Padding(
                                            padding: EdgeInsets.only(left: 3),
                                            child: Row(
                                              children: [
                                                Icon(
                                                  Icons.edit_note,
                                                  color: Colors.teal,
                                                  size: 16,
                                                ),

                                                //
                                                // TextField
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),

                                  //
                                  // Icon
                                  Row(
                                    children: [
                                      IconButton(
                                        onPressed: () {
                                          decrementQuantity(menuData.id);
                                        },
                                        icon: const Icon(Icons.remove),
                                      ),
                                      SizedBox(
                                        width: 30, // Lebar TextField
                                        child: TextField(
                                          decoration: const InputDecoration(
                                            hintText: '0',
                                          ),
                                          keyboardType: TextInputType.number,
                                          textAlign: TextAlign.center,
                                          controller: TextEditingController(
                                              text: quantity.toString()),
                                          readOnly: true,
                                        ),
                                      ),
                                      IconButton(
                                        onPressed: () {
                                          incrementQuantity(menuData.id);
                                        },
                                        icon: const Icon(Icons.add),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      );
                    }
                  });
            }
          }),
    );
  }

  void decrementQuantity(int menuId) {
    int quantity = quantityMap[menuId] ?? 0;
    if (quantity > 0) {
      setState(() {
        quantityMap[menuId] = quantity - 1;
      });
    }
  }

  void incrementQuantity(int menuId) {
    int quantity = quantityMap[menuId] ?? 0;
    setState(() {
      quantityMap[menuId] = quantity + 1;
    });
  }
}
