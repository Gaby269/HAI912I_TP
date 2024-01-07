import 'package:flutter/material.dart';

// Couleurs
const fushia = Color.fromARGB(255, 96, 3, 54);
const fushiaClaire = Color.fromARGB(255, 255, 202, 231);
// Marges / Padding
const margePaddingAll50 = EdgeInsets.all(50);
const margePaddingAll75 = EdgeInsets.all(75);
const margePaddingAll20 = EdgeInsets.all(20);
// Thèmes
const textTitre = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
const textBody = TextStyle(fontSize: 16);
// Espace
const espaceFixe20 = SizedBox(height: 20);
const espaceFixe50 = SizedBox(height: 50);

//////////
// CARD //
//////////
// Box ombre
const boxShadow = BoxShadow(
  color: fushiaClaire,
  blurRadius: 5,
);

/* ****  INFO PERSO ***** */
// Textes Card
const resultatText = Text("Resutat");
const scoreText = Text('Voici votre score : ',
    style: TextStyle(
        fontSize: 24,
        color: fushia,
        fontWeight: FontWeight.bold) // Graisse du texte),
    );
const scoreStyle = TextStyle(
  fontSize: 24, // Taille de police du score
  fontWeight: FontWeight.bold, // Graisse du texte
);
const resultatStyle = TextStyle(
  fontSize: 24, // Taille de police du score
  fontWeight: FontWeight.bold, // Graisse du texte
  color: fushiaClaire,
);

const edgeInsets20 = EdgeInsets.all(20.0);

//////////////
// RESULTAT //
//////////////

const textBravo = Text("Bravo !", style: resultatStyle);
const textDommage = Text("Dommage, Essayez encore !", style: resultatStyle);
const textBienJoue = Text("Bien joué !", style: resultatStyle);
const textEncore = Text("Encore un peu !", style: resultatStyle);
const textVide = Text("");
const retourHome = Text("Menu");

// Page resultat
class ResultatPage extends StatelessWidget {
  const ResultatPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Récupérez les paramètres passés
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    // Vérifiez si des paramètres existe
    int score = arguments?['score'] ?? -1;
    int nb_question = arguments?['nb_question'] ?? 0;

    // Calcul de commentaire
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
                      espaceFixe20,
                      commentaire,
                      espaceFixe20,
                      Text(
                        '${score.toString()} / ${nb_question.toString()}',
                        style: scoreStyle,
                      ),
                    ],
                  ),
                ),
                espaceFixe20, // Ajouter un espace entre le texte et les boutons
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
