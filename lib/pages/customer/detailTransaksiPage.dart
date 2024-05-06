import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:p3l_atmabakery/data/userHistory.dart';

class DetailTransaksiPage extends StatelessWidget {
  final UserHistory userHistory;

  const DetailTransaksiPage({Key? key, required this.userHistory}) : super(key: key);

  String formatRupiah(int amount) {
    return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 0).format(amount);
  }

  String getStatusText(String? status) {
    switch (status) {
      case "Terkirim":
        return "Pesanan Selesai";
      case "Dibatalkan":
        return "Pesanan Batal";
      case "Menunggu Pembayaran":
        return "Pesanan Perlu Dibayar";
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
              SizedBox(height: 20),
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
                      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 23),
                    ),
                    Text(
                      'Jl. Babarsari No.43, Janti, Caturtunggal,',
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
                    ),
                    Text(
                      'Kec. Depok, Kabupaten Sleman,',
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
                    ),
                    Text(
                      'Daerah Istimewa Yogyakarta 55281',
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
                    ),
                    SizedBox(height: 5),
                    Text(
                      'AtmaBakery@gmail.uajy.ac.id',
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
                    ),
                    Text(
                      '012-345-6789',
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
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
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
                    ),
                    Text(
                      'Tanggal Lunas: ${userHistory.tanggal_lunas ?? "N/A"}',
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
                    ),
                    Text(
                      'Tanggal Ambil: ${userHistory.tanggal_ambil ?? "N/A"}',
                      style: TextStyle(fontWeight: FontWeight.normal, fontSize: 13),
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
                                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                              ),
                              Text('${userHistory.nama ?? "N/A"}',
                                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
                              Text('${userHistory.email ?? "N/A"}',
                                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12)),
                              Text('${userHistory.no_telp ?? "N/A"}',
                                  style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12)),
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
                                      color: userHistory.tipe_delivery == 'Ambil' ? Colors.white : 
                                            userHistory.tipe_delivery == 'Kurir' ? Colors.white : 
                                            userHistory.tipe_delivery == 'Ojol' ? Colors.white : Colors.grey,
                                    ),
                                  ),
                                  backgroundColor: userHistory.tipe_delivery == 'Ambil' ? Colors.black : 
                                                  userHistory.tipe_delivery == 'Kurir' ? Colors.blue : 
                                                  userHistory.tipe_delivery == 'Ojol' ? Colors.green : Colors.grey,
                                  visualDensity: VisualDensity.compact, 
                                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                                ),
                              ],
                              ),
                              Text('Lokasi: ${userHistory.lokasi ?? "N/A"}',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12)),
                              Text('Keterangan: ${userHistory.keterangan ?? "N/A"}',
                                style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12)),
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
                    if (userHistory.detailTransaksi != null)
                      DataTable(
                        columns: <DataColumn>[
                          DataColumn(label: Text('Nama Produk')),
                          DataColumn(label: Text('Jumlah')),
                          DataColumn(label: Text('Subtotal')),
                        ],
                        rows: userHistory.detailTransaksi!.map((produk) {
                          return DataRow(
                            cells: [
                              DataCell(Text(produk.nama_produk ?? 'N/A')),
                              DataCell(Text(produk.jumlah != null ? produk.jumlah.toString() : 'N/A')),
                              DataCell(Text(produk.subtotal != null ? formatRupiah(produk.subtotal!) : 'N/A')),
                            ],
                          );
                        }).toList(),
                      ),
                    SizedBox(height: 10),
                    Text('Penambahan Poin: ${userHistory.penambahan_poin ?? "N/A"}',
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12)),
                    Text('Poin User Setelah Penambahan: ${userHistory.poin_user_setelah_penambahan ?? "N/A"}',
                    style: TextStyle(fontWeight: FontWeight.normal, fontSize: 12)),
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