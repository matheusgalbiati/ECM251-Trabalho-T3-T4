class Game {
  final String userId;
  final String userEmail;
  final String userPassword;
  final String name;
  final String description;
  final int year;
  final String publisher;
  final String indicativeRating;
  final List platforms;
  final List genders;
  final String urlImage;

  Game({
    required this.userId,
    required this.name,
    required this.userEmail,
    required this.userPassword,
    required this.year,
    required this.publisher,
    required this.indicativeRating,
    required this.platforms,
    required this.genders,
    required this.description,
    required this.urlImage,
  });

  factory Game.fromJson(json) {
    return Game(
      userId: json['codigoDoUsuario'],
      userEmail: json['emailDoUsuario'],
      userPassword: json['senhaDoUsuario'],
      description: json['resumo'],
      name: json['nome'],
      year: json['anoDeLancamento'],
      publisher: json['publisher'],
      indicativeRating: json['clacssificacaoEtaria'],
      platforms: json['plataformas'],
      genders: json['generos'],
      urlImage: json['urlImagem'],
    );
  }

  Map toJson() {
    return {
      'codigoDoUsuario': userId,
      'emailDoUsuario': userEmail,
      'senhaDoUsuario': userPassword,
      'nome': name,
      'resumo': description,
      'anoDeLancamento': year,
      'publisher': publisher,
      'clacssificacaoEtaria': int.parse(indicativeRating),
      'plataformas': platforms,
      'generos': genders,
      'urlImagem': urlImage,
    };
  }
}
