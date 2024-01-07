import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tp2_appli_meteo/question_state.dart';
import 'package:tp2_appli_meteo/styles/styles.dart';
import 'package:tp2_appli_meteo/styles/texts.dart';
import 'package:tp2_appli_meteo/styles/colors.dart';
import 'package:tp2_appli_meteo/styles/photo.dart';

// Événements
abstract class QuizEvent {}

class NextQuestionEvent extends QuizEvent {}

// Etat de la question dans question_state.dart

// Cubit pour gérer l'état du quiz
class QuizCubit extends Cubit<QuestionState> {
  List<QuestionState> _questions;
  int _indexQuestion = 0;
  int _score = 0;

  // Si jamais les questions sont inexistante on dit Bienvenue
  QuizCubit(this._questions)
      : super(_questions.isNotEmpty
            ? _questions[0]
            : QuestionState(
                questionText: "Bienvenue au quiz!",
                isCorrect: true,
                decoPhoto: decoPhotoDcTower,
              ));

  // Méthode pour vérifier la réponse
  void checkAnswer(BuildContext context, bool userChoice) {
    if (state.isCorrect == userChoice) {
      _score++;
    }

    if (_indexQuestion < _questions.length - 1) {
      _indexQuestion++;
      emit(_questions[_indexQuestion]);
    } else {
      // quiz est terminé
      Navigator.pushNamed(context, '/quizz_cubit/resultat',
          arguments: {'score': _score, 'nb_question': _questions.length});
    }
  }
}

// Page de quizz utilisant Bloc/Cubit pour gérer les states
class QuizzPageCubit extends StatelessWidget {
  final List<QuestionState> questions;

  const QuizzPageCubit({Key? key, required this.questions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Récupérez les paramètres passés
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    // Vérifiez si il y a un titre
    String title = arguments?['title'] ?? 'Titre inconnu';

    return Scaffold(
      appBar: AppBar(
        title: Text(title), // Utilisez le titre récupéré
        backgroundColor: fushia,
      ),
      backgroundColor: fushiaGrey,
      body: QuizzPageStateCubit(questions: questions),
    );
  }
}

// Page par état des questions
class QuizzPageStateCubit extends StatelessWidget {
  final List<QuestionState> questions;

  const QuizzPageStateCubit({Key? key, required this.questions})
      : super(key: key);

  // Récuperer la photo associé
  Container _getPhoto(decoPhoto) {
    return Container(
      width: 200,
      height: 300,
      decoration: decoPhoto,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => QuizCubit(questions),
      child: Center(
        child: Container(
          padding: margePaddingAll20,
          child: BlocBuilder<QuizCubit, QuestionState>(
            builder: (context, state) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    child: Text(state.questionText, style: questionTextStyle),
                  ),
                  espaceVFixe20,
                  _getPhoto(state.decoPhoto),
                  espaceVFixe20,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          context.read<QuizCubit>().checkAnswer(context, true);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: fushia,
                        ),
                        child: vraiText,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.read<QuizCubit>().checkAnswer(context, false);
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: fushia,
                        ),
                        child: fauxText,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
