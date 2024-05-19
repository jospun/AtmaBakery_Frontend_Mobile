import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p3l_atmabakery/data/client/hampersClient.dart';
import 'package:p3l_atmabakery/data/client/produkClient.dart';
import 'package:p3l_atmabakery/data/produk.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:carousel_slider/carousel_slider.dart';

class DetailProdukPage extends StatefulWidget {
  final dynamic item;

  DetailProdukPage({Key? key, required this.item}) : super(key: key);

  @override
  _DetailProdukPageState createState() => _DetailProdukPageState();
}

class _DetailProdukPageState extends State<DetailProdukPage> {
  bool isReadySelected = true;
  bool _isLoading = false;
  String selectedDate = '';
  int remainingProduk = 0;
  int _current = 0;
  Hampers? hampers;
  List<Produk> remaining = [];
  final CarouselController _carouselController = CarouselController();

  TextEditingController contollerDate = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now(),
      lastDate: DateTime(2101),
    );

    if (picked != null) {
      if (widget.item.id_kategori != "HMP") {
        remainingProduk =
            await produkClient.countTransaksi(widget.item.id, picked);
      } else {
        remaining =
            await hampersClient.countTransaksiHampers(widget.item.id, picked);
      }
      setState(() {
        selectedDate = DateFormat('dd/MM/yyyy').format(picked);
        print(remainingProduk);
      });
    }
  }

  String formatRupiah(int amount) {
    return NumberFormat.currency(
            locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
        .format(amount);
  }

  List<Widget> buildRemainingList(List<Produk> remaining) {
    return remaining.map((item) {
      return Padding(
        padding: EdgeInsets.only(bottom: 0.3.h),
        child: AutoSizeText(
          "${item.nama} ${getUkuranText(item.id_kategori, item.ukuran)} dengan limit ${item.remaining}",
          style: TextStyle(
              overflow: TextOverflow.ellipsis,
              fontSize: 12.spa,
              fontWeight: FontWeight.w500,
              color: Colors.red),
          maxLines: 1,
        ),
      );
    }).toList();
  }

  List<Widget> buildProductList(List<DetailHampers>? details) {
    if (details == null || details.isEmpty) {
      return [Text("No products available.")];
    }

    return details.map((detail) {
      final produk = detail.produk;

      if (produk != null) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 1.0),
          child: AutoSizeText(
            "- ${produk.nama} ${getUkuranText(produk.id_kategori, produk.ukuran)} x 1",
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 12.0.spa,
                fontWeight: FontWeight.w400,
                color: Colors.grey),
            maxLines: 1,
          ),
        );
      } else {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 2.0),
          child: AutoSizeText(
            "Unknown product",
            style: TextStyle(
                overflow: TextOverflow.ellipsis,
                fontSize: 12.0,
                fontWeight: FontWeight.w400,
                color: Colors.grey),
            maxLines: 1,
          ),
        );
      }
    }).toList();
  }

  String getUkuranText(String? id_kategori, String? ukuran) {
    switch (id_kategori) {
      case "CK":
        return ukuran == "1" ? "1 Loyang" : "1/2 Loyang";
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

  void getDetailHampers() async {
    setState(() {
      _isLoading = true;
    });

    hampers = await hampersClient.fetchDetailHampers(widget.item.id);

    setState(() {
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    if (widget.item.id_kategori == "HMP") {
      getDetailHampers();
    }
  }

  @override
  Widget build(BuildContext context) {
    final item = widget.item;
    if (item.id_kategori == "HMP" || item.status == "PO") {
      isReadySelected = false;
    } else {
      isReadySelected = true;
    }
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
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                alignment: Alignment.center,
                width: double.infinity,
                child: Column(
                  children: [
                    CarouselSlider(
                      carouselController: _carouselController,
                      options: CarouselOptions(
                        height: 300.0,
                        viewportFraction: 1.0,
                        enableInfiniteScroll: false,
                        autoPlay: false,
                        onPageChanged: (index, reason) {
                          setState(() {
                            _current = index;
                          });
                        },
                      ),
                      items: item.foto_produk.map<Widget>((foto) {
                        return Builder(
                          builder: (BuildContext context) {
                            return Container(
                              width: MediaQuery.of(context).size.width,
                              child: Image.network(
                                foto,
                                fit: BoxFit.cover,
                              ),
                            );
                          },
                        );
                      }).toList(),
                    ),
                    item.foto_produk.isNotEmpty
                        ? Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: item.foto_produk
                                .asMap()
                                .entries
                                .map<Widget>((entry) {
                              return GestureDetector(
                                onTap: () => _carouselController
                                    .animateToPage(entry.key),
                                child: Container(
                                  width: 8.0,
                                  height: 8.0,
                                  margin: EdgeInsets.symmetric(
                                    vertical: 10.0,
                                    horizontal: 4.0,
                                  ),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: (Theme.of(context).brightness ==
                                                Brightness.dark
                                            ? Colors.white
                                            : Colors.black)
                                        .withOpacity(
                                            _current == entry.key ? 0.9 : 0.4),
                                  ),
                                ),
                              );
                            }).toList(),
                          )
                        : Icon(Icons.image_not_supported),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 1.5.w,
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                    ),
                  ),
                ),
                padding: EdgeInsets.symmetric(horizontal: 20.0),
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 1.h),
                            child: AutoSizeText(
                              "${item.nama}",
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 15.spa,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: EdgeInsets.only(top: 1.h, left: 28.w),
                            child: AutoSizeText(
                              getUkuranText(item.id_kategori, item.ukuran),
                              style: TextStyle(
                                overflow: TextOverflow.ellipsis,
                                fontSize: 12.0.spa,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                              maxLines: 2,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 0.3.h),
                            child: Text(
                              formatRupiah(item.harga ?? 0),
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 14.5.spa,
                                  fontWeight: FontWeight.w800,
                                  color: Color.fromRGBO(244, 142, 40, 1)),
                            ),
                          ),
                        ),
                        if (item.id_kategori != "HMP")
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(top: 0.9.h, bottom: 2.5.h),
                              child: AutoSizeText(
                                "${item.deskripsi}",
                                textAlign: TextAlign.justify,
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 12.spa,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.grey),
                                maxLines: 4,
                              ),
                            ),
                          ),
                        if (item.id_kategori == "HMP")
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding:
                                  EdgeInsets.only(top: 0.9.h, bottom: 2.5.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Produk dalam Hampers ini :",
                                    style: TextStyle(
                                      fontSize: 12.0.spa,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  ...buildProductList(hampers?.detail_hampers),
                                ],
                              ),
                            ),
                          ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  border: Border(
                    bottom: BorderSide(
                      width: 2.w,
                      color: Color.fromRGBO(0, 0, 0, 0.05),
                    ),
                  ),
                ),
                padding: EdgeInsets.only(
                    left: 20.0, right: 20.0, bottom: 10.0, top: 2.5.h),
                alignment: Alignment.centerLeft,
                child: Column(
                  children: [
                    Column(
                      children: [
                        Align(
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: EdgeInsets.only(top: 2.0, bottom: 1.5.h),
                            child: AutoSizeText(
                              "Pilihan Produk",
                              style: TextStyle(
                                  overflow: TextOverflow.ellipsis,
                                  fontSize: 13.spa,
                                  fontWeight: FontWeight.w500,
                                  color: Colors.black),
                              maxLines: 4,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isReadySelected = true;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: isReadySelected
                                    ? Color.fromRGBO(244, 142, 40, 1)
                                    : Color.fromRGBO(234, 234, 234, 1),
                                onPrimary: isReadySelected
                                    ? Colors.white
                                    : Color.fromRGBO(244, 142, 40, 1),
                                side: isReadySelected
                                    ? BorderSide.none
                                    : BorderSide(
                                        color: Color.fromRGBO(244, 142, 40, 1)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                minimumSize: Size(42.w, 5.h),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text('Ready'),
                            ),
                            ElevatedButton(
                              onPressed: () {
                                setState(() {
                                  isReadySelected = false;
                                });
                              },
                              style: ElevatedButton.styleFrom(
                                primary: !isReadySelected
                                    ? Color.fromRGBO(244, 142, 40, 1)
                                    : Color.fromRGBO(234, 234, 234, 1),
                                onPrimary: !isReadySelected
                                    ? Colors.white
                                    : Color.fromRGBO(244, 142, 40, 1),
                                side: !isReadySelected
                                    ? BorderSide.none
                                    : BorderSide(
                                        color: Color.fromRGBO(244, 142, 40, 1)),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(5),
                                ),
                                minimumSize: Size(42.w, 5.h),
                                padding: EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 10),
                              ),
                              child: Text('Pre-Order'),
                            ),
                          ],
                        ),
                      ],
                    ),
                    if (!isReadySelected)
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 1.8.h),
                              child: Text(
                                "Tanggal Pesan",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 12.5.spa,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black),
                              ),
                            ),
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 1.5.h, bottom: 1.h),
                              child: GestureDetector(
                                onTap: () => _selectDate(context),
                                child: Container(
                                  width: 95.w,
                                  height: 6.h,
                                  decoration: BoxDecoration(
                                    border: Border.all(
                                      color: Color.fromRGBO(0, 0, 0, 0.1),
                                      width: 1,
                                    ),
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  child: Padding(
                                    padding:
                                        EdgeInsets.only(left: 15, right: 15),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          selectedDate.isNotEmpty
                                              ? selectedDate
                                              : 'Pilih Tanggal',
                                          style: TextStyle(
                                            fontSize: 12.spa,
                                            color: selectedDate.isNotEmpty
                                                ? Colors.black
                                                : Colors.grey,
                                          ),
                                        ),
                                        Icon(
                                          Icons.calendar_today,
                                          color: Colors.grey,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (item.id_kategori != "HMP" && selectedDate.isNotEmpty)
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(bottom: 2.h),
                              child: AutoSizeText(
                                "Limit Produk Sisa $remainingProduk",
                                style: TextStyle(
                                    overflow: TextOverflow.ellipsis,
                                    fontSize: 12.spa,
                                    fontWeight: FontWeight.w500,
                                    color: Colors.red),
                                maxLines: 1,
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (item.id_kategori == "HMP" && selectedDate.isNotEmpty)
                      Column(
                        children: [
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Padding(
                              padding: EdgeInsets.only(top: 1.5.h, bottom: 2.h),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Limit / Stok pembelian pada hari tersebut :",
                                    style: TextStyle(
                                      fontSize: 12.0.spa,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.black,
                                    ),
                                  ),
                                  SizedBox(
                                    height: 1.h,
                                  ),
                                  ...buildRemainingList(remaining),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    if (isReadySelected && item.id_kategori != "HMP")
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: EdgeInsets.only(top: 1.5.h),
                          child: Text(
                            "Stok   : ${item.stok}",
                            style: TextStyle(
                              fontSize: 12.spa,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
    }
  }
}
