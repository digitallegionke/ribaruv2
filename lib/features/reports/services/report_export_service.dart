import 'dart:io';
import 'package:excel/excel.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:ribaru_v2/features/reports/domain/models/report_data.dart';
import 'package:share_plus/share_plus.dart';

class ReportExportService {
  Future<void> exportToPdf({
    required String title,
    required List<Map<String, dynamic>> data,
    required List<String> columns,
  }) async {
    final pdf = pw.Document();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text(title, style: pw.TextStyle(fontSize: 24)),
          ),
          pw.SizedBox(height: 20),
          pw.Table.fromTextArray(
            context: context,
            data: [
              columns,
              ...data.map((row) => columns.map((col) => row[col].toString()).toList()),
            ],
          ),
        ],
      ),
    );

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/$title.pdf');
    await file.writeAsBytes(await pdf.save());
    await Share.shareXFiles([XFile(file.path)]);
  }

  Future<void> exportToCsv({
    required String title,
    required List<Map<String, dynamic>> data,
    required List<String> columns,
  }) async {
    final buffer = StringBuffer();
    
    // Add headers
    buffer.writeln(columns.join(','));
    
    // Add data rows
    for (final row in data) {
      buffer.writeln(columns.map((col) => row[col].toString()).join(','));
    }
    
    final output = await getTemporaryDirectory();
    final file = File('${output.path}/$title.csv');
    await file.writeAsBytes(buffer.toString().codeUnits);
    await Share.shareXFiles([XFile(file.path)]);
  }

  Future<void> exportToExcel({
    required String title,
    required List<Map<String, dynamic>> data,
    required List<String> columns,
  }) async {
    final excel = Excel.createExcel();
    final sheet = excel[excel.getDefaultSheet()!];

    // Add headers
    for (var i = 0; i < columns.length; i++) {
      sheet.cell(CellIndex.indexByColumnRow(columnIndex: i, rowIndex: 0))
        ..value = columns[i]
        ..cellStyle = CellStyle(
          bold: true,
          horizontalAlign: HorizontalAlign.Center,
        );
    }

    // Add data
    for (var i = 0; i < data.length; i++) {
      for (var j = 0; j < columns.length; j++) {
        sheet.cell(CellIndex.indexByColumnRow(columnIndex: j, rowIndex: i + 1))
          ..value = data[i][columns[j]]
          ..cellStyle = CellStyle(
            horizontalAlign: HorizontalAlign.Left,
          );
      }
    }

    // Auto-fit columns
    sheet.setColAutoFit(0);

    final output = await getTemporaryDirectory();
    final file = File('${output.path}/$title.xlsx');
    await file.writeAsBytes(excel.encode()!);
    await Share.shareXFiles([XFile(file.path)]);
  }

  Future<void> printReport({
    required String title,
    required List<Map<String, dynamic>> data,
    required List<String> columns,
  }) async {
    final doc = pw.Document();

    doc.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          pw.Header(
            level: 0,
            child: pw.Text(title, style: pw.TextStyle(fontSize: 24)),
          ),
          pw.SizedBox(height: 20),
          pw.Table.fromTextArray(
            context: context,
            data: [
              columns,
              ...data.map((row) => columns.map((col) => row[col].toString()).toList()),
            ],
          ),
        ],
      ),
    );

    await Printing.layoutPdf(
      onLayout: (format) async => doc.save(),
    );
  }

  Future<void> previewPdf({
    required String title,
    required List<Map<String, dynamic>> data,
    required List<String> columns,
    required BuildContext context,
  }) async {
    final pdf = await _generatePdf(title: title, data: data, columns: columns);
    await Printing.layoutPdf(
      onLayout: (format) => pdf.save(),
      name: title,
    );
  }

  Future<pw.Document> _generatePdf({
    required String title,
    required List<Map<String, dynamic>> data,
    required List<String> columns,
  }) async {
    final pdf = pw.Document();
    final logo = await _getLogoImage();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        build: (context) => [
          _buildPdfHeader(title, logo),
          pw.SizedBox(height: 20),
          _buildPdfSummary(data),
          pw.SizedBox(height: 20),
          _buildPdfTable(context, columns, data),
          pw.SizedBox(height: 20),
          _buildPdfFooter(),
        ],
      ),
    );

    return pdf;
  }

  pw.Widget _buildPdfHeader(String title, pw.ImageProvider? logo) {
    return pw.Header(
      level: 0,
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text(title, style: pw.TextStyle(fontSize: 24, font: pw.Font.helveticaBold())),
          if (logo != null)
            pw.Image(logo, width: 60),
        ],
      ),
    );
  }

  pw.Widget _buildPdfSummary(List<Map<String, dynamic>> data) {
    // Add summary statistics
    return pw.Container(
      padding: const pw.EdgeInsets.all(10),
      decoration: pw.BoxDecoration(
        border: pw.Border.all(),
        borderRadius: const pw.BorderRadius.all(pw.Radius.circular(10)),
      ),
      child: pw.Column(
        crossAxisAlignment: pw.CrossAxisAlignment.start,
        children: [
          pw.Text('Summary', style: pw.TextStyle(fontSize: 18, font: pw.Font.helveticaBold())),
          pw.SizedBox(height: 10),
          pw.Text('Total Records: ${data.length}'),
          pw.Text('Generated: ${DateTime.now().toString()}'),
        ],
      ),
    );
  }

  pw.Widget _buildPdfTable(pw.Context context, List<String> columns, List<Map<String, dynamic>> data) {
    return pw.Table.fromTextArray(
      context: context,
      headerStyle: pw.TextStyle(font: pw.Font.helveticaBold()),
      headerDecoration: pw.BoxDecoration(
        color: PdfColors.grey300,
      ),
      cellHeight: 30,
      cellAlignments: {
        0: pw.Alignment.centerLeft,
        1: pw.Alignment.center,
        2: pw.Alignment.centerRight,
      },
      data: [
        columns,
        ...data.map((row) => columns.map((col) => row[col].toString()).toList()),
      ],
    );
  }

  pw.Widget _buildPdfFooter() {
    return pw.Footer(
      margin: const pw.EdgeInsets.only(top: 20),
      child: pw.Row(
        mainAxisAlignment: pw.MainAxisAlignment.spaceBetween,
        children: [
          pw.Text('Generated by Ribaru Business Management'),
          pw.Text('Page ${pw.PageNumber()}'),
        ],
      ),
    );
  }

  Future<pw.ImageProvider?> _getLogoImage() async {
    try {
      final logoFile = File('assets/images/logo.png');
      if (await logoFile.exists()) {
        return pw.MemoryImage(await logoFile.readAsBytes());
      }
    } catch (e) {
      print('Error loading logo: $e');
    }
    return null;
  }

  Future<void> exportSalesReport(SalesReport report) async {
    final data = [
      {
        'Date': report.date.toString(),
        'Total Sales': report.totalSales,
        'Total Orders': report.totalOrders,
        'Average Order Value': report.averageOrderValue,
        'Net Sales': report.netSales,
      },
      ...report.topProducts.map((product) => {
            'Product': product.productName,
            'Quantity': product.quantity,
            'Total Sales': product.totalSales,
            'Average Price': product.averagePrice,
          }),
    ];

    final columns = [
      'Date',
      'Total Sales',
      'Total Orders',
      'Average Order Value',
      'Net Sales',
      'Product',
      'Quantity',
      'Average Price',
    ];

    await exportToPdf(
      title: 'Sales Report',
      data: data,
      columns: columns,
    );
  }

  Future<void> exportInventoryReport(InventoryReport report) async {
    final data = report.products.map((product) => {
          'Product': product.productName,
          'Current Stock': product.currentStock,
          'Minimum Stock': product.minimumStock,
          'Value': product.value,
        }).toList();

    final columns = [
      'Product',
      'Current Stock',
      'Minimum Stock',
      'Value',
    ];

    await exportToExcel(
      title: 'Inventory Report',
      data: data,
      columns: columns,
    );
  }

  Future<void> exportFinancialSummary(FinancialSummary summary) async {
    final data = [
      {
        'Period': '${summary.startDate} - ${summary.endDate}',
        'Total Revenue': summary.totalRevenue,
        'Total Costs': summary.totalCosts,
        'Gross Profit': summary.grossProfit,
        'Net Profit': summary.netProfit,
        'Taxes': summary.taxes,
        'Expenses': summary.expenses,
      },
      ...summary.expenseBreakdown.entries.map((e) => {
            'Category': e.key,
            'Amount': e.value,
          }),
    ];

    final columns = [
      'Period',
      'Total Revenue',
      'Total Costs',
      'Gross Profit',
      'Net Profit',
      'Taxes',
      'Expenses',
      'Category',
      'Amount',
    ];

    await exportToPdf(
      title: 'Financial Summary',
      data: data,
      columns: columns,
    );
  }

  Future<void> exportAnalyticsSummary(AnalyticsSummary summary) async {
    final data = [
      {
        'Growth Rate': '${summary.growthRate}%',
      },
      ...summary.categoryDistribution.entries.map((e) => {
            'Category': e.key,
            'Sales Value': e.value,
          }),
      ...summary.paymentMethodDistribution.entries.map((e) => {
            'Payment Method': e.key,
            'Amount': e.value,
          }),
    ];

    final columns = [
      'Growth Rate',
      'Category',
      'Sales Value',
      'Payment Method',
      'Amount',
    ];

    await exportToExcel(
      title: 'Analytics Summary',
      data: data,
      columns: columns,
    );
  }
}
