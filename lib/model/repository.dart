import 'package:gitfeed/model/owner.dart';

class Repository {
  final int id;
  final String name;
  final String fullName;
  final String description;
  final Owner owner;

  Repository({this.id, this.name, this.fullName, this.description, this.owner});

  factory Repository.fromJson(Map<String, dynamic> json) {
    return Repository(
      id: json["id"],
      name: json["name"],
      fullName: json["full_name"],
      description: json["description"],
      owner: Owner.fromJson(json["owner"]),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "name": name,
      "full_name": fullName,
      "description": description,
      "owner": owner.toJson(),
    };
  }
}
