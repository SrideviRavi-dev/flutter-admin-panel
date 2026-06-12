import 'dart:typed_data';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:admin/features/shop/models/order_model.dart';

class LabelGenerator {
  static Future<Uint8List> generateShippingLabel(OrderModel order) async {
    final pdf = pw.Document();

    final qrImage = await QrPainter(
      data: order.trackingNumber ?? order.id,
      version: QrVersions.auto,
      gapless: false,
    ).toImageData(200);

    pdf.addPage(
      pw.Page(
        pageFormat: PdfPageFormat.a6,
        build: (pw.Context context) {
          return pw.Container(
            padding: const pw.EdgeInsets.all(16),
            child: pw.Column(
              crossAxisAlignment: pw.CrossAxisAlignment.start,
              children: [
                pw.Text("Shipping Label",
                    style: pw.TextStyle(
                        fontSize: 20, fontWeight: pw.FontWeight.bold)),
                pw.SizedBox(height: 10),
                pw.Text("Order ID: ${order.id}"),
                pw.Text("Tracking #: ${order.trackingNumber ?? 'N/A'}"),
                pw.SizedBox(height: 10),
                pw.Text("Ship To:",
                    style: pw.TextStyle(fontWeight: pw.FontWeight.bold)),
                pw.Text("${order.address?.name ?? 'N/A'}"),
                pw.Text(
                    "${order.address?.address ?? ''}, ${order.address?.city ?? ''}"),
                pw.Text(
                    "${order.address?.state ?? ''}, ${order.address?.postalCode ?? ''}"),
                pw.Text("${order.address?.phoneNumber ?? ''}"),   
                pw.SizedBox(height: 20),
                if (qrImage != null)
                  pw.Image(pw.MemoryImage(qrImage.buffer.asUint8List()),
                      width: 100, height: 100),
              ],
            ),
          );
        },
      ),
    );

    return pdf.save();
  }

  static Future<void> printLabel(OrderModel order) async {
    final pdfData = await generateShippingLabel(order);
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async => pdfData);
  }
}
