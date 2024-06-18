//import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:wow_stats_ds/firebase_options.dart';
import 'package:wow_stats_ds/models/hardcoded_abilities.dart';
import 'package:wow_stats_ds/pages/auth_page_login.dart';
import 'package:firebase_core/firebase_core.dart';

final AbilityManager abilityManager = AbilityManager();

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform, );
// await FirebaseAuth.instance.useAuthEmulator('localhost', 9099);
  abilityManager.addAbilities();
  
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'wow_stats_ds',
      debugShowCheckedModeBanner: false,
      home: AuthPageLogin(),
      initialRoute: '/login',
      routes: {
        '/login': (context) => AuthPageLogin(),
      },
    );
  }
}
