class NewPhotographer {
  String email;
  String password;
  String place;
  String typePhotographer;
  int adherNumber;
  int phoneNumber;
  String id;
  String profileUrl;

  NewPhotographer(
      {required this.adherNumber,
      required this.profileUrl,
      required this.email,
      required this.id,
      required this.password,
      required this.phoneNumber,
      required this.place,
      required this.typePhotographer});

  Map<String, dynamic> tojson() => {
        "email": email,
        "password": password,
        "place": place,
        "typePhotographer": typePhotographer,
        "adherNumber": adherNumber,
        "phoneNumber": phoneNumber,
        "id": id,
        "profileUrl": profileUrl
      };

  factory NewPhotographer.fromJson(Map<String, dynamic> json) {
    return NewPhotographer(
        adherNumber: json["adherNumber"],
        profileUrl: json["profileUrl"],
        email: json["email"],
        id: json["id"],
        password: json["password"],
        phoneNumber: json["phoneNumber"],
        place: json["place"],
        typePhotographer: json["typePhotographer"]);
  }
}
