import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p3l_atmabakery/data/userHistory.dart';

class DetailTransaksiPage extends StatelessWidget {
  final UserHistory userHistory;
  const DetailTransaksiPage({Key? key, required this.userHistory})
      : super(key: key);

  String formatRupiah(int amount) {
    return NumberFormat.currency(
            locale: 'id_ID', symbol: 'Rp', decimalDigits: 0)
        .format(amount);
  }

  String formatLoyang(String ukuran, String nama) {
    return "$nama $ukuran Loyang";
  }

  String getStatusText(String? status) {
    switch (status) {
      case "Sedang Diproses":
        return "Pesanan Sedang Dibuat";
      case "Sedang Dikirim":
        return "Pesanan Dalam Perjalanan";
      case "Dibatalkan":
        return "Pesanan Batal";
      case "Menunggu Pembayaran":
        return "Pesanan Perlu Dibayar";
      case "Menunggu Konfirmasi":
        return "Pesanan Sedang dicek oleh admin";
      case "Diterima":
        return "Pesanan Selesai";
      case "Terkirim":
        return "Pesanan Selesai";
      default:
        return "N/A";
    }
  }

  Icon getStatusIcon(String? status) {
    switch (status) {
      case "Terkirim":
        return Icon(Icons.check_circle_outline_outlined, color: Colors.black);
      default:
        return Icon(Icons.error_outline_outlined, color: Colors.black);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("Detail Transaksi: ${userHistory.detailTransaksi}");

    return Scaffold(
      appBar: AppBar(
        title: Text('Detail Pesanan'),
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        backgroundColor: Color.fromARGB(255, 248, 248, 248),
      ),
      backgroundColor: Color.fromARGB(255, 248, 248, 248),
      body: SingleChildScrollView(
        child: Container(
          padding: EdgeInsets.all(20),
          color: Color.fromARGB(255, 248, 248, 248),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${userHistory.no_nota?.split('.').last ?? "N/A"}',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
              ),
              SizedBox(height: 5),
              Row(
                children: [
                  getStatusIcon(userHistory.status),
                  SizedBox(width: 5),
                  Text(
                    getStatusText(userHistory.status),
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                ],
              ),
              SizedBox(height: 15),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                padding: EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(10),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Atma Bakery',
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                    ),
                    Text(
                      'Jl. Babarsari No.43, Janti, Caturtunggal,',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 13),
                    ),
                    Text(
                      'Kec. Depok, Kabupaten Sleman,',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 13),
                    ),
                    Text(
                      'Daerah Istimewa Yogyakarta 55281',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 13),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'AtmaBakery@gmail.uajy.ac.id',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 13),
                    ),
                    Text(
                      '012-345-6789',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 13),
                    ),
                    SizedBox(height: 5),
                    Divider(
                      color: const Color.fromARGB(255, 232, 232, 232),
                      thickness: 1,
                      height: 20,
                      indent: 0,
                      endIndent: 0,
                    ),
                    SizedBox(height: 5),
                    Text(
                      'Tanggal Pesan: ${userHistory.tanggal_pesan ?? "N/A"}',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 13),
                    ),
                    Text(
                      'Tanggal Lunas: ${userHistory.tanggal_lunas ?? "N/A"}',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 13),
                    ),
                    Text(
                      'Tanggal Ambil: ${userHistory.tanggal_ambil ?? "N/A"}',
                      style: TextStyle(
                          fontWeight: FontWeight.normal, fontSize: 13),
                    ),
                    SizedBox(height: 5),
                    Divider(
                      color: const Color.fromARGB(255, 232, 232, 232),
                      thickness: 1,
                      height: 20,
                      indent: 0,
                      endIndent: 0,
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Pelanggan',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text('${userHistory.nama ?? "N/A"}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12)),
                              Text('${userHistory.email ?? "N/A"}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12)),
                              Text('${userHistory.no_telp ?? "N/A"}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12)),
                            ],
                          ),
                        ),
                        SizedBox(width: 20),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Text(
                                    'Tipe Delivery: ',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12,
                                      color: Colors.black,
                                    ),
                                  ),
                                  Chip(
                                    label: Text(
                                      '${userHistory.tipe_delivery ?? "N/A"}',
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 12,
                                        color: userHistory.tipe_delivery ==
                                                'Ambil'
                                            ? Colors.white
                                            : userHistory.tipe_delivery ==
                                                    'Kurir'
                                                ? Colors.white
                                                : userHistory.tipe_delivery ==
                                                        'Ojol'
                                                    ? Colors.white
                                                    : Colors.grey,
                                      ),
                                    ),
                                    backgroundColor:
                                        userHistory.tipe_delivery == 'Ambil'
                                            ? Colors.black
                                            : userHistory.tipe_delivery ==
                                                    'Kurir'
                                                ? Colors.blue
                                                : userHistory.tipe_delivery ==
                                                        'Ojol'
                                                    ? Colors.green
                                                    : Colors.grey,
                                    visualDensity: VisualDensity.compact,
                                    materialTapTargetSize:
                                        MaterialTapTargetSize.shrinkWrap,
                                  ),
                                ],
                              ),
                              Text('Lokasi: ${userHistory.lokasi ?? "N/A"}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12)),
                              Text(
                                  'Keterangan: ${userHistory.keterangan ?? "N/A"}',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Ringkasan Pesanan',
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: DataTable(
                        columns: <DataColumn>[
                          DataColumn(
                              label: Text('No',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))),
                          DataColumn(
                              label: Text('Produk',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))),
                          DataColumn(
                              label: Text('Jumlah',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))),
                          DataColumn(
                              label: Text('Sub Total',
                                  style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 12))),
                        ],
                        rows: [
                          ...userHistory.detailTransaksi!
                              .asMap()
                              .entries
                              .map((entry) {
                            final index = entry.key + 1;
                            final produk = entry.value;
                            return DataRow(cells: [
                              DataCell(Text(index.toString(),
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12))),
                              DataCell(Text(
                                  produk.id_kategori
                                              .toString()
                                              .compareTo("CK") ==
                                          0
                                      ? formatLoyang(
                                          produk.ukuran!, produk.nama_produk!)
                                      : produk.nama_produk!,
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12))),
                              DataCell(Text(produk.jumlah?.toString() ?? 'N/A',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12))),
                              DataCell(Text(
                                  produk.subtotal != null
                                      ? formatRupiah(produk.subtotal!)
                                      : 'N/A',
                                  style: TextStyle(
                                      fontWeight: FontWeight.normal,
                                      fontSize: 12))),
                            ]);
                          }),
                          DataRow(cells: [
                            DataCell(Text('',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12))),
                            DataCell(Text('Potongan Poin',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12))),
                            DataCell(Text('0',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12))),
                            DataCell(Text(
                                formatRupiah(
                                    (userHistory.penggunaan_poin ?? 0) * 100),
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12))),
                          ]),
                          DataRow(cells: [
                            DataCell(Text('',
                                style: TextStyle(
                                    fontWeight: FontWeight.normal,
                                    fontSize: 12))),
                            DataCell(Text('Total',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12))),
                            DataCell(Text('',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12))),
                            DataCell(Text(formatRupiah(userHistory.total ?? 0),
                                style: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12))),
                          ]),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: const Color.fromRGBO(244, 142, 40, 1),
                        borderRadius: BorderRadius.circular(5),
                      ),
                      child: Text(
                        'Penambahan Poin: ${userHistory.penambahan_poin ?? "N/A"}',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 5, horizontal: 10),
                      decoration: BoxDecoration(
                        color: Color.fromARGB(255, 255, 255, 255),
                        borderRadius: BorderRadius.circular(5),
                        border: Border.all(
                            color: const Color.fromRGBO(244, 142, 40, 1)),
                      ),
                      child: Text(
                        'Poin User Setelah Penambahan: ${userHistory.poin_user_setelah_penambahan ?? "N/A"}',
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.normal,
                          fontSize: 12,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
