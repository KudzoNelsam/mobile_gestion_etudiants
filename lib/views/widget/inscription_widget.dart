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
        title: Text(widget.inscription.nom),
        subtitle: Text(widget.inscription.prenom),
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
