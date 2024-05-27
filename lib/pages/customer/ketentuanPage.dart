import 'package:flutter/material.dart';

class KetentuanPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: Text(
          "Ketentuan Toko",
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            fontFamily: 'Montserrat',
            color: Colors.black,
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Selamat datang di Atma Bakery! Kami dengan senang hati menyediakan layanan pre order dan pembelian langsung (ready) untuk memenuhi segala kebutuhan Anda akan kue-kue lezat kami. Kami memahami bahwa setiap acara istimewa membutuhkan persiapan yang teliti, oleh karena itu, kami mengatur ketentuan yang jelas untuk memastikan pengalaman berbelanja Anda berjalan lancar.",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Pre Order:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            Text(
              "1. Pre order harus dilakukan minimal 2 hari sebelum tanggal pengambilan kue.",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            Text(
              "2. Pembayaran untuk pre order juga harus dilakukan minimal 2 hari sebelum tanggal pengambilan kue.",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            Text(
              "3. Jika pembayaran tidak diterima dalam batas waktu yang ditentukan, pre order akan dibatalkan secara otomatis.",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            Text(
              "4. Pembatalan pre order dapat dilakukan paling lambat 1 hari sebelum tanggal pengambilan kue. Namun, uang yang telah dibayarkan tidak akan dikembalikan.",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Pembelian Langsung (Ready):",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            Text(
              "1. Kue yang tersedia untuk pembelian langsung (ready) dapat dipesan dan diambil pada hari yang sama tanpa perlu pre order sebelumnya.",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            Text(
              "2. Pembayaran untuk kue ready dilakukan saat pengambilan kue di toko.",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Pengambilan Kue:",
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            Text(
              "1. Kue-kue yang telah dipesan harus diambil pada tanggal dan jam yang telah ditentukan.",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            Text(
              "2. Jika kue tidak diambil pada waktu yang telah ditentukan, kami tidak bertanggung jawab atas kualitas kue yang mungkin telah berubah.",
              style: TextStyle(
                fontSize: 14,
                fontFamily: 'Montserrat',
                color: Colors.black,
              ),
            ),
            SizedBox(height: 20),
            Text(
              "Dengan mengikuti ketentuan ini, kami berharap dapat memberikan pelayanan terbaik kepada pelanggan kami dan membuat setiap momen istimewa Anda lebih manis dengan kue-kue spesial dari Atma Bakery. Terima kasih telah mempercayakan kami untuk memenuhi kebutuhan kue Anda!",
              style: TextStyle(
                fontSize: 16,
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
