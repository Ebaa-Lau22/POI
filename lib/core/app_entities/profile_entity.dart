import 'package:equatable/equatable.dart';

class ProfileEntity extends Equatable {
    ProfileEntity({
        required this.success,
        required this.message,
        required this.data,
        required this.errors,
    });

    final bool? success;
    final String? message;
    final List<Datum> data;
    final dynamic errors;

    @override
    List<Object?> get props => [
    success, message, data, errors, ];
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

    @override
    List<Object?> get props => [
    profile, coachName, coachId, team, debates, guard, ];
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

    @override
    List<Object?> get props => [
    id, firstName, lastName, email, mobileNumber, governorate, profilePictureUrl, birthDate, educationDegree, faculty, university, ];
}