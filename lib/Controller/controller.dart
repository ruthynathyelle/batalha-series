import 'package:flutter/material.dart';

class SerieController extends ChangeNotifier {
  List<Map<String, dynamic>> _series = [];

  // Getter para obter a lista de séries
  List<Map<String, dynamic>> get series => _series;

  // Função para adicionar uma nova série
  void adicionarSerie(String nome, String capa, String genero, double nota) {
    _series.add({
      'nome': nome,
      'genero': genero, 
      'capa': capa,
      'nota': nota,
    });
    notifyListeners();  // Notifica os ouvintes que o estado mudou
  }

  // Função para editar uma série existente
  void editarSerie(int index, String nome, String capa, String genero, double nota) {
    if (index >= 0 && index < _series.length) {
      _series[index] = {
        'nome': nome,
        'genero': genero,
        'capa': capa,
        'nota': nota,
      };
      notifyListeners();  // Notifica os ouvintes que o estado mudou
    }
  }

  // Função para excluir uma série
  void excluirSerie(int index) {
    if (index >= 0 && index < _series.length) {
      _series.removeAt(index);
      notifyListeners();  // Notifica os ouvintes que o estado mudou
    }
  }
}
