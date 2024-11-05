import 'package:flutter/material.dart'; // Importa o pacote Material do Flutter, que fornece componentes de interface do usuário.
import 'package:provider/provider.dart'; // Importa o pacote Provider, que facilita o gerenciamento de estado.
import '../viewmodels/idea_viewmodel.dart'; // Importa o ViewModel para gerenciar a lógica de negócios relacionada às ideias.
import '../models/idea_model.dart'; // Importa o modelo de dados da ideia.

class UpdateIdeaScreen extends StatefulWidget {
  final Idea idea; // Recebe uma instância de Idea como parâmetro.

  // Construtor que requer uma ideia.
  UpdateIdeaScreen({required this.idea});

  @override
  _UpdateIdeaScreenState createState() => _UpdateIdeaScreenState(); // Cria o estado associado a esta tela.
}

class _UpdateIdeaScreenState extends State<UpdateIdeaScreen> {
  late TextEditingController titleController; // Controlador para o campo de texto do título.
  late TextEditingController descriptionController; // Controlador para o campo de texto da descrição.

  @override
  void initState() {
    super.initState(); // Chama o método da classe pai.
    // Inicializa os controladores com os valores da ideia passada.
    titleController = TextEditingController(text: widget.idea.title);
    descriptionController = TextEditingController(text: widget.idea.description);
  }

  @override
  void dispose() {
    // Libera os controladores quando o estado não é mais necessário.
    titleController.dispose();
    descriptionController.dispose();
    super.dispose(); // Chama o método da classe pai.
  }

  @override
  Widget build(BuildContext context) {
    // Obtém a instância do IdeaViewModel do contexto.
    final ideaViewModel = Provider.of<IdeaViewModel>(context);

    return Scaffold( // Estrutura básica de tela do Flutter.
      appBar: AppBar(
        title: const Text('Atualizar Ideia'), // Título da AppBar.
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adiciona um espaçamento ao redor do conteúdo.
        child: Column( // Organiza os widgets em uma coluna vertical.
          children: [
            TextField(
              controller: titleController, // Liga o controlador ao campo de texto.
              decoration: const InputDecoration(labelText: 'Título da Ideia'), // Define a etiqueta do campo de texto.
            ),
            TextField(
              controller: descriptionController, // Liga o controlador ao campo de texto.
              decoration: const InputDecoration(labelText: 'Descrição da Ideia'), // Define a etiqueta do campo de texto.
            ),
            ElevatedButton(
              onPressed: ideaViewModel.isLoading // Desabilita o botão se estiver carregando.
                  ? null
                  : () async {
                      // Atualiza a ideia com os dados do controlador.
                      await ideaViewModel.updateIdea(
                        widget.idea.id, // ID da ideia a ser atualizada.
                        titleController.text, // Novo título.
                        descriptionController.text, // Nova descrição.
                      );
                      Navigator.pop(context); // Volta para a tela anterior após a atualização.
                    },
              child: const Text('Atualizar Ideia'), // Texto do botão.
            ),
          ],
        ),
      ),
    );
  }
}
