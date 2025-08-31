import 'package:equatable/equatable.dart';

class FinishDebateDto extends Equatable {
    FinishDebateDto({
        required this.summary,
        required this.ranks,
    });

    final String summary;
    final Map<String, int> ranks;

    factory FinishDebateDto.fromJson(Map<String, dynamic> json){ 
        return FinishDebateDto(
            summary: json["summary"] ?? "",
            ranks: Map.from(json["ranks"]).map((k, v) => MapEntry<String, int>(k, v)),
        );
    }

    Map<String, dynamic> toJson() => {
        "summary": summary,
        "ranks": Map.from(ranks).map((k, v) => MapEntry<String, dynamic>(k, v)),
    };

    @override
    List<Object?> get props => [
    summary, ranks, ];
}
