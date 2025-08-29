class SendFcmTokenDto {
  final String token;
  SendFcmTokenDto({required this.token});
  Map<String, dynamic> toJson() => {'token': token};
}
