import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Produk {
  final int? id;
  String? nama, deskripsi, ukuran;
  String? id_kategori;
  int? harga, limit, stok;
  List<String>? foto_produk;

  Produk(
      {this.id,
      this.nama,
      this.deskripsi,
      this.ukuran,
      this.id_kategori,
      this.harga,
      this.limit,
      this.stok,
      this.foto_produk});

  String toRawJson() => json.encode(toJson());

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      id: json['id_produk'],
      nama: json['nama_produk'],
      deskripsi: json['deskripsi'],
      ukuran: json['ukuran'],
      id_kategori: json['id_kategori'],
      harga: json['harga'],
      limit: json['limit'],
      stok: json['stok'],
      foto_produk: (json['gambar'] as List<dynamic>?)
          ?.map((item) => item['url'] as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id_produk": id,
        "nama_produk": nama,
        "deskripsi": deskripsi,
        "ukuran": ukuran,
        "id_kategori": id_kategori,
        "harga": harga,
        "limit": limit,
        "stok": stok,
        "gambar": foto_produk?.map((url) => {"url": url}).toList(),
      };
}
