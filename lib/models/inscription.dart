class Inscription {
  final int id;
  final String nom;
  final String prenom;
  final String classe;
  final String matricule;
  final String email;

  Inscription({
    required this.id,
    required this.nom,
    required this.prenom,
    required this.classe,
    required this.matricule,
    required this.email,
  });

  factory Inscription.fromJson(Map<String, dynamic> json) {
    return Inscription(
      id: json['id'],
      nom: json['nom'],
      prenom: json['prenom'],
      classe: json['classe'],
      matricule: json['matricule'],
      email: json['email'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'nom': nom,
      'prenom': prenom,
      'classe': classe,
      'matricule': matricule,
      'email': email,
    };
  }
}
