class NotificationModel {
  final String id;
  final DateTime createdAt;
  final String title;
  final String body;
  NotificationModel({
    required this.title,
    required this.body,
    required this.createdAt,
    required this.id,
  });
  factory NotificationModel.fromJson(Map<String, dynamic> json) =>
      NotificationModel(
        id: json['id'],
        createdAt: DateTime.parse(json['createdAt']),
        title: json['title'],
        body: json['body'],
      );
}
