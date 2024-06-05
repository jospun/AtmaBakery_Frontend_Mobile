import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/data/client/laporanClient.dart';
import 'package:p3l_atmabakery/pdf/createPDFBahanBakubyDate.dart';
import 'package:p3l_atmabakery/pdf/createPDFPengeluarandanPemasukkan.dart';
import 'package:pdf/pdf.dart';
import 'package:printing/printing.dart';
import 'package:p3l_atmabakery/pdf/createPDFBahanBakuNow.dart';

class LaporanPage extends StatefulWidget {
  const LaporanPage({super.key});

  @override
  State<LaporanPage> createState() => _LaporanPage();
}

class _LaporanPage extends State<LaporanPage> {
  DateTime? startDate;
  DateTime? endDate;
  DateTime? selectedDate;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );
    if (picked != null &&
        picked != DateTimeRange(start: DateTime.now(), end: DateTime.now())) {
      setState(() {
        startDate = picked.start;
        endDate = picked.end;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Laporan Page'),
        automaticallyImplyLeading: false,
      ),
      body: GridView.count(
        primary: false,
        padding: const EdgeInsets.all(20),
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        crossAxisCount: 2,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: () async {
                final pdfData = await createPdf();
                await Printing.layoutPdf(
                    onLayout: (PdfPageFormat format) async => pdfData);
              },
              child: Text('Laporan Stok Bahan Baku'),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: () async {
                await _selectDateRange(context);
                if (startDate != null && endDate != null) {
                  print("Selected date range: $startDate - $endDate");

                  final pdfData = await createPdfBydate(startDate!, endDate!);
                  await Printing.layoutPdf(
                      onLayout: (PdfPageFormat format) async => pdfData);
                }
              },
              child: Text('Laporan Penggunaan Bahan Baku Periode'),
            ),
          ),
          Container(
            padding: const EdgeInsets.all(8),
            child: ElevatedButton(
              onPressed: () async {
                await _selectDate(context);
                if (selectedDate != null) {
                  print("Selected date: $selectedDate");

                  final laporan = await laporanClient
                      .getPemasukandanPengeluaran(selectedDate!);
                  final pdfData = await createPdfPemasukanPengeluaran(laporan);
                  await Printing.layoutPdf(
                      onLayout: (PdfPageFormat format) async => pdfData);
                  setState(() {
                    selectedDate = null;
                  });
                }
              },
              child: Text('Laporan Pemasukan dan Pengeluaran Bulanan'),
            ),
          ),
        ],
      ),
      //Center(

      //   child: Column(
      //     mainAxisAlignment: MainAxisAlignment.center,
      //     children: [
      //       SizedBox(height: 20),
      //       ElevatedButton(
      //         onPressed: () async {
      //           final pdfData = await createPdf();
      //           await Printing.layoutPdf(
      //               onLayout: (PdfPageFormat format) async => pdfData);
      //         },
      //         child: Text('Cetak Laporan Stok Bahan Baku'),
      //       ),
      //       SizedBox(height: 20),
      //       ElevatedButton(
      //         onPressed: () async {
      //           await _selectDateRange(context);
      //           if (startDate != null && endDate != null) {
      //             print("Selected date range: $startDate - $endDate");

      //             final pdfData = await createPdfBydate(startDate!, endDate!);
      //             await Printing.layoutPdf(
      //                 onLayout: (PdfPageFormat format) async => pdfData);
      //           }
      //         },
      //         child: Text('Cetak Laporan Penggunaan Bahan Baku Periode'),
      //       ),
      //       SizedBox(height: 20),
      //       ElevatedButton(
      //         onPressed: () async {
      //           await _selectDate(context);
      //           if (selectedDate != null) {
      //             print("Selected date: $selectedDate");

      //             final laporan = await laporanClient
      //                 .getPemasukandanPengeluaran(selectedDate!);
      //             final pdfData = await createPdfPemasukanPengeluaran(laporan);
      //             await Printing.layoutPdf(
      //                 onLayout: (PdfPageFormat format) async => pdfData);
      //             setState(() {
      //               selectedDate = null;
      //             });
      //           }
      //         },
      //         child: Text('Cetak Laporan Pemasukan dan Pengeluaran Bulanan'),
      //       ),
      //     ],
      //   ),
      // ),
    );
  }
}
