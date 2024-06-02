import 'package:flutter/material.dart';
import 'package:p3l_atmabakery/pdf/createPDFBahanBakubyDate.dart';
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

  Future<void> _selectDateRange(BuildContext context) async {
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
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
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Ini Laporan Page"),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                final pdfData = await createPdf();
                await Printing.layoutPdf(
                    onLayout: (PdfPageFormat format) async => pdfData);
              },
              child: Text('Generate PDF'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () async {
                await _selectDateRange(context);
                if (startDate != null && endDate != null) {
                  print("Selected date range: $startDate - $endDate");

                  final pdfData = await createPdfBydate(startDate!, endDate!);
                  await Printing.layoutPdf(
                      onLayout: (PdfPageFormat format) async => pdfData);
                }
              },
              child: Text('List Bahan Baku by Date'),
            ),
          ],
        ),
      ),
    );
  }
}
