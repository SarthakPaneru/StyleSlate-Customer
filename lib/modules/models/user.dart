class User {
  int? id;
  final String? email;
  final String? phone;
  final String? firstName;
  final String? lastName;
  final String? userRole;
  final String? imageUrl;

  User({
    this.id,
    this.email,
    this.phone,
    this.firstName,
    this.lastName,
    this.userRole,
    this.imageUrl,
  });

  User.fromMap(Map map)
      : this(
            id: map['id'],
            email: map['email'],
            phone: map['phone'],
            firstName: map['firstName'],
            lastName: map['lastName'],
            userRole: map['userRole'],
            imageUrl: map['imageUrl']);

  Map<String, dynamic> asMap() => {
        'id': id,
        'email': email,
        'phone': phone,
        'firstName': firstName,
        'lastName': lastName,
        'userRole': userRole,
        'imageUrl': imageUrl,
      };
}
