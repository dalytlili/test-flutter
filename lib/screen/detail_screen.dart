import 'package:flutter/material.dart';
import 'package:front_flutter/models/Product.dart';
import 'package:front_flutter/screen/addto_cart.dart';
import 'package:front_flutter/screen/constants.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class DetailScreen extends StatefulWidget {
  final dynamic product;

  const DetailScreen({super.key, required this.product});

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
 

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ksecondecolor,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context); // Naviguer vers l'écran précédent
          },
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Image en haut de la page
              Container(
                width: double.infinity,
                height: 300,  // Ajustez la hauteur selon votre besoin
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/pomme.png'), // Assurez-vous que le fichier est dans le bon dossier
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
              ),
              const SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [  
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Permet de séparer les éléments de façon égale
                      children: [
                         Text(
                          widget.product['name'] ?? 'Product Name',
                          style: const TextStyle(fontSize: 25, fontWeight: FontWeight.w800),
                        ),
                        // Icône favori avant le nom du produit
                        IconButton(
                          icon: Icon(
                            Icons.favorite_border,
                          ),
                          onPressed: () {
                            setState(() {});
                          },
                        ),
                      ],
                    ),
                    Text(
                      '${widget.product['unit']} Kg, Priceg',
                      style: const TextStyle(fontSize: 20),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,  // Espacement entre les éléments
                      children: [
                        // Icônes pour la quantité (décrémenter et incrémenter)
                        Row(
                          children: [
                            // Icône - pour décrémenter
                            GestureDetector(
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                child: const Icon(Icons.remove, size: 18), // Icône pour décrémenter
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Affichage du numéro de quantité au centre
                            Container(
                              padding: const EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                border: Border.all(color: Colors.grey),
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Text(
                                '1',  // Affichage du nombre actuel
                                style: const TextStyle(fontSize: 20),
                              ),
                            ),
                            const SizedBox(width: 10),
                            // Icône + pour incrémenter
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  // Logique pour incrémenter la quantité
                                });
                              },
                              child: Container(
                                padding: const EdgeInsets.all(5),
                                child: const Icon(Icons.add, size: 18, color: kprimaryColor), // Icône pour incrémenter
                              ),
                            ),
                          ],
                        ),
                        // Le prix à la fin de la ligne
                        Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              '${widget.product['price'] ?? '0'} DT',
                              style: const TextStyle(fontSize: 20, color: Colors.black),
                            ),
                            const SizedBox(height: 5),
                          ],
                        ),
                      ],
                    ),
                    // Description et autres contenus
                    const Divider(thickness: 1, color: Colors.grey),  // Ligne séparatrice
                    Text(
                      'Product Details',
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      'Ecrivez n\'importe quoi pour les détails du produit ici.',
                      style: const TextStyle(fontSize: 16),
                    ),
                    const Divider(thickness: 1, color: Colors.grey),  // Ligne séparatrice
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Nutritional Info',
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                        ),
                        IconButton(
                          icon: Icon(Icons.keyboard_arrow_left, color: const Color.fromARGB(255, 0, 0, 0)),  // Icône pour actualiser
                          onPressed: () {
                            // Logique de rafraîchissement
                          },
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        const Divider(thickness: 1, color: Colors.grey),  // Ligne séparatrice

                        // Affichage du titre "Reviews" et des étoiles
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Reviews',
                              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(width: 10), // Espacement entre le texte et les étoiles
                            // Affichage des étoiles
                            Row(
                              children: List.generate(5, (index) {
                                return Icon(
                                  Icons.star,
                                  color: index < 3 ? Colors.amber : Colors.grey, // Exemple avec 3 étoiles pleines et les autres grises
                                  size: 20,
                                );
                              }),
                            ),
                            IconButton(
                              icon: Icon(Icons.keyboard_arrow_right, color: const Color.fromARGB(255, 0, 0, 0)),  // Icône pour actualiser
                              onPressed: () {
                                // Logique de rafraîchissement
                              },
                            ),
                          ],
                        ),
  
                        // Ajout du bouton "Add to Basket" en bas
                      Padding(
  padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
  child: Container(
    width: double.infinity, // This will make the button take the full width
    child: ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: kprimaryColor, // Button background color
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(20), // Rounded corners
        ),
        padding: const EdgeInsets.symmetric(vertical: 15), // Adjusts the height of the button
      ),
      onPressed: () {
        // Check if the product is not null before navigation
        if (widget.product != null) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => AddtoCart(
                product: widget.product, // Pass the selected color if necessary
              ),
            ),
          );
        } else {
          // Show an error message if the product is null
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Produit non disponible')),
          );
        }
      },
      child: const Text(
        'Add to Basket', // Button text
        style: TextStyle(
          fontSize: 18,
          color: Colors.white, // Text color
        ),
      ),
    ),
  ),
)

                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}