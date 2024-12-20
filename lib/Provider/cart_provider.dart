import 'package:flutter/material.dart';
import 'package:front_flutter/models/Product.dart';
import 'package:provider/provider.dart';

class CartProvider extends ChangeNotifier {
  final List<Product> _cart = [];
  List<Product> get cart => _cart;

  void toggleFavorite(Product product) {
  final existingProductIndex = _cart.indexWhere((element) => element.id == product.id && 
      element.selectedSize == product.selectedSize && 
      element.selectedColor == product.selectedColor);
  
  if (existingProductIndex != -1) {
    // Incrémenter la quantité si le produit avec la même taille et couleur existe déjà
    _cart[existingProductIndex].quantity += product.quantity;
  } else {
    // Ajouter le produit au panier
    _cart.add(product);
  }
  notifyListeners();
}



  void incrementQtn(int index) {
    _cart[index].quantity++;
    notifyListeners();
  }

  void decrementQtn(int index) {
    if (_cart[index].quantity > 1) {
      _cart[index].quantity--;
    } else {
      // Si la quantité est 1, vous pouvez choisir de retirer le produit
      _cart.removeAt(index);
    }
    notifyListeners();
  }

  double totalPrice() {
    return _cart.fold(0.0, (total, element) => total + (element.price * element.quantity));
  }

  static CartProvider of(BuildContext context, {bool listen = true}) {
    return Provider.of<CartProvider>(context, listen: listen);
  }
}
