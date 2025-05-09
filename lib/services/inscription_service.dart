import 'dart:convert';
import 'package:gestion_etudiants/models/inscription.dart' show Inscription;
import 'package:http/http.dart' as http;

class InscriptionService {
  final String baseUrl;
  final http.Client _client;

  InscriptionService({
    this.baseUrl = "http://10.0.2.2:3000",
    http.Client? client,
  }) : _client = client ?? http.Client();

  Future<List<Inscription>> findAllInscriptions() async {
    final response = await _client.get(
      Uri.parse("$baseUrl/inscriptions"),
      headers: {'Content-Type': 'application/json'},
    );
    if (response.statusCode == 200) {
      print("contenu des inscriptions : ${response.body}");
      final List<dynamic> data = json.decode(response.body);

      return data.map((item) => Inscription.fromJson(item)).toList();
    } else {
      throw Exception("Erreur de requête : ${response.statusCode}");
    }
  }

  // ✅ Récupérer une inscription par ID
  Future<Inscription> findInscriptionById(int id) async {
    final response = await _client.get(Uri.parse("$baseUrl/inscriptions/$id"));

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Inscription.fromJson(data);
    } else {
      throw Exception("Erreur de requête : ${response.statusCode}");
    }
  }

  // ✅ Ajouter une inscription
  Future<Inscription> addInscription(Inscription inscription) async {
    final response = await _client.post(
      Uri.parse("$baseUrl/inscriptions"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(inscription.toJson()),
    );

    if (response.statusCode == 201) {
      final data = json.decode(response.body);
      return Inscription.fromJson(data);
    } else {
      throw Exception("Erreur de requête : ${response.statusCode}");
    }
  }

  // ✅ Mettre à jour une inscription
  Future<Inscription> updateInscription(Inscription inscription) async {
    final response = await _client.put(
      Uri.parse("$baseUrl/inscriptions/${inscription.id}"),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(inscription.toJson()),
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      return Inscription.fromJson(data);
    } else {
      throw Exception("Erreur de requête : ${response.statusCode}");
    }
  }

  // ✅ Supprimer une inscription
  Future<void> deleteInscription(int id) async {
    final response = await _client.delete(
      Uri.parse("$baseUrl/inscriptions/$id"),
    );

    if (response.statusCode != 204) {
      throw Exception("Erreur de requête : ${response.statusCode}");
    }
  }

  // ✅ Rechercher des inscriptions par classe (query)
  Future<List<Inscription>> searchInscriptionsByClasse(String classe) async {
    final response = await _client.get(
      Uri.parse("$baseUrl/inscriptions?classe=$classe"),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body)['inscriptions'];
      return data.map((item) => Inscription.fromJson(item)).toList();
    } else {
      throw Exception("Erreur de requête : ${response.statusCode}");
    }
  }
}
