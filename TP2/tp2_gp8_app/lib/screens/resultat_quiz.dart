import 'package:flutter/material.dart';
import 'package:tp2_appli_meteo/styles/styles.dart';
import 'package:tp2_appli_meteo/styles/texts.dart';
import 'package:tp2_appli_meteo/styles/colors.dart';

//////////////
// RESULTAT //
//////////////

// Page resultat
class ResultatPage extends StatelessWidget {
  const ResultatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Récupérez les paramètres passés
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    // Vérifiez si titre est là
    int score = arguments?['score'] ?? -1;
    int nb_question = arguments?['nb_question'] ?? 0;

    // Calcul de commentaire sur le résultat
    Text commentaire = textVide;
    if (score == nb_question) {
      commentaire = textBravo;
    } else if (score == 0) {
      commentaire = textDommage;
    } else if (score / nb_question < 0.5) {
      commentaire = textEncore;
    } else {
      commentaire = textBienJoue;
    }

    return MaterialApp(
      home: Scaffold(
        // Ajout du titre de la page en haut
        appBar: AppBar(
          title: resultatText,
          centerTitle: false,
          backgroundColor: fushia,
        ),
        // Ajouter le body de la page qui sera un container
        body: Center(
          child: Container(
            padding: margePaddingAll20,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Container(
                  padding: edgeInsets20,
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: fushia,
                      width: 1.0,
                    ),
                    borderRadius: BorderRadius.circular(8.0),
                  ),
                  child: Column(
                    children: <Widget>[
                      scoreText,
                      espaceVFixe20,
                      commentaire,
                      espaceVFixe20,
                      Text(
                        '${score.toString()} / ${nb_question.toString()}',
                        style: scoreStyle,
                      ),
                    ],
                  ),
                ),
                espaceVFixe20, // Ajouter un espace entre le texte et les boutons
                Container(
                  padding: edgeInsets20,
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.pushNamed(context, '/');
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: fushia,
                    ),
                    child: retourHome,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
