class DebatesEndPoints {
  static const String getDebates = 'debates';
  static const String getMotions = 'motion/get';
  static String getFeedback(int debateId) => 'getFeedbacks/$debateId';
  static String addFeedback = 'addfeedback';
  static String rateJudge = 'rate_judge';
  static String sendRequestFromJudge(int id) =>
      'debates/$id/applications/apply-judge';
  static String sendRequestFromDebater(int id) =>
      'debates/$id/applications/apply-debater';
  static String getFeedbackByDebater = 'getFeedbacksByDebater';
}
