import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? userId;
  String? emailAddress;

  int? createdAt;

  UserModel({
    this.userId,
    this.emailAddress,
    this.createdAt,
  });

  static UserModel parseSnapshot(DocumentSnapshot snapshot) {
    if (snapshot.exists) {
      return UserModel(
        userId: snapshot["userId"] ?? "",
        emailAddress: snapshot["emailAddress"] ?? "",
        createdAt: snapshot["createdAt"] ?? 0,
      );
    }
    return UserModel();
  }

  Map<String, dynamic> toJson() => {
        "userId": userId,
        "createdAt": createdAt,
        "emailAddress": emailAddress,
      };
}
