import 'package:flutter/material.dart';
import 'package:flutter_plugin_pdf_viewer/flutter_plugin_pdf_viewer.dart';

class FilePdfScreen extends StatefulWidget {
  final String url, path, name;

  FilePdfScreen({Key key, this.url, this.path, this.name});

  @override
  _FilePdfScreenState createState() => _FilePdfScreenState();
}

class _FilePdfScreenState extends State<FilePdfScreen> {
  PDFDocument pdfDocument;

  @override
  Widget build(BuildContext context) {
    viewNow() async {
      pdfDocument = await PDFDocument.fromURL(
          widget.url + "file/" + widget.path + "/" + widget.name);
      setState(() {});
    }

    // ignore: missing_return
    Widget loading() {
      viewNow();
      if (pdfDocument == null) {
        return Center(
          child: CircularProgressIndicator(),
        );
      }
    }

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF329d9c),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        title: Text(widget.name),
        centerTitle: true,
      ),
      body: pdfDocument == null
          ? loading()
          : PDFViewer(
              document: pdfDocument,
              showIndicator: true,
              showPicker: true,
              showNavigation: true,
              tooltip: PDFViewerTooltip(
                jump: "Todas las Paginas",
                previous: "Pagina Anterior",
                last: "Ultima Pagina",
                first: "Primera Pagina",
                next: "Pagina Siguiente",
                pick: "Selecciona una Pagina",
              ),
            ),
    );
  }
}
