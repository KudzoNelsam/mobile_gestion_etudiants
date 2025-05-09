import 'package:flutter/material.dart';
import 'package:gestion_etudiants/models/inscription.dart';
import 'package:gestion_etudiants/services/inscription_service.dart';
import 'package:gestion_etudiants/views/widget/inscription_widget.dart';

class Layout extends StatefulWidget {
  const Layout({super.key, required this.apiService});
  final InscriptionService apiService;

  @override
  State<Layout> createState() => _LayoutState();
}

class _LayoutState extends State<Layout> {
  final _formKey = GlobalKey<FormState>();
  final _numeroController = TextEditingController();

  late Future<List<Inscription>> _inscriptionFuture;

  // Recherche des inscriptions par classe
  void _searchInscriptions(String query) {
    setState(() {
      if (query.isNotEmpty) {
        _inscriptionFuture = widget.apiService.searchInscriptionsByClasse(
          query,
        );
      } else {
        _inscriptionFuture = widget.apiService.findAllInscriptions();
      }
    });
  }

  @override
  void initState() {
    super.initState();
    _inscriptionFuture = widget.apiService.findAllInscriptions();

    // Ajout d'un écouteur sur le controller pour effectuer la recherche en temps réel
    _numeroController.addListener(() {
      final query = _numeroController.text;
      print("Recherche en cours : $query");
      _searchInscriptions(query);
    });
  }

  @override
  void dispose() {
    _numeroController
        .dispose(); // Libération des ressources lors de la destruction
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Gestion des étudiants')),
      body: Column(
        children: [
          Form(
            key: _formKey,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextFormField(
                controller: _numeroController,
                decoration: const InputDecoration(
                  labelText: 'Classe de l\'étudiant',
                  border: OutlineInputBorder(),
                ),
              ),
            ),
          ),
          FutureBuilder<List<Inscription>>(
            future: _inscriptionFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Erreur lors de la récupération des données !',
                    style: TextStyle(
                      color: Colors.red,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
                return const Center(child: Text('Aucune inscription trouvée'));
              } else {
                final inscriptions = snapshot.data!;
                return ListView.builder(
                  itemCount: inscriptions.length,
                  shrinkWrap: true, // Force la liste à s'adapter à son contenu
                  physics:
                      NeverScrollableScrollPhysics(), // Désactive le défilement de cette liste
                  itemBuilder: (context, index) {
                    final inscription = inscriptions[index];
                    return InscriptionWidget(inscription: inscription);
                  },
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
