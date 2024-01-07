import 'package:flutter/material.dart';
import 'package:tp1_profile_card_app/screens/resultat_quiz.dart';

/////////////////////////
// PARAMETRES GENERAUX //
/////////////////////////

// Couleurs
const fushia = Color.fromARGB(255, 96, 3, 54);
const fushiaClaire = Color.fromARGB(255, 255, 202, 231);
// Marges / Padding
const margePaddingAll50 = EdgeInsets.all(50);
const margePaddingAll75 = EdgeInsets.all(75);
const margePaddingAll20 = EdgeInsets.all(20);
const margePaddingTop150 = EdgeInsets.only(top: 150.0);
// Espace
const espaceFixe40 = SizedBox(height: 40);
const espaceFixe5 = SizedBox(height: 5);

//////////
// CARD //
//////////
// Box ombre
const boxShadow = BoxShadow(
  color: fushiaClaire,
  blurRadius: 5,
);

/* ****  AVATAR ***** */
// Image de l'avatar
const imageProfil = AssetImage('assets/images/Groupe_8.jpg');
// Mon image
const monImage = Image(
  image: imageProfil,
  fit: BoxFit.cover,
  width: 100,
  height: 100,
);
const decoAvatarCercle = BoxDecoration(
  shape: BoxShape.circle,
  color: fushia, // La couleur du cadre
);

const decoAvatarRectangle = BoxDecoration(
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(80), // La moitié de la largeur du rectangle
    topRight: Radius.circular(80), // La moitié de la largeur du rectangle
  ),
  color: fushia, // La couleur du cadre
);

/* ****  INFO PERSO ***** */
// Textes Card
const profilText = Text("Profil");
const nomText = Text(
  'COSSU POINTEAU SAID',
  style: TextStyle(
    fontSize: 24,
    color: Colors.white,
  ),
);
const mailText = Text(
  'groupe8@cps-exemple.fr',
  style: TextStyle(fontSize: 16, color: Colors.white),
);
const reseauSociauxText = Text(
  '@CPSgroupe8',
  style: TextStyle(fontSize: 16, color: Colors.white),
);

//////////
// HOME //
//////////
// Page home avec mon profil
class ProfilePage extends StatelessWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Ajout du titre de la page en haut
      appBar: AppBar(
        title: profilText,
        centerTitle: false,
        backgroundColor: fushia,
      ),
      // Ajouter le body de la page qui sera un container
      body: Center(
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            _getCard(),
            // Decalage de l'image vers le haut
            Transform.translate(
              // Utilisation de Transform plutot que Positioned car Positioned coupe l' image
              offset: const Offset(0,
                  -100), // Ajustez la valeur pour déplacer l'image vers le haut
              child: _getAvatar(),
            ),
          ],
        ),
      ),
    );
  }

  Container _getAvatar() {
    return Container(
      width: 125, // Ajustez la largeur pour que le contenant soit plus grand
      height: 125, // Ajustez la hauteur pour que le contenant soit plus grand
      decoration: decoAvatarRectangle,
      clipBehavior: Clip.antiAlias,
      child: Center(
        child: Container(
          width: 100,
          height: 100,
          decoration: decoAvatarCercle,
          clipBehavior: Clip.antiAlias,
          child: monImage,
        ),
      ),
    );
  }

  // Recuperer les données de la carte
  Container _getCard() {
    return Container(
      width: 330,
      height: 200,
      padding: edgeInsets20,
      decoration: BoxDecoration(
        color: fushia,
        borderRadius: BorderRadius.circular(10),
      ),
      child: const Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            espaceFixe40,
            nomText,
            espaceFixe5,
            mailText,
            espaceFixe5,
            reseauSociauxText,
          ],
        ),
      ),
    );
  }
}
