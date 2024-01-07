import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:tp2_appli_meteo/styles/styles.dart';
import 'package:tp2_appli_meteo/styles/colors.dart';
import 'package:tp2_appli_meteo/styles/texts.dart';
import 'package:tp2_appli_meteo/styles/photo.dart';
import 'package:tp2_appli_meteo/question_state.dart';
import 'package:tp2_appli_meteo/screens/quizz_provider.dart';
import 'package:tp2_appli_meteo/screens/quizz_cubit.dart';
import 'package:tp2_appli_meteo/screens/resultat_quiz.dart';
import 'package:tp2_appli_meteo/screens/weather.dart';

void main() async {
  // Initialisez les données de localisation pour la locale 'fr_FR'
  await initializeDateFormatting('fr_FR', null);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // Déclarez la liste de questions ici
    final List<QuestionState> questions = [
      QuestionState(
          questionText: "La tour Eiffel est à Paris.",
          isCorrect: true,
          decoPhoto: decoPhotoEiffel),
      QuestionState(
          questionText: "La tour de Pise est en allemagne.",
          isCorrect: false,
          decoPhoto: decoPhotoPise),
      QuestionState(
          questionText: "BigBen est à Cambridge en Angleterre.",
          isCorrect: false,
          decoPhoto: decoPhotoBigBen),
      QuestionState(
          questionText: "La Prime Tower est à Zurich au Pays-Bas.",
          isCorrect: false,
          decoPhoto: decoPhotoPrimeTower),
      QuestionState(
          questionText: "L'Atomium est à Francfort en Belgique.",
          isCorrect: false,
          decoPhoto: decoPhotoAtomium),
      QuestionState(
          questionText: "La tour Fernsehturm est à en Allemagne.",
          isCorrect: true,
          decoPhoto: decoPhotoFern),
      QuestionState(
          questionText: "La DC Tower est en Autriche.",
          isCorrect: true,
          decoPhoto: decoPhotoDcTower),
    ];

    return MaterialApp(
      home: MyHomePage(),
      theme: themePersonalise, // Choisir un theme
      initialRoute: '/',
      routes: {
        '/quizz_provider': (context) => ChangeNotifierProvider(
              create: (context) => QuizProvider(questions),
              child: const QuizzPageProvider(),
            ),
        '/quizz_cubit': (context) => QuizzPageCubit(questions: questions),
        '/quizz_provider/resultat': (context) => const ResultatPage(),
        '/quizz_cubit/resultat': (context) => const ResultatPage(),
        '/weather': (context) => WeatherPage(),
      },
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: menuText,
          backgroundColor: fushia,
        ),
        body: Center(
          child: Column(
            // Utilisez une colonne pour afficher les boutons verticalement
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              titreMenu,
              espaceVFixe10,
              titreGroupe,
              espaceVFixe50,
              ElevatedButton(
                onPressed: () {
                  // Aller sur le quizz
                  Navigator.pushNamed(context, '/quizz_provider', arguments: {
                    'title': 'Quizz Provider',
                  });
                },
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      sizeButton, // Définir la taille minimale du bouton
                  backgroundColor: fushia,
                  padding: margePaddingAll20,
                ),
                child: quizzProviderTitre,
              ),
              espaceVFixe20,
              ElevatedButton(
                onPressed: () {
                  // Aller sur le quizz
                  Navigator.pushNamed(context, '/quizz_cubit', arguments: {
                    'title': 'Quizz Cubit',
                  });
                },
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      sizeButton, // Définir la taille minimale du bouton
                  backgroundColor: fushia,
                  padding: margePaddingAll20,
                ),
                child: quizzCubitTitre,
              ),
              espaceVFixe20,
              ElevatedButton(
                onPressed: () {
                  // Aller sur le quizz
                  Navigator.pushNamed(context, '/weather', arguments: {
                    'title': 'Météo',
                  });
                },
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      sizeButton, // Définir la taille minimale du bouton
                  backgroundColor: fushia,
                  padding: margePaddingAll20,
                ),
                child: weatherTitre,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
