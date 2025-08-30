class NewProfileModel {
  NewProfileModel({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
  });

  final bool success;
  final String message;
  final List<ProfileData> data;
  final dynamic errors;

  NewProfileModel copyWith({
    bool? success,
    String? message,
    List<ProfileData>? data,
    dynamic? errors,
  }) {
    return NewProfileModel(
      success: success ?? this.success,
      message: message ?? this.message,
      data: data ?? this.data,
      errors: errors ?? this.errors,
    );
  }

  factory NewProfileModel.fromJson(Map<String, dynamic> json) {
    return NewProfileModel(
      success: json["success"] ?? false,
      message: json["message"] ?? "",
      data:
          json["data"] == null
              ? []
              : List<ProfileData>.from(
                json["data"]!.map((x) => ProfileData.fromJson(x)),
              ),
      errors: json["errors"],
    );
  }
}

class ProfileData {
  ProfileData({
    required this.profile,
    required this.debates,
    required this.guard,
  });

  final NewProfile? profile;
  final String debates;
  final String guard;

  ProfileData copyWith({NewProfile? profile, String? debates, String? guard}) {
    return ProfileData(
      profile: profile ?? this.profile,
      debates: debates ?? this.debates,
      guard: guard ?? this.guard,
    );
  }

  factory ProfileData.fromJson(Map<String, dynamic> json) {
    return ProfileData(
      profile:
          json["profile"] == null ? null : NewProfile.fromJson(json["profile"]),
      debates: json["debates"] ?? "",
      guard: json["guard"] ?? "",
    );
  }

  Map<String, dynamic> toJson() {
    return {"profile": profile?.toJson(), "debates": debates, "guard": guard};
  }
}

class NewProfile {
  NewProfile({
    required this.id,
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

  final int id;
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

  NewProfile copyWith({
    int? id,
    int? userId,
    String? firstName,
    String? lastName,
    String? email,
    String? mobileNumber,
    String? governorate,
    dynamic? profilePictureUrl,
    DateTime? birthDate,
    String? educationDegree,
    String? faculty,
    String? university,
    String? account,
  }) {
    return NewProfile(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      email: email ?? this.email,
      mobileNumber: mobileNumber ?? this.mobileNumber,
      governorate: governorate ?? this.governorate,
      profilePictureUrl: profilePictureUrl ?? this.profilePictureUrl,
      birthDate: birthDate ?? this.birthDate,
      educationDegree: educationDegree ?? this.educationDegree,
      faculty: faculty ?? this.faculty,
      university: university ?? this.university,
      account: account ?? this.account,
    );
  }

  factory NewProfile.fromJson(Map<String, dynamic> json) {
    return NewProfile(
      id: json["id"] ?? 0,
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

  Map<String, dynamic> toJson() {
    return {
      "id": id,
      "user_id": userId,
      "first_name": firstName,
      "last_name": lastName,
      "email": email,
      "mobile_number": mobileNumber,
      "governorate": governorate,
      "profile_picture_url": profilePictureUrl,
      "birth_date": birthDate?.toIso8601String(),
      "education_degree": educationDegree,
      "faculty": faculty,
      "university": university,
      "account": account,
    };
  }
}
