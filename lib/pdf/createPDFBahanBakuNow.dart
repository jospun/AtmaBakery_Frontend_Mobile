import 'dart:typed_data';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:p3l_atmabakery/data/bahanBaku.dart';
import 'package:p3l_atmabakery/data/client/laporanClient.dart';

Future<void> initializeDateFormattingForLocale() async {
  await initializeDateFormatting('id_ID', null);
}

Future<Uint8List> createPdf() async {
  await initializeDateFormattingForLocale();
  final image = pw.MemoryImage(
    (await rootBundle.load('assets/images/atma-bakery.png'))
        .buffer
        .asUint8List(),
  );

  final bahanBaku = await laporanClient.getBahanBakuNow();
  final doc = pw.Document();

  doc.addPage(
    pw.MultiPage(
      build: (context) => [
        _headerPdf(context, image),
        _bahanBakuTable(context, bahanBaku),
      ],
    ),
  );

  return doc.save();
}

pw.Widget _bahanBakuTable(pw.Context context, List<BahanBaku> bahanBaku) {
  const tableHeaders = ['Nama Bahan Baku', 'Satuan', 'Stok'];
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
              item.stok.toString(),
            ])
        .toList(),
  );
}

pw.Widget _headerPdf(pw.Context context, pw.ImageProvider image) {
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
                    pw.SizedBox(width: 26.w),
                    pw.Container(
                      padding: const pw.EdgeInsets.only(top: 26),
                      child: pw.Column(
                        mainAxisAlignment: pw.MainAxisAlignment.end,
                        crossAxisAlignment: pw.CrossAxisAlignment.end,
                        children: [
                          pw.Text(
                            'Atma Bakery',
                            style: pw.TextStyle(fontSize: 12),
                            textAlign: pw.TextAlign.right,
                          ),
                          pw.SizedBox(height: 5.h),
                          pw.Text(
                            'Jl. Babarsari No.43, Janti, Caturtunggal, Kec. Depok,\nKabupaten Sleman, Daerah Istimewa Yogyakarta 55281\nAtmaBakery@gmail.uajy.ac.id\n012-345-6789',
                            style: pw.TextStyle(fontSize: 10),
                            textAlign: pw.TextAlign.right,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              pw.Container(
                padding: const pw.EdgeInsets.only(bottom: 30),
                alignment: pw.Alignment.centerLeft,
                child: pw.DefaultTextStyle(
                  style: pw.TextStyle(
                    fontSize: 14,
                  ),
                  child: pw.Column(
                    mainAxisAlignment: pw.MainAxisAlignment.start,
                    crossAxisAlignment: pw.CrossAxisAlignment.start,
                    children: [
                      pw.Text('LAPORAN Stok Bahan Baku',
                          style: pw.TextStyle(
                            fontSize: 12,
                            decoration: pw.TextDecoration.underline,
                          )),
                      pw.SizedBox(height: 1.5.h),
                      pw.Text('Tanggal Cetak : ${_formatDate(DateTime.now())}',
                          style: pw.TextStyle(fontSize: 12),
                          textAlign: pw.TextAlign.left),
                    ],
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
  final format = DateFormat('d MMMM yyyy', 'id_ID');
  return format.format(date);
}
