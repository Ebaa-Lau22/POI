class NewMotionModel {
  final int motionId;
  final String sentence;
  final List<dynamic> subClassification;
  const NewMotionModel({
    required this.motionId,
    required this.sentence,
    required this.subClassification,
  });

  factory NewMotionModel.fromJson(Map<String, dynamic> json) => NewMotionModel(
    motionId: json['motion_id'] ?? 1,
    sentence: json['sentence'] ?? '',
    subClassification: json['sub_classification'] ?? [],
  );
}
