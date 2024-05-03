import 'dart:convert';
import 'dart:ffi';

class UserHistory {
  final String? token;
  String? no_nota,
      tanggal_pesan,
      tanggal_lunas,
      tanggal_ambil,
      status,
      tipe_delivery;
  int? total;
  final List<DetailTransaksi>? detailTransaksi;

  UserHistory({
    this.token,
    this.no_nota,
    this.tanggal_lunas,
    this.tanggal_pesan,
    this.tanggal_ambil,
    this.status,
    this.tipe_delivery,
    this.detailTransaksi,
    this.total,
  });

  factory UserHistory.fromRawJson(String str) =>
      UserHistory.fromJson(json.decode(str));

  factory UserHistory.fromJson(Map<String, dynamic> json) => UserHistory(
        no_nota: json["no_nota"],
        tanggal_pesan: json["tanggal_pesan"],
        tanggal_lunas: json["tanggal_lunas"],
        tanggal_ambil: json["tanggal_ambil"],
        status: json["status"],
        tipe_delivery: json["tipe_delivery"],
        total: json["total"],
        detailTransaksi: json['detail_transaksi'] != null
            ? List<DetailTransaksi>.from(json['detail_transaksi']
                .map((x) => DetailTransaksi.fromJson(x)))
            : null,
      );

  String toRawJson() => json.encode(toJson());
  Map<String, dynamic> toJson() => {
        "no_nota": no_nota,
        "tanggal_pesan": tanggal_pesan,
        "tanggal_ambil": tanggal_ambil,
        "tanggal_lunas": tanggal_lunas,
        "status": status,
        "tipe_delivery": tipe_delivery,
        "total": total,
      };
}

class DetailTransaksi {
  int? idDetailTransaksi;
  int? id_produk, id_hampers;
  int? jumlah;

  DetailTransaksi(
      {this.idDetailTransaksi, this.id_produk, this.id_hampers, this.jumlah});

  factory DetailTransaksi.fromRawJson(String str) =>
      DetailTransaksi.fromJson(json.decode(str));

  String toRawJson() => json.encode(toJson());

  factory DetailTransaksi.fromJson(Map<String, dynamic> json) {
    return DetailTransaksi(
      idDetailTransaksi: json['id_detail_transaksi'],
      id_produk: json['id_produk'],
      id_hampers: json['id_hampers'],
      jumlah: json['jumlah'],
    );
  }

  Map<String, dynamic> toJson() => {
        "id_detail_transaksi": idDetailTransaksi,
        "id_produk": id_produk,
        "id_hampers": id_hampers,
        "jumlah": jumlah,
      };
}
