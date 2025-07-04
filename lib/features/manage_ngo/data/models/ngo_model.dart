import '../../domain/entities/ngo_entity.dart';

class NgoModel extends NgoEntity {
  NgoModel({required super.uId, required super.name, required super.email, required super.phone, required super.ngoId, required super.address, super.blocked});

  factory NgoModel.fromJson(Map<String, dynamic> json) {
    return NgoModel(
      uId: json['uId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String,
      ngoId: json['ngoId'] as String,
      address: json['address'] as String,
      blocked: json['blocked'] == true,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'phone': phone,
      'ngoId': ngoId,
      'address': address,
      'blocked': blocked,
    };
  }
} 