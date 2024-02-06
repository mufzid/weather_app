class User {
  final int? id;
  final String firstName;
  final String lastName;
  final String email;

  User(
      {this.id,
      required this.firstName,
      required this.lastName,
      required this.email});

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'first_name': firstName,
      'last_name': lastName,
      'email': email,
    };
  }
}
