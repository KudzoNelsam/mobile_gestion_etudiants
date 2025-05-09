import 'dart:convert';
import 'package:http/http.dart' as http;

typedef FromJson<T> = T Function(Map<String, dynamic> json);
typedef ToJson<T> = Map<String, dynamic> Function(T item);

class CrudService<T> {
  final String baseUrl;
  final String endpoint;
  final http.Client _client;
  final FromJson<T> fromJson;
  final ToJson<T> toJson;

  CrudService({
    required this.endpoint,
    required this.fromJson,
    required this.toJson,
    this.baseUrl = "http://10.0.2.2:3000",
    http.Client? client,
  }) : _client = client ?? http.Client();

  Future<List<T>> findAll() async {
    final response = await _client.get(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((item) => fromJson(item)).toList();
    } else {
      throw Exception(
        'Erreur ${response.statusCode} : ${response.reasonPhrase}',
      );
    }
  }

  Future<T> findById(int id) async {
    final response = await _client.get(Uri.parse('$baseUrl/$endpoint/$id'));

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return fromJson(data);
    } else {
      throw Exception(
        'Erreur ${response.statusCode} : ${response.reasonPhrase}',
      );
    }
  }

  Future<T> create(T item) async {
    final response = await _client.post(
      Uri.parse('$baseUrl/$endpoint'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(toJson(item)),
    );

    if (response.statusCode == 201) {
      final Map<String, dynamic> data = json.decode(response.body);
      return fromJson(data);
    } else {
      throw Exception(
        'Erreur ${response.statusCode} : ${response.reasonPhrase}',
      );
    }
  }

  Future<T> update(int id, T item) async {
    final response = await _client.put(
      Uri.parse('$baseUrl/$endpoint/$id'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(toJson(item)),
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = json.decode(response.body);
      return fromJson(data);
    } else {
      throw Exception(
        'Erreur ${response.statusCode} : ${response.reasonPhrase}',
      );
    }
  }

  Future<void> delete(int id) async {
    final response = await _client.delete(Uri.parse('$baseUrl/$endpoint/$id'));

    if (response.statusCode != 204) {
      throw Exception(
        'Erreur ${response.statusCode} : ${response.reasonPhrase}',
      );
    }
  }
}
