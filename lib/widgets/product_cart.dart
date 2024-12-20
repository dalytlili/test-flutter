import 'package:flutter/material.dart';
import 'package:front_flutter/screen/constants.dart';
import 'package:front_flutter/screen/detail_screen.dart';
//import 'package:provider/provider.dart';

class ProductCart extends StatelessWidget {
  final Map<String, dynamic> product; // Le produit sous forme de Map

  const ProductCart({super.key, required this.product});

  @override
Widget build(BuildContext context) {
  //final provider = FavoriteProvider.of(context);
  return GestureDetector(
    onTap: () {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => DetailScreen(product: product),
        ),
      );
    },
    child: Stack(
      children: [
       Container(
  width: double.infinity,
  decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(20),
    color: const Color.fromARGB(255, 255, 255, 255),
    border: Border.all( // Ajout de la bordure
      color: Colors.grey, // Couleur de la bordure
      width: 1, // Épaisseur de la bordure
    ),
  ),
  child: SingleChildScrollView( // Ajout du SingleChildScrollView
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Center(
          child: Image.asset(
            'assets/images/pomme.png',
            width: 130,
            height: 130,
            fit: BoxFit.cover,
          ),
        ),
        const SizedBox(height: 10),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            product['name'] ?? 'Unknown',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16,
            ),
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            '${product['unit']} Kg, Priceg',
            style: const TextStyle(
              fontSize: 16,
            ),
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.only(left: 10),
          child: Text(
            '${product['price'] ?? '0.0'} \$',
            style: const TextStyle(
              color: Colors.black,
                            fontWeight: FontWeight.bold,

              fontSize: 18,
            ),
          ),
        ),
        const SizedBox(height: 10),
      ],
    ),
  ),
),

        Positioned(
  top: 180,  // Décalage vers le haut de 180 pixels
  right: 10, // Décalage vers la droite de 10 pixels
  child: Align(
    alignment: Alignment.bottomRight,
    child: Container(
      height: 40,
      width: 40,
      decoration: const BoxDecoration(
        color: kprimaryColor,
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(10),
          topLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
          bottomLeft: Radius.circular(10),
        ),
      ),
      child: IconButton(
        onPressed: () {
          // Action à effectuer lorsque l'icône est cliquée
          print('Icon + clicked');
        },
        icon: const Icon(
          Icons.add,  // Icône "plus"
          color: Colors.white,  // Couleur de l'icône
        ),
      ),
    ),
  ),
),

      ],
    ),
  );
}}
