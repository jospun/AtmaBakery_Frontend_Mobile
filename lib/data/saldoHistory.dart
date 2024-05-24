import "dart:convert";

class SaldoHistory {
  final int id_histori_saldo;
  final String tanggal;
  final int id_user;
  final double saldo;
  final String namaBank;
  final String noRek;

  SaldoHistory({
    required this.id_histori_saldo,
    required this.tanggal,
    required this.id_user,
    required this.saldo,
    required this.namaBank,
    required this.noRek,
  });

  factory SaldoHistory.fromJson(Map<String, dynamic> json) {
    return SaldoHistory(
      id_histori_saldo: json['id_histori_saldo'],
      tanggal: json['tanggal'],
      id_user: json['id_user'],
      saldo: json['saldo'].toDouble(),
      namaBank: json['nama_bank'],
      noRek: json['no_rek'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id_histori_saldo': id_histori_saldo,
      'tanggal': tanggal,
      'id_user': id_user,
      'saldo': saldo,
      'nama_bank': namaBank,
      'no_rek': noRek,
    };
  }
}
