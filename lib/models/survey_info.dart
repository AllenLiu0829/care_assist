class SurveyInfo {
  String? id;
  final String question;

  SurveyInfo({
    required this.question,
  });

  SurveyInfo._({
    required this.id,
    required this.question,
  });

  factory SurveyInfo.fromMap(Map<String, dynamic> map, String id) {
    return SurveyInfo._(
      id: id,
      question: map['question'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
    };
  }
}
