class Question {
  int type; // libre (0) o seleccion (1)
  String text;
  String answerType;
  List<String> options;

  Question({
    required this.type,
    required this.text,
    required this.answerType,
    required this.options,
  });

  @override
  String toString() {
    return 'Question(type: $type, text: $text, answerType: $answerType, options: $options)';
  }
}
