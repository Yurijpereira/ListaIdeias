import 'package:flutter/material.dart'; // Importa o pacote Material do Flutter para usar widgets de UI.
import '../services/firebase_service.dart'; // Importa o serviço que lida com a interação com o Firebase.
import '../models/idea_model.dart'; // Importa o modelo de dados para a ideia.

class IdeaViewModel with ChangeNotifier {
  final FirebaseService firebaseService = FirebaseService(); // Cria uma instância do serviço Firebase.
  List<Idea> ideas = []; // Lista que armazena as ideias.
  bool isLoading = true; // Variável para controlar o estado de carregamento.

  IdeaViewModel() {
    fetchIdeas(); // Chama o método para buscar as ideias ao inicializar o ViewModel.
  }

  // Método assíncrono para buscar as ideias do Firebase.
  Future<void> fetchIdeas() async {
    isLoading = true; // Define o estado de carregamento como verdadeiro.
    notifyListeners(); // Notifica os ouvintes sobre a mudança de estado.

    try {
      // Escuta as mudanças na coleção de ideias do Firebase.
      firebaseService.getIdeas().listen((newIdeas) {
        ideas = newIdeas; // Atualiza a lista de ideias com as novas ideias recebidas.
        isLoading = false; // Define o estado de carregamento como falso.
        notifyListeners(); // Notifica os ouvintes sobre a mudança.
      }, onError: (error) {
        // Trata erros ao obter as ideias.
        print("Erro ao obter ideias: $error");
        isLoading = false; // Define o estado de carregamento como falso.
        notifyListeners(); // Notifica os ouvintes sobre a mudança.
      });
    } catch (e) {
      // Trata erros inesperados ao buscar ideias.
      print("Erro ao buscar ideias: $e");
      isLoading = false; // Define o estado de carregamento como falso.
      notifyListeners(); // Notifica os ouvintes sobre a mudança.
    }
  }

  // Método assíncrono para adicionar uma nova ideia.
  Future<void> addIdea(String title, String description) async {
    isLoading = true; // Define o estado de carregamento como verdadeiro.
    notifyListeners(); // Notifica os ouvintes sobre a mudança.

    try {
      await firebaseService.addIdea(title, description); // Adiciona a nova ideia no Firebase.
      // Chama fetchIdeas para garantir que a lista esteja atualizada após a adição.
      await fetchIdeas();
    } catch (e) {
      // Trata erros ao adicionar a ideia.
      print("Erro ao adicionar ideia: $e");
    } finally {
      isLoading = false; // Define o estado de carregamento como falso.
      notifyListeners(); // Notifica os ouvintes sobre a mudança.
    }
  }

  // Método assíncrono para excluir uma ideia existente.
  Future<void> deleteIdea(String id) async {
    isLoading = true; // Define o estado de carregamento como verdadeiro.
    notifyListeners(); // Notifica os ouvintes sobre a mudança.

    try {
      await firebaseService.deleteIdea(id); // Exclui a ideia do Firebase.
      // Remove a ideia da lista local com base no id.
      ideas.removeWhere((idea) => idea.id == id);
      notifyListeners(); // Notifica os ouvintes sobre a mudança.
    } catch (e) {
      // Trata erros ao excluir a ideia.
      print("Erro ao excluir ideia: $e");
    } finally {
      isLoading = false; // Define o estado de carregamento como falso.
      notifyListeners(); // Notifica os ouvintes sobre a mudança.
    }
  }

  // Método assíncrono para atualizar uma ideia existente.
  Future<void> updateIdea(String id, String title, String description) async {
    isLoading = true; // Define o estado de carregamento como verdadeiro.
    notifyListeners(); // Notifica os ouvintes sobre a mudança.

    try {
      await firebaseService.updateIdea(id, title, description); // Atualiza a ideia no Firebase.
      // Atualiza a ideia na lista local.
      final index = ideas.indexWhere((idea) => idea.id == id); // Encontra o índice da ideia a ser atualizada.
      if (index != -1) { // Verifica se a ideia foi encontrada.
        ideas[index].title = title; // Atualiza o título da ideia.
        ideas[index].description = description; // Atualiza a descrição da ideia.
        notifyListeners(); // Notifica os ouvintes sobre a mudança.
      }
    } catch (e) {
      // Trata erros ao atualizar a ideia.
      print("Erro ao atualizar ideia: $e");
    } finally {
      isLoading = false; // Define o estado de carregamento como falso.
      notifyListeners(); // Notifica os ouvintes sobre a mudança.
    }
  }
}
