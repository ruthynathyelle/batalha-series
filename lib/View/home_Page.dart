import 'package:flutter/material.dart';
import 'package:batalha_series/View/ranking_page.dart';
//import 'package:batalha_series/View/pdf.dart';

class HomePage extends StatefulWidget {  // Mudei para StatefulWidget
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final List<Map<String, dynamic>> _series = []; // Lista de séries cadastradas.
  int? _editingIndex; // Índice da série que está sendo editada

  void _showCadastroDialog({int? index}) {
    final TextEditingController nomeController = TextEditingController();
    final TextEditingController generoController = TextEditingController();
    final TextEditingController descricaoController = TextEditingController();
    final TextEditingController capaController = TextEditingController();
    final TextEditingController notaController = TextEditingController();

    // Preenche os campos se for uma edição
    if (index != null) {
      nomeController.text = _series[index]['nome'];
      generoController.text = _series[index]['genero'];
      descricaoController.text = _series[index]['descricao'];
      capaController.text = _series[index]['capa'];
      notaController.text = _series[index]['nota'].toString();
      _editingIndex = index;
    } else {
      _editingIndex = null;
    }

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text(index == null ? 'Cadastrar Série' : 'Editar Série'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nomeController,
                  decoration: const InputDecoration(labelText: 'Nome'),
                ),
                TextField(
                  controller: generoController,
                  decoration: const InputDecoration(labelText: 'Gênero'),
                ),
                TextField(
                  controller: descricaoController,
                  decoration: const InputDecoration(labelText: 'Descrição'),
                ),
                TextField(
                  controller: capaController,
                  decoration: const InputDecoration(labelText: 'URL da Capa'),
                ),
                TextField(
                  controller: notaController,
                  decoration: const InputDecoration(labelText: 'Nota'),
                  keyboardType: TextInputType.number,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancelar'),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {  // Agora podemos usar setState() aqui
                  if (_editingIndex == null) {
                    _series.add({
                      'nome': nomeController.text,
                      'genero': generoController.text,
                      'descricao': descricaoController.text,
                      'capa': capaController.text,
                      'nota': double.tryParse(notaController.text) ?? 0.0,
                    });
                  } else {
                    _series[_editingIndex!] = {
                      'nome': nomeController.text,
                      'genero': generoController.text,
                      'descricao': descricaoController.text,
                      'capa': capaController.text,
                      'nota': double.tryParse(notaController.text) ?? 0.0,
                    };
                  }
                });
                Navigator.of(context).pop(); // Fecha o diálogo.
              },
              child: Text(index == null ? 'Cadastrar' : 'Salvar'),
            ),
          ],
        );
      },
    );
  }

  void _deleteSeries(int index) {
    setState(() {
      _series.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
        title: const Text('Lista de Séries'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.purple,
              ),
              child: Text(
                'Menu',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                ),
              ),
            ),
            ListTile(
              leading: const Icon(Icons.home),
              title: const Text('Início'),
              onTap: () {
                Navigator.pop(context); // Fecha o drawer
                setState(() {});
              },
            ),
            ListTile(
              leading: const Icon(Icons.star),
              title: const Text('Ranking'),
              onTap: () {
                Navigator.pop(context);
                Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => RankingPage(series: _series),
        ),  // Passando a lista de séries
      );
              },
            ),
        
            ListTile(
              leading: const Icon(Icons.report),
              title: const Text('Relatório'),
              onTap: (
              
              ) {
                // Exibe o relatório com todas as séries cadastradas
              },
            ),
          ],
        ),
      ),
      body: _series.isEmpty
          ? const Center(
              child: Text('Nenhuma série cadastrada.'),
            )
          : ListView.builder(
              itemCount: _series.length,
              itemBuilder: (context, index) {
                final serie = _series[index];
                return Card(
                  margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                  child: ListTile(
                    leading: serie['capa'] != null && serie['capa'].isNotEmpty
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
                    subtitle: Text(
                        'Gênero: ${serie['genero']}\nNota: ${serie['nota'].toStringAsFixed(1)}'),
                    isThreeLine: true,
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: const Icon(Icons.edit, color: Colors.purple),
                          onPressed: () => _showCadastroDialog(index: index),
                        ),
                        IconButton(
                          icon: const Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteSeries(index),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showCadastroDialog(),
        tooltip: 'Cadastrar Série',
        child: const Icon(Icons.add),
      ),
    );
  }
}
