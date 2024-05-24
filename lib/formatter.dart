import 'package:intl/intl.dart';

String formatRupiah(int amount) {
  return NumberFormat.currency(locale: 'id_ID', symbol: 'Rp', decimalDigits: 2)
      .format(amount);
}

String formatTanggal(String date) {
  if (date == 'N/A') {
    return date;
  }

  return DateFormat('dd-MM-yyyy').format(DateTime.parse(date));
}

String formatTanggalWaktu(String date) {
  if (date == 'N/A') {
    return date;
  }

  return DateFormat('dd-MM-yyyy HH:mm:ss').format(DateTime.parse(date));
}

String formatLoyang(String ukuran, String nama) {
  return "$nama $ukuran Loyang";
}
