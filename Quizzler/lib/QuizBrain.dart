import 'package:Quizzler/question.dart';

class QuizBrain {
  List<Question> _questionBank = [
    Question(question: 'Neville Longbottom is in House Ravenclaw', answer: false),
    Question(question: 'Godric Gyrffindor\'s sword was a horcrux', answer: false),
    Question(question: 'Hagrid is half-giant and half-human', answer: true),
  ];

  String getQuestion(int questionNumber) {
    return _questionBank[questionNumber].questionText;
  }

  bool getAnswer(int questionNumber) {
    return _questionBank[questionNumber].questionAnswer;
  }

  bool hasNextQuestion(int currentQuestion) {
    return _questionBank.length - 1 > currentQuestion;
  }
}