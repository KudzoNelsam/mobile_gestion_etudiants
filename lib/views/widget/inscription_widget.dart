import 'package:flutter/material.dart';
import 'package:gestion_etudiants/models/inscription.dart';

class InscriptionWidget extends StatefulWidget {
  const InscriptionWidget({super.key, required this.inscription});
  final Inscription inscription;

  @override
  State<InscriptionWidget> createState() => _InscriptionWidgetState();
}

class _InscriptionWidgetState extends State<InscriptionWidget> {
  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        title: Text(
          widget.inscription.nom,
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Prénom: ${widget.inscription.prenom}'),
            Text('Classe: ${widget.inscription.classe}'),
            Text('Matricule: ${widget.inscription.matricule}'),
            Text('Email: ${widget.inscription.email}'),
          ],
        ),
        trailing: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            // Handle delete action
          },
        ),
      ),
    );
  }
}
