import 'package:flutter/material.dart';
//import 'package:front_flutter/Provider/cart_provider.dart';
import 'package:front_flutter/screen/constants.dart';
//import 'package:provider/provider.dart';
import 'package:front_flutter/models/Product.dart'; // Ajustez le chemin si nécessaire

class AddtoCart extends StatefulWidget {
  final Map<String, dynamic> product;
 

  const AddtoCart({
    super.key,
    required this.product,
    
  });

  @override
  State<AddtoCart> createState() => _AddtoCartState();
}


class _AddtoCartState extends State<AddtoCart> {
  int currentIndex = 1;
  String selectedSize = ""; 
  Color? selectedColor; // Modifier pour Color?

  @override
  Widget build(BuildContext context) {
   // final provider = CartProvider.of(context);
    
    // Récupérer les tailles disponibles
    List availableSizes = widget.product['availableSizes'];
    // Assurez-vous que availableColors n'est pas null
    List<Color> availableColors = (widget.product['availableColors'] ?? []).cast<Color>(); // Liste des couleurs disponibles
    
    // Initialiser selectedColor avec la première couleur disponible si elle n'est pas déjà définie
    selectedColor ??= availableColors.isNotEmpty ? availableColors[0] : null;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Container(
        height: 85,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(50),
          color: Colors.black,
        ),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            // Sélecteur de quantité
            Container(
              height: 40,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.white, width: 2),
              ),
              child: Row(
                children: [
                  IconButton(
                    onPressed: () {
                      if (currentIndex > 1) {
                        setState(() {
                          currentIndex--;
                        });
                      }
                    },
                    iconSize: 18,
                    icon: const Icon(
                      Icons.remove,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 5),
                  Text(
                    currentIndex.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(width: 5),
                  IconButton(
                    onPressed: () {
                      setState(() {
                        currentIndex++;
                      });
                    },
                    iconSize: 18,
                    icon: const Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
            // Bouton "Ajouter au panier"
            GestureDetector(
              onTap: () {

    final product = Product.fromJson(widget.product);
    product.quantity = currentIndex;
    

   // provider.toggleFavorite(product);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text(
          "Successfully added!",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white,
          ),
        ),
        duration: Duration(seconds: 1),
      ),
    );
  },


              child: Container(
                height: 55,
                decoration: BoxDecoration(
                  color: kprimaryColor,
                  borderRadius: BorderRadius.circular(50),
                ),
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(horizontal: 50),
                child: const Text(
                  "Add to Cart",
                  style: TextStyle(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
