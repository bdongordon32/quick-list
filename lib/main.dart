import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:quick_list/app_theme.dart';
import 'package:quick_list/providers/quick_lists_provider.dart';
import 'package:quick_list/screens/dashboard.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  try {
    // final userCredential = await FirebaseAuth.instance.signInAnonymously();
    await FirebaseAuth.instance.signInAnonymously();
  } on FirebaseAuthException catch (e) {
    switch (e.code) {
      case "operation-not-allowed":
        // ignore: avoid_print
        print("Anonymous auth hasn't been enabled for this project.");
        break;
      default:
        // ignore: avoid_print
        print("Unknown error.");
    }
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => QuickListsProvider()),
      ],
      child: const MainApp(),
    )
  );
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: QuickListTheme().appTheme,
      home: Dashboard()
    );
  }
}
