class User {
  final String firstName;
  final String lastName;
  final String email;
  final String password;

  User({
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.password,
  });

  factory User.fromJson(json) {
    return User(
      firstName: json['nome'],
      lastName: json['sobrenome'],
      email: json['email'],
      password: json['senha'],
    );
  }

  Map toJson() {
    return {
      'nome': firstName,
      'sobrenome': lastName,
      'email': email,
      'senha': password,
    };
  }
}
