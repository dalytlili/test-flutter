import 'package:flutter/material.dart';
import 'package:front_flutter/screen/signin_screen.dart';
import 'package:front_flutter/widgets/custom_scaffold.dart';
import 'package:front_flutter/widgets/welcom_button.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      child: Stack(
        children: [
          // Image de fond qui couvre tout l'écran
          Positioned.fill(
            child: Image.asset(
              'assets/images/logo5.png', // Chemin de l'image
              fit: BoxFit.cover, // Ajuste l'image pour couvrir tout l'écran
            ),
          ),
          // Contenu principal
          Column(
            children: [
             
              Flexible(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(
                    left: 40.0,
                    right: 40.0,
                    bottom: 100.0, // Marge inférieure augmentée pour remonter le bouton
                  ),
                  child: Align(
                    alignment: Alignment.bottomCenter,
                    child: SizedBox(
                      width: double.infinity, // Le bouton occupe toute la largeur
                      height: 60, // Ajustez la hauteur du bouton
                      child: WelcomButton(
                        buttonText: 'Get Started',
                          onTap: SigninScreen(),
                        // onTap: SigninScreen(), // Ajoutez la navigation ici
                        color: const Color(0xFF53B170), // Nouvelle couleur
                        textColor: Colors.white, // Couleur du texte
                        borderRadius: BorderRadius.circular(10), // Bouton arrondi
                        elevation: 4, // Ombre du bouton
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
