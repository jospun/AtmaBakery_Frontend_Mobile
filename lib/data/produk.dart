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

class Hampers {
  final int? id;
  String? nama;
  String? id_kategori;
  String? ukuran;
  int? harga;
  List<String>? foto_produk;
  List<Produk>? products;

  Hampers({
    this.id,
    this.nama,
    this.harga,
    this.foto_produk,
    this.id_kategori,
    this.ukuran,
  });

  String toRawJson() => json.encode(toJson());

  factory Hampers.fromJson(Map<String, dynamic> json) {
    return Hampers(
      id: json['id_hampers'],
      nama: json['nama_hampers'],
      harga: json['harga'],
      ukuran: "",
      id_kategori: "HMP",
      foto_produk: (json['gambar'] as List<dynamic>?)
          ?.map((item) => item['url'] as String)
          .toList(),
    );
  }

  Map<String, dynamic> toJson() => {
        "id_hampers": id,
        "nama_hampers": nama,
        "harga": harga,
        "gambar": foto_produk?.map((url) => {"url": url}).toList(),
      };
}
