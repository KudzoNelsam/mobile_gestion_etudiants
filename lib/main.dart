import 'package:flutter/material.dart';
import 'package:gestion_etudiants/services/inscription_service.dart'
    show InscriptionService;
import 'package:gestion_etudiants/views/layout.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  State<MainApp> createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        // Define your routes here
        '/':
            (context) => Layout(
              apiService: InscriptionService(
                baseUrl: "http://192.168.1.17:3000",
              ),
            ),
      },
    );
  }
}
