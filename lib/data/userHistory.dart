import "dart:convert";

class UserHistory {
  final String? no_nota;
  final String? nama;
  final String? email;
  final String? no_telp;
  final String? lokasi;
  final String? keterangan;
  final String? tanggal_pesan;
  final String? tanggal_lunas;
  final String? tanggal_ambil;
  final String? tipe_delivery;
  final int? penggunaan_poin;
  final int? total;
  final int? radius;
  final int? ongkir;
  final String? status;
  final int? penambahan_poin;
  final int? poin_user_setelah_penambahan;
  final List<Produk>? detailTransaksi;
  final List<Produk>? detailTransaksi1;

  UserHistory({
    this.no_nota,
    this.nama,
    this.email,
    this.no_telp,
    this.lokasi,
    this.keterangan,
    this.tanggal_pesan,
    this.tanggal_lunas,
    this.tanggal_ambil,
    this.tipe_delivery,
    this.penggunaan_poin,
    this.total,
    this.radius,
    this.ongkir,
    this.status,
    this.penambahan_poin,
    this.poin_user_setelah_penambahan,
    this.detailTransaksi,
    this.detailTransaksi1,
  });

  String toRawJson() => json.encode(toJson());

  factory UserHistory.fromJson(Map<String, dynamic> json) {
    return UserHistory(
      no_nota: json['no_nota'],
      nama: json['nama'],
      email: json['email'],
      no_telp: json['no_telp'],
      lokasi: json['lokasi'],
      keterangan: json['keterangan'],
      tanggal_pesan: json['tanggal_pesan'],
      tanggal_lunas: json['tanggal_lunas'],
      tanggal_ambil: json['tanggal_ambil'],
      tipe_delivery: json['tipe_delivery'],
      penggunaan_poin: json['penggunaan_poin'],
      total: json['total'],
      radius: json['radius'],
      ongkir: json['ongkir'],
      status: json['status'],
      penambahan_poin: json['penambahan_poin'],
      poin_user_setelah_penambahan: json['poin_user_setelah_penambahan'],
      detailTransaksi: json['produk'] != null
          ? List<Produk>.from(json['produk'].map((x) => Produk.fromJson(x)))
          : null,
      detailTransaksi1: json['detail_transaksi'] != null
          ? List<Produk>.from(
              json['detail_transaksi'].map((x) => Produk.fromJson(x)))
          : null,
    );
  }

  Map<String, dynamic> toJson() => {
        "no_nota": no_nota,
        "nama": nama,
      };
}

class Produk {
  final String? nama_produk;
  final String? ukuran;
  final int? harga_saat_beli;
  final int? jumlah;
  final int? subtotal;

  Produk({
    this.nama_produk,
    this.ukuran,
    this.harga_saat_beli,
    this.jumlah,
    this.subtotal,
  });

  factory Produk.fromJson(Map<String, dynamic> json) {
    return Produk(
      nama_produk: json['nama_produk'],
      ukuran: json['ukuran'],
      harga_saat_beli: json['harga_saat_beli'],
      jumlah: json['jumlah'],
      subtotal: json['subtotal'],
    );
  }
}
