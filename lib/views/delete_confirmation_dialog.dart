import 'package:flutter/material.dart'; // Importa o pacote Material do Flutter, que fornece componentes de interface do usuário.

class DeleteConfirmationDialog extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Constrói o diálogo de confirmação de exclusão.
    return AlertDialog(
      title: const Text('Excluir Ideia'), // Título do diálogo.
      content: const Text('Tem certeza de que deseja excluir esta ideia?'), // Mensagem de confirmação.
      actions: [ // Ações disponíveis no diálogo.
        TextButton(
          onPressed: () => Navigator.of(context).pop(false), // Ao pressionar "Cancelar", fecha o diálogo e retorna false.
          child: const Text('Cancelar'), // Texto do botão para cancelar a exclusão.
        ),
        TextButton(
          onPressed: () => Navigator.of(context).pop(true), // Ao pressionar "Excluir", fecha o diálogo e retorna true.
          child: const Text('Excluir'), // Texto do botão para confirmar a exclusão.
        ),
      ],
    );
  }
}