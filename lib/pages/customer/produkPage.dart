import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/data/client/produkClient.dart';
import 'package:p3l_atmabakery/data/produk.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPage();
}

class _ProdukPage extends State<ProdukPage> {
  bool _isLoading = true;
  List<Produk>? products;
  Produk? product;
  List<Produk>? filteredProducts;

  List kategori = [
    'Cake',
    'Roti',
    'Titipan',
    'Minuman',
    'Hampers',
    'PO',
    'Ready'
  ];

  int selectedIndex = -1;
  String formatRupiah(int amount) {
    return NumberFormat.currency(
            locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
        .format(amount);
  }

  Future<void> _loadProdukData() async {
    setState(() {
      _isLoading = true;
    });

    try {
      products = await produkClient.fetchProduk();
      filteredProducts = List.from(products!);
      print(products![1].nama);
    } catch (e) {
      print("Error fetching products: $e");
    }

    setState(() {
      _isLoading = false;
    });
  }

  void _searchByNamaProduk(String namaProduk) {
    setState(() {
      filteredProducts = products!.where((product) {
        return product.nama!.toLowerCase().contains(namaProduk.toLowerCase());
      }).toList();
    });
  }

  String getKategoriText(String? id_kategori) {
    switch (id_kategori) {
      case "CK":
        return "Cake";
      case "RT":
        return "Roti";
      case "MNM":
        return "Minuman";
      case "TP":
        return "Titipan";
      default:
        return "Hampers";
    }
  }

  String getUkuranText(String? id_kategori, String? ukuran) {
    switch (id_kategori) {
      case "CK":
        if (ukuran == "1") {
          return "1 Loyang";
        } else {
          return "1/2 Loyang";
        }
      case "RT":
        return "Isi 10/Box";
      case "MNM":
        return "Per Liter";
      case "TP":
        return "Per Bungkus";
      default:
        return "Per Box";
    }
  }

  @override
  void initState() {
    super.initState();
    _loadProdukData();
  }

  @override
  Widget build(BuildContext context) {
    if (_isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          title: const Text(
            "Produk Kami",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontFamily: 'Montserrat',
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: IconButton(
              icon: const Icon(Icons.arrow_circle_left_outlined),
              onPressed: () {
                Navigator.of(context).pop();
              },
              iconSize: 30,
            ),
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {});
              },
            ),
          ],
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(120),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari Produk',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                    ),
                    onChanged: (value) {
                      _searchByNamaProduk(value);
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: SizedBox(
                    height: 30,
                    child: ListView.separated(
                      itemCount: kategori.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => FilterChip(
                        label: Text(
                          kategori[index],
                        ),
                        selected: index == selectedIndex,
                        onSelected: (bool selected) {
                          setState(() {
                            selectedIndex = selected ? index : selectedIndex;
                          });
                        },
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        width: 10,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              GridView.builder(
                shrinkWrap: true,
                physics:
                    const NeverScrollableScrollPhysics(), // Prevent scrolling of GridView inside SingleChildScrollView
                itemCount: filteredProducts?.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final product = filteredProducts![index];
                  return GestureDetector(
                    onTap: () {},
                    child: Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.black12,
                            blurRadius: 15.0,
                            offset: Offset(1, 5),
                          ),
                        ],
                      ),
                      margin: const EdgeInsets.only(
                          left: 15.0, right: 15.0, bottom: 30.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Flexible(
                            child: Stack(
                              children: [
                                Container(
                                  alignment: Alignment.center,
                                  height: 120.0,
                                  width: double.infinity,
                                  child: Image.network(
                                    product.foto_produk![0],
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Container(
                                      padding:
                                          EdgeInsets.symmetric(horizontal: 5),
                                      decoration: BoxDecoration(
                                        color: const Color.fromRGBO(
                                            244, 142, 40, 1),
                                        borderRadius: BorderRadius.only(),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 3.0, horizontal: 5.0),
                                        child: Text(
                                          getKategoriText(product.id_kategori),
                                          style: TextStyle(
                                            overflow: TextOverflow.ellipsis,
                                            fontSize: 11.0.spa,
                                            fontWeight: FontWeight.w600,
                                            color: Colors.white,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Container(
                            child: Column(
                              children: [
                                Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 8.0, top: 6.0),
                                          child: AutoSizeText(
                                            "${product.nama}",
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 11.8.spa,
                                              fontWeight: FontWeight.bold,
                                              color: Colors.orange,
                                            ),
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        child: Padding(
                                          padding: EdgeInsets.only(
                                              left: 20.0, top: 6.0),
                                          child: AutoSizeText(
                                            getUkuranText(product.id_kategori,
                                                product.ukuran),
                                            style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 10.0.spa,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black,
                                            ),
                                            maxLines: 2,
                                          ),
                                        ),
                                      ),
                                    ]),
                                Column(
                                  children: [
                                    Align(
                                      alignment: Alignment.centerLeft,
                                      child: Padding(
                                        padding: EdgeInsets.only(
                                            left: 8, top: 5.0, bottom: 5.0),
                                        child: Text(
                                          formatRupiah(product.harga ?? 0),
                                          style: TextStyle(
                                              overflow: TextOverflow.ellipsis,
                                              fontSize: 11.5.spa,
                                              fontWeight: FontWeight.w500,
                                              color: Colors.black),
                                        ),
                                      ),
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      );
    }
  }
}
