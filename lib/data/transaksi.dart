import 'dart:convert';

class Transaksi {
  final String noNota;
  final int idUser;
  final DateTime tanggalPesan;
  final DateTime? tanggalLunas;
  final DateTime? tanggalAmbil;
  final int penggunaanPoin;
  final int penambahanPoin;
  final int poinSebelumPenambahan;
  final int poinSetelahPenambahan;
  final double total;
  final double radius;
  final double ongkir;
  final double tip;
  final String tipeDelivery;
  final String buktiPembayaran;
  final String publicId;
  final String status;
  final String namaPenerima;
  final String noTelpPenerima;
  final String lokasi;
  final String keterangan;

  Transaksi({
    required this.noNota,
    required this.idUser,
    required this.tanggalPesan,
    this.tanggalLunas,
    this.tanggalAmbil,
    required this.penggunaanPoin,
    required this.penambahanPoin,
    required this.poinSebelumPenambahan,
    required this.poinSetelahPenambahan,
    required this.total,
    required this.radius,
    required this.ongkir,
    required this.tip,
    required this.tipeDelivery,
    required this.buktiPembayaran,
    required this.publicId,
    required this.status,
    required this.namaPenerima,
    required this.noTelpPenerima,
    required this.lokasi,
    required this.keterangan,
  });

  factory Transaksi.fromJson(Map<String, dynamic> json) {
    return Transaksi(
      noNota: json['no_nota'],
      idUser: json['id_user'],
      tanggalPesan: DateTime.parse(json['tanggal_pesan']),
      tanggalLunas: json['tanggal_lunas'] != null ? DateTime.parse(json['tanggal_lunas']) : null,
      tanggalAmbil: json['tanggal_ambil'] != null ? DateTime.parse(json['tanggal_ambil']) : null,
      penggunaanPoin: json['penggunaan_poin'],
      penambahanPoin: json['penambahan_poin'],
      poinSebelumPenambahan: json['poin_sebelum_penambahan'],
      poinSetelahPenambahan: json['poin_setelah_penambahan'],
      total: json['total'].toDouble(),
      radius: json['radius'].toDouble(),
      ongkir: json['ongkir'].toDouble(),
      tip: json['tip'].toDouble(),
      tipeDelivery: json['tipe_delivery'],
      buktiPembayaran: json['bukti_pembayaran'],
      publicId: json['public_id'],
      status: json['status'],
      namaPenerima: json['nama_penerima'],
      noTelpPenerima: json['no_telp_penerima'],
      lokasi: json['lokasi'],
      keterangan: json['keterangan'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'no_nota': noNota,
      'id_user': idUser,
      'tanggal_pesan': tanggalPesan.toIso8601String(),
      'tanggal_lunas': tanggalLunas?.toIso8601String(),
      'tanggal_ambil': tanggalAmbil?.toIso8601String(),
      'penggunaan_poin': penggunaanPoin,
      'penambahan_poin': penambahanPoin,
      'poin_sebelum_penambahan': poinSebelumPenambahan,
      'poin_setelah_penambahan': poinSetelahPenambahan,
      'total': total,
      'radius': radius,
      'ongkir': ongkir,
      'tip': tip,
      'tipe_delivery': tipeDelivery,
      'bukti_pembayaran': buktiPembayaran,
      'public_id': publicId,
      'status': status,
      'nama_penerima': namaPenerima,
      'no_telp_penerima': noTelpPenerima,
      'lokasi': lokasi,
      'keterangan': keterangan,
    };
  }

  String toRawJson() => json.encode(toJson());
}
