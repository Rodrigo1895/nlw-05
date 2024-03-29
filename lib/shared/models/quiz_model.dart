import 'dart:convert';

import 'package:dev_quiz/shared/models/question_model.dart';

enum Level {
  FACIL,
  MEDIO,
  DIFICIL,
  PERITO,
}

extension LevelStringExt on String {
  Level get levelParse => {
        "facil": Level.FACIL,
        "medio": Level.MEDIO,
        "dificil": Level.DIFICIL,
        "perito": Level.PERITO,
      }[this]!;
}

extension LevelExt on Level {
  String get parse => {
        Level.FACIL: "facil",
        Level.MEDIO: "medio",
        Level.DIFICIL: "dificil",
        Level.PERITO: "perito",
      }[this]!;
}

class QuizModel {
  final String title;
  final List<QuestionModel> questions;
  final int questionAnswered;
  final String image;
  final Level level;

  QuizModel({
    required this.title,
    required this.questions,
    this.questionAnswered = 0,
    required this.image,
    required this.level,
  });

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'questions': questions.map((x) => x.toMap()).toList(),
      'questionAnswered': questionAnswered,
      'image': image,
      'level': level.parse,
    };
  }

  factory QuizModel.fromMap(Map<String, dynamic> map) {
    return QuizModel(
      title: map['title'],
      questions: List<QuestionModel>.from(map['questions'].map((x) => QuestionModel.fromMap(x))),
      questionAnswered: map['questionAnswered'],
      image: map['image'],
      level: map['level'].toString().levelParse,
    );
  }

  String toJson() => json.encode(toMap());

  factory QuizModel.fromJson(String source) => QuizModel.fromMap(json.decode(source));
}
