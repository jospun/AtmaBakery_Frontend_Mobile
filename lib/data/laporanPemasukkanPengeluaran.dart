import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class LaporanPemasukkanPengeluaran {
  int? total_pemasukkan, total_pengeluaran;

  List<Pemasukkan>? pemasukkan;
  List<Pengeluaran>? pengeluaran;

  LaporanPemasukkanPengeluaran({
    this.total_pemasukkan,
    this.total_pengeluaran,
    this.pemasukkan,
    this.pengeluaran,
  });

  factory LaporanPemasukkanPengeluaran.fromRawJson(String str) =>
      LaporanPemasukkanPengeluaran.fromJson(json.decode(str));

  factory LaporanPemasukkanPengeluaran.fromJson(Map<String, dynamic> json) =>
      LaporanPemasukkanPengeluaran(
        total_pemasukkan: json['total_pemasukan'],
        total_pengeluaran: json['total_pengeluaran'],
        pemasukkan: json['pemasukan'] != null
            ? List<Pemasukkan>.from(
                json['pemasukan'].map((x) => Pemasukkan.fromJson(x)))
            : null,
        pengeluaran: json['pengeluaran'] != null
            ? List<Pengeluaran>.from(
                json['pengeluaran'].map((x) => Pengeluaran.fromJson(x)))
            : null,
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "total_pemasukan": total_pemasukkan,
        "total_pengeluaran": total_pengeluaran,
      };
}

class Pemasukkan {
  int? jumlah;

  String? nama;

  Pemasukkan({
    this.nama,
    this.jumlah,
  });

  factory Pemasukkan.fromRawJson(String str) =>
      Pemasukkan.fromJson(json.decode(str));

  factory Pemasukkan.fromJson(Map<String, dynamic> json) => Pemasukkan(
        nama: json["nama"],
        jumlah: json["jumlah"],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "nama": nama,
        "jumlah": jumlah.toString(),
      };
}

class Pengeluaran {
  int? jumlah;

  String? nama;

  Pengeluaran({
    this.nama,
    this.jumlah,
  });

  factory Pengeluaran.fromRawJson(String str) =>
      Pengeluaran.fromJson(json.decode(str));

  factory Pengeluaran.fromJson(Map<String, dynamic> json) => Pengeluaran(
        nama: json["nama"],
        jumlah: json["jumlah"],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "nama": nama,
        "jumlah": jumlah.toString(),
      };
}
