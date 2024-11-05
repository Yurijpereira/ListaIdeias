import 'package:flutter/material.dart'; // Importa o pacote Material do Flutter, que fornece componentes de interface do usuário.
import 'package:provider/provider.dart'; // Importa o pacote Provider para gerenciar estado.
import '../viewmodels/idea_viewmodel.dart'; // Importa o ViewModel que gerencia a lógica de ideias.

class AddIdeaScreen extends StatelessWidget {
  // Controladores de texto para capturar a entrada do usuário.
  final TextEditingController titleController = TextEditingController(); // Controlador para o campo de título.
  final TextEditingController descriptionController = TextEditingController(); // Controlador para o campo de descrição.

  @override
  Widget build(BuildContext context) {
    // Obtém a instância do IdeaViewModel do Provider.
    final ideaViewModel = Provider.of<IdeaViewModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Ideia'), // Título da barra de aplicativo.
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0), // Adiciona espaçamento ao redor do conteúdo.
        child: Column(
          children: [
            TextField(
              controller: titleController, // Liga o campo de texto ao controlador de título.
              decoration: const InputDecoration(labelText: 'Título da Ideia'), // Define o rótulo do campo de texto.
            ),
            TextField(
              controller: descriptionController, // Liga o campo de texto ao controlador de descrição.
              decoration: const InputDecoration(labelText: 'Descrição da Ideia'), // Define o rótulo do campo de texto.
            ),
            ElevatedButton(
              onPressed: ideaViewModel.isLoading // Desabilita o botão se estiver carregando.
                  ? null // Se isLoading for verdadeiro, o botão fica desabilitado.
                  : () async {
                      // Chama a função para adicionar a ideia quando o botão é pressionado.
                      await ideaViewModel.addIdea(
                        titleController.text, // Passa o texto do controlador de título.
                        descriptionController.text, // Passa o texto do controlador de descrição.
                      );
                      Navigator.pop(context); // Volta para a tela anterior após adicionar a ideia.
                    },
              child: const Text('Adicionar Ideia'), // Texto do botão para adicionar a ideia.
            ),
          ],
        ),
      ),
    );
  }
}