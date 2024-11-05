import 'package:cloud_firestore/cloud_firestore.dart'; // Importa o pacote do Cloud Firestore.
import '../models/idea_model.dart'; // Importa o modelo da ideia.

class FirebaseService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance; // Cria uma instância do Firestore.
  final String collectionName = 'ideias'; // Nome da coleção no Firestore onde as ideias serão armazenadas.

  // Método para adicionar uma nova ideia
  Future<void> addIdea(String title, String description) async {
    try {
      // Adiciona um novo documento na coleção de ideias com os dados fornecidos.
      await _firestore.collection(collectionName).add({
        'titulo': title, // Armazena o título da ideia.
        'descricao': description, // Armazena a descrição da ideia.
        'criadoEm': FieldValue.serverTimestamp(), // Armazena a data de criação da ideia.
      });
    } catch (e) {
      // Trata erros ao adicionar a ideia e imprime a mensagem de erro.
      print("Erro ao adicionar ideia: $e");
      throw e; // Lança o erro para ser tratado em outro lugar.
    }
  }

  // Método para obter todas as ideias
  Stream<List<Idea>> getIdeas() {
    return _firestore
        .collection(collectionName) // Acessa a coleção de ideias.
        .orderBy('criadoEm', descending: true) // Ordena os documentos pela data de criação em ordem decrescente.
        .snapshots() // Obtém um stream de atualizações em tempo real.
        .map((snapshot) => snapshot.docs // Mapeia os documentos do snapshot.
            .map((doc) => Idea.fromFirestore(doc)) // Converte cada documento em uma instância da classe Idea.
            .toList()); // Retorna a lista de ideias.
  }

  // Método para atualizar uma ideia existente
  Future<void> updateIdea(String id, String title, String description) async {
    try {
      // Atualiza o documento da ideia na coleção com o id fornecido.
      await _firestore.collection(collectionName).doc(id).update({
        'titulo': title, // Atualiza o título da ideia.
        'descricao': description, // Atualiza a descrição da ideia.
        'atualizadoEm': FieldValue.serverTimestamp(), // Armazena a data de atualização da ideia.
      });
    } catch (e) {
      // Trata erros ao atualizar a ideia e imprime a mensagem de erro.
      print("Erro ao atualizar ideia: $e");
      throw e; // Lança o erro para ser tratado em outro lugar.
    }
  }

  // Método para excluir uma ideia
  Future<void> deleteIdea(String id) async {
    try {
      // Exclui o documento da ideia na coleção com o id fornecido.
      await _firestore.collection(collectionName).doc(id).delete();
    } catch (e) {
      // Trata erros ao excluir a ideia e imprime a mensagem de erro.
      print("Erro ao excluir ideia: $e");
      throw e; // Lança o erro para ser tratado em outro lugar.
    }
  }

  // Método para obter uma ideia específica pelo ID
  Future<Idea> getIdeaById(String id) async {
    DocumentSnapshot doc =
        await _firestore.collection(collectionName).doc(id).get(); // Obtém o documento da ideia pelo id.
    return Idea.fromFirestore(doc); // Retorna a ideia convertida a partir do documento.
  }
}
