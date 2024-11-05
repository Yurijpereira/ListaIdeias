import 'package:cloud_firestore/cloud_firestore.dart'; // Importa o pacote do Cloud Firestore.

// Classe modelo para representar uma ideia
class Idea {
  String id; // ID da ideia
  String title; // Título da ideia
  String description; // Descrição da ideia
  DateTime? createdAt; // Data de criação da ideia
  DateTime? updatedAt; // Data de atualização da ideia

  // Construtor da classe Idea que recebe os parâmetros obrigatórios e opcionais
  Idea({
    required this.id, // ID é obrigatório
    required this.title, // Título é obrigatório
    required this.description, // Descrição é obrigatória
    this.createdAt, // Data de criação é opcional
    this.updatedAt, // Data de atualização é opcional
  });

  // Método para criar uma ideia a partir de um documento Firestore
  factory Idea.fromFirestore(DocumentSnapshot doc) {
    // Obtém os dados do documento Firestore
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Idea(
      id: doc.id, // Atribui o ID do documento à propriedade id
      title: data['titulo'] ?? '', // Atribui o título, ou uma string vazia se não existir
      description: data['descricao'] ?? '', // Atribui a descrição, ou uma string vazia se não existir
      createdAt: (data['criadoEm'] as Timestamp?)?.toDate(), // Converte o Timestamp para DateTime
      updatedAt: (data['atualizadoEm'] as Timestamp?)?.toDate(), // Converte o Timestamp para DateTime
    );
  }

  // Método para converter a ideia em um mapa (para salvar no Firestore)
  Map<String, dynamic> toMap() {
    return {
      'titulo': title, // Mapeia o título da ideia
      'descricao': description, // Mapeia a descrição da ideia
      'criadoEm': FieldValue.serverTimestamp(), // Atribui a data de criação (servidor)
      'atualizadoEm': FieldValue.serverTimestamp(), // Atribui a data de atualização (servidor)
    };
  }
}