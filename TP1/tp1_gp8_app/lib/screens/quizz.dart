import 'package:flutter/material.dart';

// Couleurs
const fushia = Color.fromARGB(255, 96, 3, 54);
const fushiaGrey = Color.fromARGB(255, 161, 127, 146);
const fushiaClaire = Color.fromARGB(255, 255, 202, 231);
// Marges / Padding
const margePaddingAll50 = EdgeInsets.all(50);
const margePaddingAll10 = EdgeInsets.all(10);
const margePaddingAll75 = EdgeInsets.all(75);
const margePaddingAll20 = EdgeInsets.all(20);
// Espace
const espaceFixe20 = SizedBox(height: 20);
// Text style
const questionTextStyle = TextStyle(
  color: Colors.white, // Couleur du texte
  fontSize: 18.0, // Taille de police
  fontWeight: FontWeight.bold, // Graisse du texte
);

// Classe question
class Question {
  String questionText;
  bool isCorrect;
  BoxDecoration decoPhoto;

  Question(
      {required this.questionText,
      required this.isCorrect,
      required this.decoPhoto});
}

class QuizzPage extends StatefulWidget {
  const QuizzPage({Key? key}) : super(key: key);

  @override
  QuizzPageState createState() => QuizzPageState();
}

const fauxText = Text("Faux");
const vraiText = Text("Vrai");

/* ****  PHOTO ***** */
// Image de l'Photo
const imageEiffel = AssetImage('assets/images/eiffel.jpg');
const imagePise = AssetImage('assets/images/pise.jpg');
const imageBigBen = AssetImage('assets/images/bigben.jpg');
const imageDcTower = AssetImage('assets/images/dctower.png');
const imageFern = AssetImage('assets/images/fernsehturm.jpg');
const imageAtomium = AssetImage('assets/images/atomium.jpg');
const imagePrimeTower = AssetImage('assets/images/primetower.jpg');
// Decoration de l'image
const decorationImageEiffel = DecorationImage(
  image: imageEiffel,
  fit: BoxFit.cover,
);
const decorationImagePise = DecorationImage(
  image: imagePise,
  fit: BoxFit.cover,
);
const decorationImageBigBen = DecorationImage(
  image: imageBigBen,
  fit: BoxFit.cover,
);
const decorationImagePrimeTower = DecorationImage(
  image: imagePrimeTower,
  fit: BoxFit.cover,
);
const decorationImageAtomium = DecorationImage(
  image: imageAtomium,
  fit: BoxFit.cover,
);
const decorationImageFern = DecorationImage(
  image: imageFern,
  fit: BoxFit.cover,
);
const decorationImageDcTower = DecorationImage(
  image: imageDcTower,
  fit: BoxFit.cover,
);
// Decoration des Photos
const decoPhotoEiffel = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  image: decorationImageEiffel,
);
const decoPhotoPise = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  image: decorationImagePise,
);
const decoPhotoBigBen = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  image: decorationImageBigBen,
);
const decoPhotoPrimeTower = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  image: decorationImagePrimeTower,
);
const decoPhotoAtomium = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  image: decorationImageAtomium,
);
const decoPhotoFern = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  image: decorationImageFern,
);
const decoPhotoDcTower = BoxDecoration(
  borderRadius: BorderRadius.all(Radius.circular(10.0)),
  image: decorationImageDcTower,
);

Container _getPhoto(decoPhoto) {
  return Container(
    width: 200,
    height: 300,
    decoration: decoPhoto,
  );
}

class QuizzPageState extends State<QuizzPage> {
  // Liste des questions
  List<Question> questions = [
    Question(
        questionText: "La tour Eiffel est à Paris.",
        isCorrect: true,
        decoPhoto: decoPhotoEiffel),
    Question(
        questionText: "La tour de Pise est en allemagne.",
        isCorrect: false,
        decoPhoto: decoPhotoPise),
    Question(
        questionText: "BigBen est à Cambridge en Angleterre.",
        isCorrect: false,
        decoPhoto: decoPhotoBigBen),
    Question(
        questionText: "La Prime Tower est à Zurich au Pays-Bas.",
        isCorrect: false,
        decoPhoto: decoPhotoPrimeTower),
    Question(
        questionText: "L'Atomium est à Francfort en Belgique.",
        isCorrect: false,
        decoPhoto: decoPhotoAtomium),
    Question(
        questionText: "La tour Fernsehturm est à en Allemagne.",
        isCorrect: true,
        decoPhoto: decoPhotoFern),
    Question(
        questionText: "La DC Tower est en Autriche.",
        isCorrect: true,
        decoPhoto: decoPhotoDcTower),
  ];

  int indexQuestion = 0;
  int score = 0;

  // Fonction qui verifie la réponse juste
  int _checkAnswer(bool userChoice) {
    if (questions[indexQuestion].isCorrect == userChoice) {
      // La réponse est correcte
      score++;
    }

    // Passez à la question suivante
    if (indexQuestion < questions.length - 1) {
      setState(() {
        indexQuestion++; // incremente l'indice des questions
      });
    } else {
      // Vous avez terminé le quiz
      Navigator.pushNamed(context, '/quizz/resultat',
          arguments: {'score': score, 'nb_question': questions.length});
    }
    return -1;
  }

  @override
  Widget build(BuildContext context) {
    // Récupérez les paramètres passés
    final Map<String, dynamic>? arguments =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>?;

    // Vérifiez si des paramètres existes
    String title = arguments?['title'] ?? 'Titre inconnu';

    return Scaffold(
      appBar: AppBar(
        title: Text(title),
        backgroundColor: fushia,
      ),
      backgroundColor: fushiaGrey,
      body: Center(
        child: Container(
          padding: margePaddingAll20,
          child: Column(
            mainAxisAlignment:
                MainAxisAlignment.center, // Centrer verticalement
            children: [
              // Texte de la question
              Container(
                decoration: BoxDecoration(
                    border: Border.all(
                      color: fushia,
                      width: 0.5,
                    ),
                    borderRadius: const BorderRadius.all(Radius.circular(3.0))),
                padding: margePaddingAll10,
                child: Text(
                  questions[indexQuestion].questionText,
                  style: questionTextStyle,
                ),
              ),

              espaceFixe20, // Ajouter un espace entre le texte et les boutons
              _getPhoto(questions[indexQuestion].decoPhoto),
              espaceFixe20,
              // Boutons
              Row(
                mainAxisAlignment:
                    MainAxisAlignment.spaceEvenly, // Centrer horizontalement
                children: [
                  // Bouton vrai
                  ElevatedButton(
                    onPressed: () {
                      _checkAnswer(true);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: fushia,
                    ),
                    child: vraiText,
                  ),
                  // Bouton faux
                  ElevatedButton(
                    onPressed: () {
                      _checkAnswer(false);
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
      ),
    );
  }
}
