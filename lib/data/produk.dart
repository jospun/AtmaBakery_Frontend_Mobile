import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class Produk {
  final int? id;
  String? nama, deskripsi, ukuran;
  String? id_kategori, status;
  int? harga, limit, stok, remaining;
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
      this.status,
      this.remaining,
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
      remaining: json['remaining'],
      stok: json['stok'],
      status: json['status'],
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
        "status": status,
        "gambar": foto_produk?.map((url) => {"url": url}).toList(),
      };
}

class Hampers {
  final int? id;
  String? nama, status;
  String? id_kategori;
  String? ukuran;
  int? harga;
  List<String>? foto_produk;
  List<DetailHampers>? detail_hampers;

  Hampers({
    this.id,
    this.nama,
    this.harga,
    this.foto_produk,
    this.id_kategori,
    this.ukuran,
    this.status,
    this.detail_hampers,
  });

  String toRawJson() => json.encode(toJson());

  factory Hampers.fromJson(Map<String, dynamic> json) {
    return Hampers(
      id: json['id_hampers'],
      nama: json['nama_hampers'],
      harga: json['harga'],
      ukuran: "",
      status: json['status'],
      id_kategori: "HMP",
      foto_produk: (json['gambar'] as List<dynamic>?)
          ?.map((item) => item['url'] as String)
          .toList(),
      detail_hampers: json['detail_hampers'] != null
          ? List<DetailHampers>.from(
              json['detail_hampers'].map((x) => DetailHampers.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "id_hampers": id,
        "nama_hampers": nama,
        "harga": harga,
        "status": status,
        "gambar": foto_produk?.map((url) => {"url": url}).toList(),
      };
}

class DetailHampers {
  final int idDetailHampers;
  final int idHampers;
  final int idProduk;
  final int jumlah;
  final dynamic idBahanBaku;
  final Produk? produk;

  DetailHampers({
    required this.idDetailHampers,
    required this.idHampers,
    required this.idProduk,
    required this.jumlah,
    required this.idBahanBaku,
    required this.produk,
  });

  factory DetailHampers.fromJson(Map<String, dynamic> json) {
    return DetailHampers(
      idDetailHampers: json['id_detail_hampers'],
      idHampers: json['id_hampers'],
      idProduk: json['id_produk'],
      jumlah: json['jumlah'],
      idBahanBaku: json['id_bahan_baku'],
      produk: json['produk'] != null ? Produk.fromJson(json['produk']) : null,
    );
  }
}
