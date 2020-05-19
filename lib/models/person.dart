class PersonInfo {
  final int id;
  final String name;
  final String username;
  final String email;

  const PersonInfo({this.id, this.name, this.username, this.email});

  factory PersonInfo.fromJson(Map<String, dynamic> json) {
    final personJson = json['person'];
    return PersonInfo(
      id: json['id'],
      name: json['name'],
      username: json['username'],
      email: json['email'],
    );
  }

}
