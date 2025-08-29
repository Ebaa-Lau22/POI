class UserModel {
  UserModel({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
  });

  final bool success;
  final String message;
  final List<UserData> data;
  final dynamic errors;

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      data:
          json["data"] == null
              ? []
              : List<UserData>.from(
                json["data"]!.map((x) => UserData.fromJson(x)),
              ),
      errors: json["errors"],
    );
  }
}

class UserData {
  UserData({
    required this.userId,
    required this.firstName,
    required this.lastName,
    required this.email,
    required this.mobileNumber,
    required this.governorate,
    required this.profilePictureUrl,
    required this.birthDate,
    required this.educationDegree,
    required this.faculty,
    required this.university,
    required this.account,
  });

  final int userId;
  final String firstName;
  final String lastName;
  final String email;
  final String mobileNumber;
  final String governorate;
  final dynamic profilePictureUrl;
  final DateTime? birthDate;
  final String educationDegree;
  final String faculty;
  final String university;
  final String account;

  factory UserData.fromJson(Map<String, dynamic> json) {
    return UserData(
      userId: json["user_id"] ?? 0,
      firstName: json["first_name"] ?? "",
      lastName: json["last_name"] ?? "",
      email: json["email"] ?? "",
      mobileNumber: json["mobile_number"] ?? "",
      governorate: json["governorate"] ?? "",
      profilePictureUrl: json["profile_picture_url"],
      birthDate: DateTime.tryParse(json["birth_date"] ?? ""),
      educationDegree: json["education_degree"] ?? "",
      faculty: json["faculty"] ?? "",
      university: json["university"] ?? "",
      account: json["account"] ?? "",
    );
  }
}
