import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:mobile_scanner/mobile_scanner.dart';

class SkanerKamera extends StatefulWidget {
  const SkanerKamera({super.key});

  @override
  State<SkanerKamera> createState() => _SkanerKameraState();
}

class _SkanerKameraState extends State<SkanerKamera> {
  @override
  Widget build(BuildContext context) {
    return MobileScanner(
      controller: MobileScannerController(
          detectionSpeed: DetectionSpeed.noDuplicates, returnImage: true),
      onDetect: (capture) {
        final List barcodes = capture.barcodes;
        final Uint8List? image = capture.image;
        for (final barcode in barcodes) {
          print("Javob ${barcode.rawValue}");
        }
        if (image != null) {
          Navigator.pop(context, [image, barcodes]);
        }
      },
    );
  }
}
