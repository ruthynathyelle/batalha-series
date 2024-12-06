import 'package:flutter/material.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';

class RelatorioPage extends StatelessWidget {
  // Função que cria o PDF
  Future<void> _gerarRelatorio(BuildContext context) async {
    final pdf = pw.Document();

    // Adicionando uma página ao documento PDF
    pdf.addPage(
      pw.Page(
        build: (pw.Context context) {
          return pw.Center(
            child: pw.Column(
              mainAxisAlignment: pw.MainAxisAlignment.center,
              children: [
                pw.Text(
                  'Relatório de Séries',
                  style: pw.TextStyle(
                    fontSize: 24,
                    fontWeight: pw.FontWeight.bold,
                  ),
                ),
                pw.SizedBox(height: 20),
                pw.Table.fromTextArray(
                  context: context,
                  data: <List<String>>[
                    <String>['Nome', 'Nota'],
                    ..._dadosSeries(),  // Função para obter os dados das séries
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );

    // Imprimindo ou salvando o PDF
    await Printing.layoutPdf(onLayout: (PdfPageFormat format) async {
      return pdf.save();
    });
  }

  // Função para obter os dados das séries
  List<List<String>> _dadosSeries() {
    return [
      ['Breaking Bad', '9.5'],
      ['Game of Thrones', '9.3'],
      ['Stranger Things', '8.7'],
      // Adicione mais séries aqui
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gerar Relatório')),
      body: Center(
        child: ElevatedButton(
          onPressed: () => _gerarRelatorio(context),
          child: const Text('Gerar Relatório em PDF'),
        ),
      ),
    );
  }
}
