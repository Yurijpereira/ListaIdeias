import 'package:flutter/material.dart'; // Importa o pacote Material Design do Flutter para construção de interfaces.
import 'package:provider/provider.dart'; // Importa o pacote Provider para gerenciar estado de forma reativa.
import 'viewmodels/idea_viewmodel.dart'; // Importa o ViewModel que gerencia a lógica das ideias.
import 'views/idea_list_screen.dart'; // Importa a tela que exibe a lista de ideias.
import 'package:firebase_core/firebase_core.dart'; // Importa o pacote Firebase Core para inicializar o Firebase.

void main() async {
  // Garante que os bindings do Flutter estejam inicializados antes de executar qualquer operação de inicialização.
  WidgetsFlutterBinding.ensureInitialized();
  
  // Inicializa o Firebase, necessário para usar os serviços do Firebase no aplicativo.
  await Firebase.initializeApp();

  runApp(
    ChangeNotifierProvider(
      // Cria um provedor que notifica os ouvintes sobre mudanças no estado do IdeaViewModel.
      create: (context) => IdeaViewModel(),
      child: const MyApp(), // Cria a instância do MyApp como o widget raiz do aplicativo.
    ),
  );
}

// Define o widget principal do aplicativo.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key); // Construtor para MyApp, permite passar uma chave única.

  @override
  Widget build(BuildContext context) {
    // Constrói a interface do aplicativo usando MaterialApp.
    return MaterialApp(
      title: 'Organizador de Ideias Criativas', // Define o título do aplicativo.
      home: IdeaListScreen(), // Define a tela inicial do aplicativo como IdeaListScreen.
    );
  }
}
