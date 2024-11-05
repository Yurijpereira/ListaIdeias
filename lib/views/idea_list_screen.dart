import 'package:flutter/material.dart'; // Importa o pacote Material do Flutter, que fornece componentes de interface do usuário.
import 'package:provider/provider.dart'; // Importa o pacote Provider, que facilita o gerenciamento de estado.
import '../viewmodels/idea_viewmodel.dart'; // Importa o ViewModel para gerenciar a lógica de negócios relacionada às ideias.
import 'add_idea_screen.dart'; // Importa a tela para adicionar uma nova ideia.
import 'delete_confirmation_dialog.dart'; // Importa a tela de confirmação de exclusão.
import 'update_idea_screen.dart'; // Importa a tela de atualização.

class IdeaListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Obtém a instância do IdeaViewModel do contexto.
    final ideaViewModel = Provider.of<IdeaViewModel>(context);

    return Scaffold( // Estrutura básica de tela do Flutter.
      appBar: AppBar(
        title: const Text('Lista de Ideias'), // Título da AppBar.
        actions: [
          IconButton(
            icon: const Icon(Icons.add), // Ícone para adicionar uma nova ideia.
            onPressed: () {
              // Navega para a tela de adicionar ideia ao pressionar o botão.
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => AddIdeaScreen()),
              );
            },
          ),
        ],
      ),
      body: ideaViewModel.isLoading // Verifica se os dados estão sendo carregados.
          ? Center(child: CircularProgressIndicator()) // Exibe um indicador de progresso enquanto os dados estão sendo carregados.
          : ListView.builder( // Constrói uma lista de ideias usando ListView.
              itemCount: ideaViewModel.ideas.length, // Número total de ideias a serem exibidas.
              itemBuilder: (context, index) { // Função que constrói cada item da lista.
                final idea = ideaViewModel.ideas[index]; // Obtém a ideia atual pelo índice.
                return ListTile( // Cada item da lista é representado por um ListTile.
                  title: Text(idea.title), // Exibe o título da ideia.
                  subtitle: Text(idea.description), // Exibe a descrição da ideia.
                  trailing: Row( // Coloca os botões de ação à direita do ListTile.
                    mainAxisSize: MainAxisSize.min, // Define o tamanho da linha.
                    children: [
                      IconButton(
                        icon: Icon(Icons.edit), // Ícone de edição.
                        onPressed: () {
                          // Navega para a tela de atualização da ideia ao pressionar o botão.
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => UpdateIdeaScreen(idea: idea),
                            ),
                          );
                        },
                      ),
                      IconButton(
                        icon: Icon(Icons.delete), // Ícone de exclusão.
                        color: Colors.red, // Define a cor do ícone como vermelho.
                        onPressed: () async {
                          // Exibe o diálogo de confirmação ao pressionar o botão de exclusão.
                          final confirmed = await showDialog<bool>(
                            context: context,
                            builder: (context) => DeleteConfirmationDialog(),
                          );

                          // Se o usuário confirmar a exclusão, chama o método para deletar a ideia.
                          if (confirmed == true) {
                            await ideaViewModel.deleteIdea(idea.id);
                          }
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
    );
  }
}
