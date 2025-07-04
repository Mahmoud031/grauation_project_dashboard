class UserEntity {
  final String uId;
  final String name;
  final String email;
  final int age;
  final String phone;
  final String nationalId;
  final String address;
  final String type;
  final bool blocked;
  final String? documentId;

  UserEntity( {
    required this.uId,
    required this.name,
    required this.email,
    required this.age,
    required this.phone,
    required this.nationalId,
    required this.address,
    required this.type,
    this.blocked = false,
    this.documentId,
  });
  
}
