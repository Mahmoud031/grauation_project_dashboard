import '../../domain/entities/user_entity.dart';

class UserModel extends UserEntity{
  UserModel({required super.uId, required super.name, required super.email, required super.age, required super.phone, required super.nationalId, required super.address, required super.type, super.blocked, super.documentId});
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uId: json['uId'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      age: json['age'] as int,
      phone: json['phone'] as String,
      nationalId: json['nationalId'] as String,
      address: json['address'] as String,
      type: json['type'] as String,
      blocked: json['blocked'] == true,
      documentId: json['documentId'] as String?,
    );
  }
  Map<String, dynamic> toJson() {
    return {
      'uId': uId,
      'name': name,
      'email': email,
      'age': age,
      'phone': phone,
      'nationalId': nationalId,
      'address': address,
      'type': type,
      'blocked': blocked,
      // Do not include documentId in toJson, as it's not a Firestore field
    };
  }
  
}