import 'package:flutter/material.dart';

class RankingPage extends StatelessWidget {
  final List<Map<String, dynamic>> series;

  RankingPage({Key? key, required this.series}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Ordenando a lista pela nota de forma decrescente
    List<Map<String, dynamic>> sortedSeries = List.from(series);
    sortedSeries.sort((a, b) => b['nota'].compareTo(a['nota']));

    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        title: const Text('Ranking de Séries'),
      ),
      body: sortedSeries.isEmpty
          ? const Center(child: Text('Nenhuma série cadastrada.'))
          : ListView.builder(
              itemCount: sortedSeries.length,
              itemBuilder: (context, index) {
                final serie = sortedSeries[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: serie['capa'].isNotEmpty
                        ? Image.network(
                            serie['capa'],
                            width: 50,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) {
                              return const Icon(Icons.broken_image);
                            },
                          )
                        : const Icon(Icons.tv),
                    title: Text(serie['nome']),
                    subtitle: Text('Nota: ${serie['nota'].toStringAsFixed(1)}'),
                  ),
                );
              },
            ),
    );
  }
}
