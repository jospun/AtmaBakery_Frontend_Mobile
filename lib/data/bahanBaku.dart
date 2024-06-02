import 'dart:convert';
import 'dart:io';

import 'package:image_picker/image_picker.dart';

class BahanBaku {
  final int? id, stok, digunakan;

  String? nama, satuan;

  BahanBaku({
    this.id,
    this.stok,
    this.nama,
    this.satuan,
    this.digunakan,
  });

  factory BahanBaku.fromRawJson(String str) =>
      BahanBaku.fromJson(json.decode(str));

  factory BahanBaku.fromJson(Map<String, dynamic> json) => BahanBaku(
        id: json["id_bahan_baku"],
        stok: json["stok"],
        nama: json["nama_bahan_baku"],
        satuan: json["satuan"],
        digunakan: json["digunakan"],
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "id_bahan_baku": id.toString(),
        "stok": stok,
        "nama_bahan_baku": nama,
        "satuan": satuan,
        "digunakan": digunakan,
      };
}
