class Auth {
  
  String login = "";
  int id = -1;
  String profileImageURL = "";
  String name = "";
  String company = "";
  int followers = 0;
  int following = 0;

  Auth(
      {this.login,
      this.id,
      this.profileImageURL,
      this.name,
      this.company,
      this.followers,
      this.following});

  factory Auth.fromJson(Map<String, dynamic> json) {
    return Auth(
        login: json["login"],
        id: json["id"],
        profileImageURL: json["avatar_url"],
        name: json["name"],
        company: json["company"],
        followers: json["followers"],
        following: json["following"]);
  }

  Map<String, dynamic> toJson() {
    return {
      "login": login,
      "id": id,
      "avatar_url": profileImageURL,
      "name": name,
      "company": company,
      "followers": followers,
      "following": following
    };
  }
}