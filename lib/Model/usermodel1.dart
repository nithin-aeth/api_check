class User {
  final String gender;
  final String title;
  final String firstName;
  final String lastName;

  User({
    required this.gender,
    required this.title,
    required this.firstName,
    required this.lastName,

  });

  factory User.fromJson(Map<String, dynamic> json) {
    final name = json['name'];
    return User(
      gender: json['gender'],
      title: name['title'],
      firstName: name['first'],
      lastName: name['last'],

    );
  }
}
