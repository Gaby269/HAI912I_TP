import 'package:flutter/material.dart';
import 'package:tp1_profile_card_app/screens/profil.dart';
import 'package:tp1_profile_card_app/screens/quizz.dart';
import 'package:tp1_profile_card_app/screens/resultat_quiz.dart';

// Couleurs
const fushia = Color.fromARGB(255, 96, 3, 54);
const fushiaClaire = Color.fromARGB(255, 255, 202, 231);
const fushiaSemiClaire = Color.fromARGB(255, 196, 103, 154);
// Marges / Padding
const margePaddingAll50 = EdgeInsets.all(50);
const margePaddingAll75 = EdgeInsets.all(75);
const margePaddingAll20 = EdgeInsets.all(20);
// Espace
const espaceFixe10 = SizedBox(height: 10);
const espaceFixe20 = SizedBox(height: 20);
const espaceFixe50 = SizedBox(height: 50);
const espaceFixe80 = SizedBox(height: 80);
// Tailles d'objet
const sizeButton = Size(200, 50);
// Theme
const textTitre = TextStyle(fontSize: 24, fontWeight: FontWeight.bold);
const textBody = TextStyle(fontSize: 16);
const textThemePersonel = TextTheme(
  headline6: textTitre, // Exemple de style de texte
  bodyText2: textBody, // Autre exemple de style de texte
);
var themePersonalise = ThemeData(
  primarySwatch: MaterialColor(
    fushia.value,
    <int, Color>{
      50: fushia.withOpacity(0.1),
      100: fushia.withOpacity(0.2),
      200: fushia.withOpacity(0.3),
      300: fushia.withOpacity(0.4),
      400: fushia.withOpacity(0.5),
      500: fushia.withOpacity(0.6),
      600: fushia.withOpacity(0.7),
      700: fushia.withOpacity(0.8),
      800: fushia.withOpacity(0.9),
      900: fushia,
    },
  ), // Couleur principale de l'application
  visualDensity: VisualDensity.adaptivePlatformDensity,
  fontFamily: 'Roboto', // Police de caractères par défaut
  textTheme: textThemePersonel,
);

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: MyHomePage(),
      theme: themePersonalise, // Choisir un theme
      initialRoute: '/',
      routes: {
        '/profil': (context) => const ProfilePage(),
        '/quizz': (context) => const QuizzPage(),
        '/quizz/resultat': (context) => const ResultatPage(),
      },
    );
  }
}

const menuText = Text("TP1 - Menu");
const textProfil = Text(
  "Votre profil",
  style: TextStyle(
    fontSize: 20, // Taille de la police
  ),
);
const textQuizz = Text(
  "Quizz",
  style: TextStyle(
    fontSize: 20, // Taille de la police
  ),
);
const titreMenu = Text(
  "COSSU - POINTEAU - SAID",
  style: TextStyle(
      fontSize: 27,
      fontWeight: FontWeight.bold,
      color: fushia // Taille de la police
      ),
);
const titreGroupe = Text(
  "Groupe 8",
  style: TextStyle(
      fontSize: 22,
      fontWeight: FontWeight.bold,
      color: fushiaSemiClaire // Taille de la police
      ),
);

const pageQuizz = QuizzPage();
const pageProfil = ProfilePage();

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
              espaceFixe10,
              titreGroupe,
              espaceFixe50,
              ElevatedButton(
                onPressed: () {
                  // Aller sur le profil
                  Navigator.pushNamed(context, '/profil');
                },
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      sizeButton, // Définir la taille minimale du bouton
                  backgroundColor: fushia,
                  padding: margePaddingAll20,
                ),
                child: textProfil,
              ),
              espaceFixe20,
              ElevatedButton(
                onPressed: () {
                  // Aller sur le quizz
                  Navigator.pushNamed(context, '/quizz', arguments: {
                    'title': 'Quizz',
                  });
                },
                style: ElevatedButton.styleFrom(
                  minimumSize:
                      sizeButton, // Définir la taille minimale du bouton
                  backgroundColor: fushia,
                  padding: margePaddingAll20,
                ),
                child: textQuizz,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
