import 'package:equatable/equatable.dart';

class ProfileModel extends Equatable {
  ProfileModel({
    required this.success,
    required this.message,
    required this.data,
    required this.errors,
  });

  final bool? success;
  final String? message;
  final List<Datum> data;
  final dynamic errors;

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      success: json["success"],
      message: json["message"],
      data:
          json["data"] == null
              ? []
              : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      errors: json["errors"],
    );
  }

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
    "data": data.map((x) => x?.toJson()).toList(),
    "errors": errors,
  };

  @override
  List<Object?> get props => [success, message, data, errors];
}

class Datum extends Equatable {
  Datum({
    required this.profile,
    required this.coachName,
    required this.coachId,
    required this.team,
    required this.debates,
    required this.guard,
  });

  final Profile? profile;
  final String? coachName;
  final int? coachId;
  final List<dynamic> team;
  final String? debates;
  final String? guard;

  factory Datum.fromJson(Map<String, dynamic> json) {
    return Datum(
      profile:
          json["profile"] == null ? null : Profile.fromJson(json["profile"]),
      coachName: json["coach_name"],
      coachId: json["coach_id"],
      team:
          json["team"] == null
              ? []
              : List<dynamic>.from(json["team"]!.map((x) => x)),
      debates: json["debates"],
      guard: json["guard"],
    );
  }

  Map<String, dynamic> toJson() => {
    "profile": profile?.toJson(),
    "coach_name": coachName,
    "coach_id": coachId,
    "team": team.map((x) => x).toList(),
    "debates": debates,
    "guard": guard,
  };

  @override
  List<Object?> get props => [
    profile,
    coachName,
    coachId,
    team,
    debates,
    guard,
  ];
}

class Profile extends Equatable {
  Profile({
    required this.id,
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
  });

  final int? id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? mobileNumber;
  final String? governorate;
  final dynamic profilePictureUrl;
  final DateTime? birthDate;
  final String? educationDegree;
  final String? faculty;
  final String? university;

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      id: json["id"],
      firstName: json["first_name"],
      lastName: json["last_name"],
      email: json["email"],
      mobileNumber: json["mobile_number"],
      governorate: json["governorate"],
      profilePictureUrl: json["profile_picture_url"],
      birthDate: DateTime.tryParse(json["birth_date"] ?? ""),
      educationDegree: json["education_degree"],
      faculty: json["faculty"],
      university: json["university"],
    );
  }

  Map<String, dynamic> toJson() => {
    "id": id,
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
  };

  @override
  List<Object?> get props => [
    id,
    firstName,
    lastName,
    email,
    mobileNumber,
    governorate,
    profilePictureUrl,
    birthDate,
    educationDegree,
    faculty,
    university,
  ];
}
