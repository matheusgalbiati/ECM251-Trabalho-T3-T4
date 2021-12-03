class Review {
  final String gameId;
  final String userId;
  final String userEmail;
  final String userPassword;
  final String text;
  final double rating;

  Review({
    required this.gameId,
    required this.userId,
    required this.userEmail,
    required this.userPassword,
    required this.text,
    required this.rating,
  });

  factory Review.fromJson(json) {
    return Review(
      gameId: json['codigoDoJogo'],
      userId: json['codigoDoUsuario'],
      userEmail: json['emailDoUsuario'],
      userPassword: json['senhaDoUsuario'],
      text: json['texto'],
      rating: json['estrelas'],
    );
  }

  Map toJson() {
    return {
      'codigoDoJogo': gameId,
      'codigoDoUsuario': userId,
      'emailDoUsuario': userEmail,
      'senhaDoUsuario': userPassword,
      'texto': text,
      'estrelas': rating,
    };
  }
}
