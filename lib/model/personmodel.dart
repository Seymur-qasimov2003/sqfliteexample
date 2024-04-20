class PersonModel {
  int? id;
  String name;

  PersonModel({ this.id, required this.name});

  ///fromjson
  factory PersonModel.fromJson(Map<String, dynamic> json) {
    return PersonModel(id: json['id'], name: json['name']);
  }

  ///tojson
  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name};
  }
}
