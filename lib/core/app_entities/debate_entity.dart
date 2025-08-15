import 'package:equatable/equatable.dart';

class DebateEntity extends Equatable {
  final int id;
  final String guard; // 'debater', 'judge', 'coach'

  DebateEntity({required this.id, required this.guard});

  @override
  List<Object?> get props => [id, guard];
}
