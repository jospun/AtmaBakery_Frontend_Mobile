import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/data/user.dart';
import 'package:p3l_atmabakery/data/produk.dart';
import 'package:p3l_atmabakery/data/client/userClient.dart';
import 'package:p3l_atmabakery/data/client/produkClient.dart';
import 'package:p3l_atmabakery/pages/loginPage.dart';
import 'package:p3l_atmabakery/pages/customer/produkPage.dart';
import 'package:p3l_atmabakery/pages/customer/walletPage.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:auto_size_text/auto_size_text.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePage();
}

class _HomePage extends State<HomePage> {
  String? nama, email, id_role, profilePictureUrl;
  List<Produk> latestProducts = [];
  int _currentIndex = 0;

  final List<String> iklan = [
    'assets/images/ads_1.png',
    'assets/images/ads_2.png',
    'assets/images/ads_3.png',
  ];

  @override
  void initState() {
    super.initState();
    _fetchLatestProducts();
    _loadUserData();
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

  Future<void> _fetchLatestProducts() async {
    try {
      final products = await produkClient.fetchProduk();
      setState(() {
        latestProducts = List<Produk>.from(products);
      });
    } catch (e) {
      print("Error fetching latest products: $e");
    }
  }

  Future<void> _loadUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final cachedNama = prefs.getString('nama');
    final cachedIdRole = prefs.getString('id_role');
    final cachedProfilePictureUrl = prefs.getString('profilePictureUrl');

    if (cachedNama != null &&
        cachedIdRole != null &&
        cachedProfilePictureUrl != null) {
      setState(() {
        nama = cachedNama;
        id_role = cachedIdRole;
        profilePictureUrl = cachedProfilePictureUrl;
      });
    } else {
      _fetchUserData();
    }
  }

  Future<void> _fetchUserData() async {
    try {
      final user = await userClient.showSelf();
      setState(() {
        nama = user.nama;
        id_role = user.id_role;
        profilePictureUrl = user.foto_profil;
      });
      _cacheUserData();
    } catch (e) {
      print("Error fetching user data: $e");
      setState(() {
        nama = null; // indicate error or guest
      });
    }
  }

  Future<void> _cacheUserData() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('nama', nama ?? '');
    await prefs.setString('id_role', id_role ?? '');
    await prefs.setString('profilePictureUrl', profilePictureUrl ?? '');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          "Atma Bakery",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
          ),
        ),
        actions: <Widget>[
          if (id_role == 'CUST')
            IconButton(
              icon: Icon(Icons.wallet_rounded),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => WalletPage()),
                );
              },
            ),
        ],
      ),
      body: Padding(
        padding: EdgeInsets.only(top: 0, bottom: 10, right: 15, left: 15),
        child: ListView(
          children: [
            _buildUserInfo(),
            _buildSearchField(),
            _buildImageSlider(),
            _buildQuickAccessButtons(),
            _buildLatestProducts(),
          ],
        ),
      ),
    );
  }

  Widget _buildUserInfo() {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Selamat Datang",
                style: TextStyle(
                  fontSize: 14,
                  fontFamily: 'Montserrat',
                  color: Colors.grey,
                ),
              ),
              Text(
                nama != null ? "Halo, $nama" : "Halo, Kamu!",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Montserrat',
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          CircleAvatar(
            radius: 30,
            backgroundImage: profilePictureUrl != null
                ? NetworkImage(profilePictureUrl!)
                : NetworkImage(
                    "https://res.cloudinary.com/daorbrq8v/image/upload/f_auto,q_auto/v1/atma-bakery/r1xujbu1yfoenzked4rc"),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchField() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 12.0),
      child: Container(
        height: 60.0,
        child: TextField(
          decoration: InputDecoration(
            hintText: 'Cari Produk',
            prefixIcon: Icon(Icons.search),
            contentPadding: EdgeInsets.symmetric(vertical: 0.0),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(10.0),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildImageSlider() {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 5.0),
      child: Column(
        children: [
          SizedBox(
            height: 200,
            child: PageView.builder(
              itemCount: iklan.length,
              onPageChanged: (index) {
                setState(() {
                  _currentIndex = index;
                });
              },
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.symmetric(horizontal: 0),
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                      image: DecorationImage(
                        image: AssetImage(iklan[index]),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(
              iklan.length,
              (index) => AnimatedContainer(
                duration: Duration(milliseconds: 300),
                margin: EdgeInsets.symmetric(horizontal: 4),
                width: _currentIndex == index ? 12 : 8,
                height: 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentIndex == index ? Colors.orange : Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildQuickAccessButtons() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          "Kategori Produk",
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Montserrat',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 5),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildRectangularButton(
                icon: Icons.cake,
                label: 'Cake',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProdukPage()),
                  );
                },
              ),
              _buildRectangularButton(
                icon: Icons.breakfast_dining,
                label: 'Roti',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProdukPage()),
                  );
                },
              ),
              _buildRectangularButton(
                icon: Icons.coffee,
                label: 'Minuman',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProdukPage()),
                  );
                },
              ),
              _buildRectangularButton(
                icon: Icons.local_shipping_rounded,
                label: 'Titipan',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProdukPage()),
                  );
                },
              ),
              _buildRectangularButton(
                icon: Icons.card_giftcard_rounded,
                label: 'Hampers',
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ProdukPage()),
                  );
                },
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildRectangularButton({
    required IconData icon,
    required String label,
    required VoidCallback onPressed,
  }) {
    return Expanded(
      child: InkWell(
        onTap: onPressed,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 60,
              height: 60,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(
                icon,
                color: const Color.fromRGBO(244, 142, 40, 1),
                size: 30,
              ),
            ),
            SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                fontFamily: 'Montserrat',
                fontSize: 12,
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildLatestProducts() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(
          "Produk Terbaru",
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Montserrat',
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        SizedBox(height: 20),
        latestProducts.isEmpty
            ? Center(child: CircularProgressIndicator())
            : GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: latestProducts.length ?? 0,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                ),
                itemBuilder: (context, index) {
                  final product = latestProducts[index];
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              ProdukDetailPage(product: product),
                        ),
                      );
                    },
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
                                  height: 120.0.h,
                                  width: double.infinity,
                                  child: Container(
                                    height: 100.h,
                                    width: double.infinity,
                                    child: product.foto_produk != null &&
                                            product.foto_produk!.isNotEmpty
                                        ? Image.network(
                                            product.foto_produk![0],
                                            fit: BoxFit.cover,
                                          )
                                        : Icon(Icons.image_not_supported),
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
                                              fontSize: 11.spa,
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
                                              fontSize: 11.spa,
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
    );
  }

  String formatRupiah(int amount) {
    return NumberFormat.currency(
      locale: 'id_ID',
      symbol: 'Rp',
      decimalDigits: 0,
    ).format(amount);
  }
}

class ProdukDetailPage extends StatelessWidget {
  final Produk product;

  const ProdukDetailPage({Key? key, required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.nama ?? 'Product Detail'),
      ),
      body: Center(
        child: Text('Detail Page Placeholder'),
      ),
    );
  }
}
