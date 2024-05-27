import 'package:flutter/material.dart';

class PrivacyPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Kebijakan Privasi",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Kebijakan Privasi Atma Bakery",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 10),
            Text(
              "Pengumpulan Informasi:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            Text(
              "1. Kami mengumpulkan informasi yang Anda berikan saat melakukan pemesanan, seperti nama, alamat, nomor telepon, dan informasi pembayaran.",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            Text(
              "2. Informasi tersebut digunakan untuk keperluan pengiriman pesanan dan komunikasi terkait pesanan.",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Penggunaan Informasi:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            Text(
              "1. Informasi yang Anda berikan tidak akan disalahgunakan dan hanya digunakan untuk keperluan internal Atma Bakery.",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            Text(
              "2. Kami tidak akan membagikan informasi Anda kepada pihak ketiga tanpa izin Anda, kecuali jika diperlukan oleh hukum.",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Keamanan:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            Text(
              "1. Kami menggunakan langkah-langkah keamanan yang sesuai untuk melindungi informasi pribadi Anda dari akses yang tidak sah.",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            Text(
              "2. Namun, perlu diingat bahwa tidak ada metode transmisi data melalui internet atau metode penyimpanan elektronik yang 100% aman.",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Perubahan Kebijakan:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            Text(
              "Kebijakan privasi ini dapat berubah dari waktu ke waktu. Perubahan signifikan akan diberitahukan kepada Anda dengan cara yang sesuai, misalnya dengan memposting pemberitahuan yang jelas di situs web kami atau dengan mengirimkan email kepada Anda.",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Dengan menggunakan layanan kami, Anda menyetujui kebijakan privasi ini. Jika Anda memiliki pertanyaan tentang kebijakan privasi kami, jangan ragu untuk menghubungi kami.",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
