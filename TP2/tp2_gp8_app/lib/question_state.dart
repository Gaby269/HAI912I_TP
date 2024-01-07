import 'package:flutter/material.dart';

// Classe question
class QuestionState {
  String questionText;
  bool isCorrect;
  BoxDecoration decoPhoto;

  QuestionState(
      {required this.questionText,
      required this.isCorrect,
      required this.decoPhoto});
}
