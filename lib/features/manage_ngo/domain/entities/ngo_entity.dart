class NgoEntity {
  final String uId;
  final String name;
  final String email;
  final String phone;
  final String ngoId;
  final String address;
  final bool blocked;

  NgoEntity({
    required this.uId,
    required this.name,
    required this.email,
    required this.phone,
    required this.ngoId,
    required this.address,
    this.blocked = false,
  });
} 