class Owner {
  final String username;
  final String profileImageURL;

  Owner({this.username, this.profileImageURL});

  factory Owner.fromJson(Map<String, dynamic> json) {
    return Owner(username: json["login"], profileImageURL: json["avatar_url"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "login": username,
      "avatar_url": profileImageURL,
    };
  }
}
