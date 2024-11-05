// Arquivo gerado pela CLI do FlutterFire.
// Ignora avisos de lint no arquivo.
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions; // Importa a classe FirebaseOptions para configurar as opções do Firebase.
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform; // Importa constantes relacionadas à plataforma.

/// Opções padrão [FirebaseOptions] para uso com seus aplicativos Firebase.
/// 
/// Exemplo:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
/// Este comentário fornece um exemplo de como usar as opções de configuração do Firebase.
class DefaultFirebaseOptions {
  /// Retorna as opções de configuração do Firebase com base na plataforma atual.
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) { // Verifica se o aplicativo está sendo executado na web.
      throw UnsupportedError(
        'DefaultFirebaseOptions não foram configuradas para web - '
        'você pode reconfigurar isso executando novamente a CLI do FlutterFire.',
      );
    }
    // Verifica a plataforma atual e retorna as opções correspondentes.
    switch (defaultTargetPlatform) {
      case TargetPlatform.android: // Para dispositivos Android.
        return android;
      case TargetPlatform.iOS: // Para dispositivos iOS.
        return ios;
      case TargetPlatform.macOS:
        throw UnsupportedError(
          'DefaultFirebaseOptions não foram configuradas para macOS - '
          'você pode reconfigurar isso executando novamente a CLI do FlutterFire.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions não foram configuradas para Windows - '
          'você pode reconfigurar isso executando novamente a CLI do FlutterFire.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions não foram configuradas para Linux - '
          'você pode reconfigurar isso executando novamente a CLI do FlutterFire.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions não são suportadas para esta plataforma.',
        );
    }
  }

  // Opções de configuração do Firebase para Android.
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBDU8hYuUJuPOBvYeUVPC3EyNqUIro_4-U', // Chave da API do Firebase.
    appId: '1:625687244929:android:8f7368980a5677f8051d80', // ID do aplicativo Android.
    messagingSenderId: '625687244929', // ID do remetente de mensagens.
    projectId: 'organizadorideias', // ID do projeto Firebase.
    storageBucket: 'organizadorideias.firebasestorage.app', // Bucket de armazenamento do Firebase.
  );

  // Opções de configuração do Firebase para iOS.
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBhwblEDLpUjW0q8h5tp0bhMJGdNPQ8vGM', // Chave da API do Firebase.
    appId: '1:625687244929:ios:0e12eff550b2b53b051d80', // ID do aplicativo iOS.
    messagingSenderId: '625687244929', // ID do remetente de mensagens.
    projectId: 'organizadorideias', // ID do projeto Firebase.
    storageBucket: 'organizadorideias.firebasestorage.app', // Bucket de armazenamento do Firebase.
    iosBundleId: 'com.example.organizadorIdeias', // ID do bundle para iOS.
  );
}
