import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp2_appli_meteo/question_state.dart';
import 'package:tp2_appli_meteo/styles/colors.dart';
import 'package:tp2_appli_meteo/styles/styles.dart';
import 'package:tp2_appli_meteo/styles/texts.dart';

class QuizProvider extends ChangeNotifier {
  final List<QuestionState> _questions;
  int _indexQuestion = 0;
  int _score = 0;

  QuizProvider(this._questions);

  int get indexQuestion => _indexQuestion;
  int get score => _score;
  List<QuestionState> get questions => _questions;

  // Vérification de la réponse
  void checkAnswer(BuildContext context, bool userChoice) {
    if (_questions[_indexQuestion].isCorrect == userChoice) {
      _score++;
    }

    if (_indexQuestion < _questions.length - 1) {
      _indexQuestion++;
    } else {
      // Vous avez terminé le quiz
      Navigator.pushNamed(context, '/quizz_provider/resultat',
          arguments: {'score': score, 'nb_question': questions.length});
    }

    notifyListeners();
  }
}

// Page de quizz utilisant Provider pour gérer les states
class QuizzPageProvider extends StatelessWidget {
  const QuizzPageProvider({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Récupérez les paramètres passés
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    // Vérifiez si un titre est en paramètres
    String title = arguments?['title'] ?? 'Titre inconnu';

    return Scaffold(
      appBar: AppBar(
        title: Text(title), // Utilisez le titre récupéré
        backgroundColor: fushia,
      ),
      backgroundColor: fushiaGrey,
      body: QuizzPageStateProvider(),
    );
  }
}

// Page par état des questions
class QuizzPageStateProvider extends StatelessWidget {
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
    var quizProvider = Provider.of<QuizProvider>(context);

    return Center(
      child: Container(
        padding: margePaddingAll20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                border: Border.all(
                  color: fushia,
                  width: 0.5,
                ),
                borderRadius: const BorderRadius.all(Radius.circular(3.0)),
              ),
              padding: margePaddingAll20,
              child: Text(
                quizProvider.questions[quizProvider.indexQuestion].questionText,
                style: questionTextStyle,
              ),
            ),
            espaceVFixe20,
            _getPhoto(
                quizProvider.questions[quizProvider.indexQuestion].decoPhoto),
            espaceVFixe20,
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                ElevatedButton(
                  onPressed: () {
                    quizProvider.checkAnswer(context, true);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: fushia,
                  ),
                  child: vraiText,
                ),
                ElevatedButton(
                  onPressed: () {
                    quizProvider.checkAnswer(context, false);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: fushia,
                  ),
                  child: fauxText,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
