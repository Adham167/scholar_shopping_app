class QuestionAnswer {
  final String question;
  final String answer;

  QuestionAnswer({
    required this.question,
    required this.answer,
  });

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
    };
  }

  factory QuestionAnswer.fromMap(Map<String, dynamic> map) {
    return QuestionAnswer(
      question: map['question'],
      answer: map['answer'],
    );
  }
}