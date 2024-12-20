class User {
  final String id;
  final String name;
 final String lastname;
  final String email;
  final String mobile;
  final String password;

  User({
    required this.id,
    required this.name,
  required this.lastname,
    required this.email,
    required this.mobile,
    required this.password,
  });

  // Ajouter une méthode pour convertir le modèle en JSON si nécessaire
  Map<String, dynamic> toJson() {
    return {
      'id':id,
      'lastname':lastname,
      'name': name,
      'email': email,
      'mobile': mobile,
      'password': password,
    };
  }
}
