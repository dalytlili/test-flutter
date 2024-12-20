import 'package:flutter/material.dart';

class Product {
  final String id;
  final String name;
  final double price;
  final String unit; // Nouveau champ pour l'unité
  final String description; // Nouveau champ pour la description
  List<String> images;
  int quantity;
  String? selectedSize;
  Color? selectedColor;

  Product({
    required this.id,
    required this.name,
    required this.price,
    required this.unit, // Ajoutez ce champ au constructeur
    required this.description, // Ajoutez ce champ au constructeur
    required this.images,
    this.quantity = 1,
    this.selectedSize,
    this.selectedColor,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['_id'] ?? '', // Assurez-vous de correspondre au format MongoDB
      name: json['name'] ?? '',
      price: (json['price'] as num).toDouble(),
      unit: json['unit'] ?? '', // Nouveau champ pour l'unité
      description: json['description'] ?? '', // Nouveau champ pour la description
      images: List<String>.from(json['images'] ?? []),
      quantity: json['quantity'] ?? 1,
      selectedSize: json['selectedSize'],
      selectedColor: json['selectedColor'] != null
          ? Color(json['selectedColor'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'price': price,
      'unit': unit, // Ajoutez ce champ à l'exportation JSON
      'description': description, // Ajoutez ce champ à l'exportation JSON
      'images': images,
      'quantity': quantity,
      'selectedSize': selectedSize,
      'selectedColor': selectedColor?.value,
    };
  }
}
