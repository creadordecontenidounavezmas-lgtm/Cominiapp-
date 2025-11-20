import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hydrated_riverpod/hydrated_riverpod.dart';
import 'package:path_provider/path_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await Firebase.initializeApp();

  final storage = await HydratedStorage.build(
    storageDirectory: await getApplicationDocumentsDirectory(),
  );
  HydratedRiverpod.initialize(storage: storage);

  runApp(const ProviderScope(child: CommuniApp()));
}

class CommuniApp extends ConsumerWidget {
  const CommuniApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'CommuniApp',
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF121212),
        primaryColor: const Color(0xFF00D9C0),
      ),
      home: const Scaffold(
        body: Center(
          child: Text(
            '¡CommuniApp viva!\nCAMI con Grok real',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 28, color: Color(0xFF00D9C0)),
          ),
        ),
      ),
    );
  }
}
