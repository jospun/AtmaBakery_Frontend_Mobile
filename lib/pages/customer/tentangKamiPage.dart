import 'dart:async';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class TentangKamiPage extends StatefulWidget {
  const TentangKamiPage({Key? key}) : super(key: key);

  @override
  State<TentangKamiPage> createState() => _TentangKamiPageState();
}

class _TentangKamiPageState extends State<TentangKamiPage> {
  int selectedIndex = 0;
  final List<String> tentang = ["Owner", "Produk", "Layanan", "Momen"];
  final PageController _pageController = PageController();
  Timer? _timer;
  bool _isTouched = false;
  final List<String> productImages = [
    'assets/images/legit.png',
    'assets/images/surabaya.png',
    'assets/images/spikoe.png',
    'assets/images/mandarin.png',
  ];
  final List<String> productNames = [
    'Lapis Legit Kue Khas Daerah Lampung',
    'Lapis Surabaya Kue Khas Daerah Surabaya',
    'Spikoe Kue Khas Daerah Surabaya',
    'Mandarin Kue Khas Daerah Lampung',
  ];
  
  final List<String> imageList = [
    "assets/images/1.jpg",
    "assets/images/2.jpg",
    "assets/images/3.jpg",
    "assets/images/4.jpg",
  ];

  final ScrollController _scrollController = ScrollController();

  final GlobalKey _ownerKey = GlobalKey();
  final GlobalKey _productKey = GlobalKey();
  final GlobalKey _serviceKey = GlobalKey();
  final GlobalKey _momentKey = GlobalKey();

  @override
  void initState() {
    super.initState();
    _startAutoSlide();
  }

  void _startAutoSlide() {
    _timer = Timer.periodic(Duration(seconds: 3), (Timer timer) {
      if (_isTouched) return;
      if (_pageController.page == null) return;
      _pageController.nextPage(
        duration: Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    });
  }

  void _stopAutoSlide() {
    _timer?.cancel();
  }

  void _onUserInteractionStart() {
    setState(() {
      _isTouched = true;
    });
  }

  void _onUserInteractionEnd() {
    setState(() {
      _isTouched = false;
    });
  }

  void _scrollToSection(GlobalKey key) {
    final context = key.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(context, duration: Duration(seconds: 1), curve: Curves.easeInOut);
    }
  }

