import 'package:flutter/material.dart';
import 'package:pdf_viewer_plugin/pdf_viewer_plugin.dart';

class PdfViewTeast extends StatelessWidget {
  const PdfViewTeast({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: PdfView(path: 'https://www.jiwaji.edu/pdf/ecourse/political_science/MBA-HRD_401_PC%20NETWORKING-converted.pdf')
    );
  }
}
