import 'package:spotify/domain/entities/auth/user.dart';

class UserModel {
  String? fullName;
  String? email;
  String? imageUrl;

  UserModel({
    this.fullName,
    this.email,
    this.imageUrl,
  });

  Map<String, dynamic> toJson() {
    return {
      'fullName': fullName,
      'email': email,
      'imageUrl': imageUrl,
    };
  }

  factory UserModel.fromJson(Map<String, dynamic> data) {
    return UserModel(
      fullName: data['fullName'] ?? 'Unknown User',
      email: data['email'] ?? 'No Email',
      imageUrl: data['imageUrl'] ?? '',
    );
  }
}

extension UserModelX on UserModel {
  UserEntity toEntity() {
    return UserEntity(
      fullName: fullName ?? 'Unknown User',
      email: email ?? 'No Email',
      imageUrl: imageUrl ?? '',
    );
  }
}