  @override
  void dispose() {
    _stopAutoSlide();
    _pageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
                title: Row(
          children: [
            Expanded(
              child: Text(
                "Tentang Kami",
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'Montserrat',
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(60),
          child: Padding(
            padding: const EdgeInsets.all(15),
            child: Center(
              child: SizedBox(
                height: 30,
                child: ListView.separated(
                  itemCount: tentang.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedIndex = index;
                      });
                      if (index == 0) {
                        _scrollToSection(_ownerKey);
                      } else if (index == 1) {
                        _scrollToSection(_productKey);
                      } else if (index == 2) {
                        _scrollToSection(_serviceKey);
                      } else if (index == 3) {
                        _scrollToSection(_momentKey);
                      }
                    },
                    child: BulletItem(
                      text: tentang[index],
                      isSelected: index == selectedIndex,
                    ),
                  ),
                  separatorBuilder: (BuildContext context, int index) => const SizedBox(
                    width: 10,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        controller: _scrollController,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Sentuhan Manis untuk Hari-Hari Anda",
                key: _ownerKey,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Image.asset(
                  'assets/images/Owner.png',
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Margareth Alexandra Winata pemilik Atma Bakery adalah seorang visioner yang menggabungkan keahlian kuliner dengan dedikasi untuk menciptakan pengalaman berharga melalui rasa setiap produk kue-kuenya",
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Produk Pertama Kali Hadir Sejak Hari Pertama Atma Bakery Berdiri Tahun 2022",
                key: _productKey,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 8),
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SizedBox(
                  height: 250,
                  child: GestureDetector(
                    onPanDown: (details) {
                      _onUserInteractionStart();
                    },
                    onPanEnd: (details) {
                      _onUserInteractionEnd();
                    },
                    onTapDown: (details) {
                      _onUserInteractionStart();
                    },
                    onTapUp: (details) {
                      _onUserInteractionEnd();
                    },
                    child: PageView.builder(
                      controller: _pageController,
                      itemBuilder: (context, index) {
                        final actualIndex = index % productImages.length;
                        return ProductCard(
                          imagePath: productImages[actualIndex],
                          productName: productNames[actualIndex],
                        );
                      },
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 16),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Sejak awal berdirinya tahun 2022 Atma Bakery telah menawarkan empat produk klasik yang menjadi ciri khasnya. Lapis Legit, Lapis Surabaya, Spikoe, dan Mandarin telah menjadi pilihan utama sejak hari pertama, mencerminkan dedikasi bakery dalam menciptakan kue-kue berkualitas tinggi yang selalu memukau pelanggan.",
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 8),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Lapis Legit memiliki tekstur lembut dan lapisan rempah yang kaya. Lapis Surabaya kombinasi kue cokelat dan kuning yang lembut. Spikoe dengan konsistensi sempurna dan rasa lembut. Mandarin, kue manis dengan sentuhan citrus segar. Keempatnya mencerminkan kualitas tinggi dari Atma Bakery.",
                style: TextStyle(fontSize: 14),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Rintisan Atma Bakery Mulai Tahun Pendirian Hingga Sekarang Membawa Perubahan",
                key: _serviceKey,
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 16),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 16.0),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                borderRadius: BorderRadius.circular(15.0),
                boxShadow: [
                  BoxShadow(
                    color: Color.fromARGB(255, 194, 191, 191).withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 2,
                    offset: Offset(0, 3), 
                  ),
                ],
              ),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Table(
                  defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                  children: [
                    TableRow(
                      children: [
                        TableCell(
                          child: SizedBox(
                            child: Padding(
                              padding: EdgeInsets.all(8.0),
                              child: Center(
                                child: Text(
                                  "Waktu",
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ),
                          ),
                        ),
                        TableCell(
                          child: Padding(
                            padding: EdgeInsets.all(8.0),
                            child: Center(
                              child: Text(
                                "Deskripsi",
                                style: TextStyle(fontWeight: FontWeight.bold),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    _buildCenteredRow("Mendatang", "Berorientasi kedepan dengan perancangan cabang baru"),
                    _buildCenteredRow("2024", "Bertambah produk kue-kue, minuman, dan camilan manis"),
                    _buildCenteredRow("2023", "Berikan perubahan teknologi pesan kue dimana saja, kapan saja"),
                    _buildCenteredRow("2022", "Berkeliling menjual kue-kue kami dengan menggunakan sepeda"),
                  ],
                ),
              ),
            ),
            SizedBox(height: 30),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: Text(
                "Momen Pertama Kami",
                key: _momentKey, // Fixed the key for this section
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            SizedBox(height: 20),
            CarouselSlider(
              options: CarouselOptions(
                aspectRatio: 1.0,
                autoPlay: true,
                enlargeCenterPage: true,
              ),
              items: imageList.map((image) {
                return Builder(
                  builder: (BuildContext context) {
                    return Container(
                      width: MediaQuery.of(context).size.width,
                      margin: EdgeInsets.symmetric(horizontal: 5.0),
                      decoration: BoxDecoration(
                        color: Colors.grey,
                      ),
                      child: Image.asset(
                        image,
                        fit: BoxFit.cover,
                      ),
                    );
                  },
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }
}

TableRow _buildCenteredRow(String time, String description) {
  return TableRow(
    children: [
      TableCell(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              time,
              textAlign: TextAlign.center,
            ),
          ),
        ),
      ),
      TableCell(
        child: Padding(
          padding: EdgeInsets.all(8.0),
          child: Center(
            child: Text(
              description,
              textAlign: TextAlign.left,
            ),
          ),
        ),
      ),
    ],
  );
}

class ProductCard extends StatelessWidget {
  final String imagePath;
  final String productName;

  const ProductCard({required this.imagePath, required this.productName});

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Color.fromARGB(255, 255, 255, 255),
      elevation: 4.0,
      shadowColor: Colors.black26,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(
            imagePath,
            fit: BoxFit.cover,
            width: 250,
            height: 200,
          ),
          SizedBox(height: 5),
          Expanded( 
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 5.0),
              child: Text(
                productName,
                textAlign: TextAlign.center,
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BulletItem extends StatelessWidget {
  final String text;
  final bool isSelected;

  const BulletItem({required this.text, required this.isSelected});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: isSelected ? Colors.orange : Colors.grey,
          ),
        ),
        const SizedBox(width: 5),
        Text(text),
      ],
    );
  }
}
