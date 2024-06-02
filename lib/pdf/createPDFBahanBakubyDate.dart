import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:p3l_atmabakery/data/bahanBaku.dart';
import 'package:p3l_atmabakery/data/client/bahanBakuClient.dart';

Future<Uint8List> createPdfBydate(
    DateTime tanggalAwal, DateTime tanggalAkhir) async {
  final image = pw.MemoryImage(
    (await rootBundle.load('assets/images/atma-bakery.png'))
        .buffer
        .asUint8List(),
  );

  final bahanBaku =
      await bahanBakuClient.getBahanBakubyDate(tanggalAwal, tanggalAkhir);
  final doc = pw.Document();

  doc.addPage(
    pw.MultiPage(
      build: (context) => [
        _headerPdf(context, image, tanggalAwal, tanggalAkhir),
        _bahanBakuTable(context, bahanBaku),
      ],
    ),
  );

  return doc.save();
}

pw.Widget _bahanBakuTable(pw.Context context, List<BahanBaku> bahanBaku) {
  const tableHeaders = ['Nama Bahan Baku', 'Satuan', 'Digunakan'];
  return pw.Table.fromTextArray(
    border: null,
    cellAlignment: pw.Alignment.centerLeft,
    headerDecoration: pw.BoxDecoration(
      color: PdfColors.grey,
      borderRadius: const pw.BorderRadius.all(pw.Radius.circular(2)),
    ),
    headerHeight: 25,
    cellHeight: 40,
    cellAlignments: {
      0: pw.Alignment.centerLeft,
      1: pw.Alignment.centerLeft,
      2: pw.Alignment.center,
    },
    cellStyle: const pw.TextStyle(
      color: PdfColors.black,
      fontSize: 10,
    ),
    headers: tableHeaders,
    data: bahanBaku
        .map((item) => [
              item.nama ?? '',
              item.satuan ?? '',
              item.digunakan.toString(),
            ])
        .toList(),
  );
}

pw.Widget _headerPdf(
    pw.Context context, pw.ImageProvider image, tanggalAwal, tanggalAkhir) {
  return pw.Column(
    children: [
      pw.Row(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Column(
            crossAxisAlignment: pw.CrossAxisAlignment.start,
            children: [
              pw.Container(
                padding: const pw.EdgeInsets.only(bottom: 10),
                alignment: pw.Alignment.centerLeft,
                child: pw.Row(
                  crossAxisAlignment: pw.CrossAxisAlignment.start,
                  mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
                  children: [
                    pw.Container(
                      height: 62,
                      child: pw.Image(image),
                    ),
                    pw.SizedBox(width: 280),
                    pw.Container(
                        padding: const pw.EdgeInsets.only(top: 26),
                        child: pw.Text('Atma Bakery')),
                  ],
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.only(bottom: 30),
                alignment: pw.Alignment.centerLeft,
                child: pw.DefaultTextStyle(
                  style: pw.TextStyle(
                    fontSize: 14,
                    fontWeight: pw.FontWeight.bold,
                  ),
                  child: pw.Container(
                    child: pw.Text(
                        'List Penggunaan Bahan Baku ${_formatDate(tanggalAwal)} - ${_formatDate(tanggalAkhir)} '),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}

String _formatDate(DateTime date) {
  final format = DateFormat.yMMMd('en_US');
  return format.format(date);
}
