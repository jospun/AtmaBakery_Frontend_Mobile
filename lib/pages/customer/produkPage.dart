import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/data/client/hampersClient.dart';
import 'package:p3l_atmabakery/data/client/produkClient.dart';
import 'package:p3l_atmabakery/data/produk.dart';
import 'package:intl/intl.dart';
import 'package:p3l_atmabakery/pages/customer/detailProdukPage.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class ProdukPage extends StatefulWidget {
  const ProdukPage({super.key});

  @override
  State<ProdukPage> createState() => _ProdukPage();
}

class _ProdukPage extends State<ProdukPage> {
  bool _isLoading = true;
  bool _isLoadingProduk = true;
  List<dynamic> _products = [];
  List<dynamic> _filteredProducts = [];
  Produk? product;
  List<Produk>? filteredProducts;

  List kategori = [
    'Cake',
    'Roti',
    'Titipan',
    'Minuman',
    'Hampers',
    'PO',
    'Ready',
  ];

  int selectedIndex = -1;
  String currentSearchTerm = "";
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
      final products = await produkClient.fetchProduk();
      final hampers = await hampersClient.fetchHampers();
      final combinedProducts = [...products, ...hampers];

      setState(() {
        _products = combinedProducts;
        _filteredProducts = combinedProducts;
        _isLoading = false;
        _isLoadingProduk = false;
      });
    } catch (e) {
      print("Error fetching products: $e");
    }
  }

  void _applyFilters() {
    String kategoriProduk = "";
    if (selectedIndex != -1) {
      switch (selectedIndex) {
        case 0:
          kategoriProduk = "CK";
          break;
        case 1:
          kategoriProduk = "RT";
          break;
        case 2:
          kategoriProduk = "TP";
          break;
        case 3:
          kategoriProduk = "MNM";
          break;
        case 4:
          kategoriProduk = "HMP";
          break;
        default:
          kategoriProduk = "";
      }
    }

    List<dynamic> filteredProduk = _products;

    if (selectedIndex != -1) {
      if (selectedIndex == 5) {
        filteredProduk = filteredProduk
            .where((produk) =>
                produk.status?.toLowerCase().contains("po") ?? false)
            .toList();
      } else if (selectedIndex == 6) {
        filteredProduk = filteredProduk
            .where((produk) =>
                produk.status?.toLowerCase().contains("ready") ?? false)
            .toList();
      } else {
        filteredProduk = filteredProduk
            .where((produk) => produk.id_kategori!
                .toLowerCase()
                .contains(kategoriProduk.toLowerCase()))
            .toList();
      }
    }

    if (currentSearchTerm.isNotEmpty) {
      filteredProduk = filteredProduk
          .where((produk) => produk.nama!
              .toLowerCase()
              .contains(currentSearchTerm.toLowerCase()))
          .toList();
    }

    setState(() {
      _filteredProducts = filteredProduk;
      _isLoadingProduk = false;
    });
  }

  void _searchByNamaProduk(String namaProduk) {
    setState(() {
      _isLoadingProduk = true;
      currentSearchTerm = namaProduk;
      _applyFilters();
    });
  }

  void _filterProduk(int kategori) {
    print(kategori);
    setState(() {
      _isLoadingProduk = true;
      selectedIndex = kategori;
      _applyFilters();
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
            title: Text(
              "Produk Kami",
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
              ),
            ),
          bottom: PreferredSize(
            preferredSize: const Size.fromHeight(140),
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15), 
                  child: Container(
                     height: 60.0,  
                    child: TextField(
                    decoration: InputDecoration(
                      hintText: 'Cari Produk',
                      prefixIcon: const Icon(Icons.search),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                      contentPadding:
                          EdgeInsets.symmetric(vertical: 10.0), 
                    ),
                    onChanged: (value) {
                      currentSearchTerm = value;
                      _searchByNamaProduk(value);
                      _isLoading = false;
                    },
                  ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 0, bottom: 20, right: 15, left: 15),
                  child: SizedBox(
                    height: 30,
                    child: ListView.separated(
                      itemCount: kategori.length,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) => FilterChip(
                        label: Text(
                          kategori[index],
                           style: TextStyle(
                            fontFamily: 'Montserrat',
                            fontSize: 14,
                            fontWeight: FontWeight.normal, 
                          ),
                        ),
                        labelPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 0),
                        selected: index == selectedIndex,
                        onSelected: (bool selected) {
                          setState(() {
                            if (selectedIndex == index) {
                              _searchByNamaProduk(currentSearchTerm);
                              selectedIndex = -1;
                            }
                            selectedIndex = selected ? index : selectedIndex;
                            print(selectedIndex);
                            _filterProduk(selectedIndex);
                          });
                        },
                      ),
                      separatorBuilder: (BuildContext context, int index) =>
                          const SizedBox(
                        width: 11,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: _isLoadingProduk
            ? Center(
                child: CircularProgressIndicator(),
              )
            : _filteredProducts.isEmpty
                ? Center(
                    child: Text("Tidak Ada Produk Disini!"),
                  )
                : SingleChildScrollView(
                    child: Column(
                      children: [
                        GridView.builder(
                          shrinkWrap: true,
                          physics:
                              const NeverScrollableScrollPhysics(), // Prevent scrolling of GridView inside SingleChildScrollView
                          itemCount: _filteredProducts.length ?? 0,
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                          ),
                          itemBuilder: (context, index) {
                            final product = _filteredProducts[index];
                            return GestureDetector(
                              onTap: () async {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        DetailProdukPage(item: product),
                                  ),
                                );
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
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
                                            height: 120.0.h,
                                            width: double.infinity,
                                            child: Container(
                                              height: 100.h,
                                              width: double.infinity,
                                              child: product.foto_produk !=
                                                          null &&
                                                      product.foto_produk!
                                                          .isNotEmpty
                                                  ? Image.network(
                                                      product.foto_produk![0],
                                                      fit: BoxFit.cover,
                                                    )
                                                  : Icon(Icons
                                                      .image_not_supported),
                                            ),
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.end,
                                            children: [
                                              Container(
                                                padding: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                decoration: BoxDecoration(
                                                  color: const Color.fromRGBO(
                                                      244, 142, 40, 1),
                                                  borderRadius:
                                                      BorderRadius.only(),
                                                ),
                                                child: Padding(
                                                  padding: EdgeInsets.symmetric(
                                                      vertical: 3.0,
                                                      horizontal: 5.0),
                                                  child: Text(
                                                    getKategoriText(
                                                        product.id_kategori),
                                                    style: TextStyle(
                                                      overflow:
                                                          TextOverflow.ellipsis,
                                                      fontSize: 11.0.spa,
                                                      fontWeight:
                                                          FontWeight.w600,
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Expanded(
                                                  child: Padding(
                                                    padding: EdgeInsets.only(
                                                        left: 8.0, top: 6.0),
                                                    child: AutoSizeText(
                                                      "${product.nama}",
                                                      style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 11.spa,
                                                        fontWeight:
                                                            FontWeight.bold,
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
                                                      getUkuranText(
                                                          product.id_kategori,
                                                          product.ukuran),
                                                      style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 10.0.spa,
                                                        fontWeight:
                                                            FontWeight.w500,
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
                                                      left: 8,
                                                      top: 5.0,
                                                      bottom: 5.0),
                                                  child: Text(
                                                    formatRupiah(
                                                        product.harga ?? 0),
                                                    style: TextStyle(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        fontSize: 11.spa,
                                                        fontWeight:
                                                            FontWeight.w500,
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
