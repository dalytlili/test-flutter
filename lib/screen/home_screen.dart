import 'dart:convert';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:front_flutter/screen/constants.dart';
import 'package:http/http.dart' as http;
import 'package:front_flutter/widgets/home_app_bar.dart';
import 'package:front_flutter/widgets/product_cart.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int currentSlider = 0;
  late PageController pageController;
  late Timer timer;
  List<dynamic> products = [];
  List<dynamic> filteredProducts = [];
  late Future<void> _categoryRefreshFuture;
  String? selectedSubCategoryId;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    pageController = PageController(initialPage: currentSlider);

    timer = Timer.periodic(const Duration(seconds: 5), (Timer t) {
      setState(() {
        currentSlider = (currentSlider + 1) % 3;
        pageController.animateToPage(
          currentSlider,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });
    });

    fetchAllProducts();
    _categoryRefreshFuture = fetchCategories();
  }

  @override
  void dispose() {
    timer.cancel();
    pageController.dispose();
    super.dispose();
  }

  Future<void> fetchAllProducts() async {
    setState(() {
      isLoading = true;
    });

    final response = await http.get(Uri.parse('http://10.0.2.2:9098/api/products'));

    if (response.statusCode == 200) {
      setState(() {
        products = json.decode(response.body);
        filteredProducts = products; // Initialise les produits filtrés
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('Erreur lors de la récupération des produits');
    }
  }

  Future<void> fetchProducts(String? subCategoryId) async {
    setState(() {
      isLoading = true;
      products = [];
      filteredProducts = [];
    });

    final url = subCategoryId != null
        ? 'http://127.0.0.1:9098/api/v1/products/sub-category/$subCategoryId'
        : 'http://127.0.0.1:9098/api/v1/products';

    final response = await http.get(Uri.parse(url));

    if (response.statusCode == 200) {
      setState(() {
        products = json.decode(response.body);
        filteredProducts = products;
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
      print('Erreur lors de la récupération des produits');
    }
  }

  Future<void> fetchCategories() async {
    // Ajoutez votre code ici pour récupérer les catégories
  }

  Future<void> _refreshData() async {
    if (selectedSubCategoryId != null) {
      await fetchProducts(selectedSubCategoryId!);
    } else {
      await fetchAllProducts();
    }
    setState(() {
      _categoryRefreshFuture = fetchCategories();
    });
  }

  // Fonction de recherche avancée
  void searchProducts(String keyword, double? minPrice, double? maxPrice) {
    setState(() {
      isLoading = true;
    });

    final searchResults = products.where((product) {
      final nameMatch = product['name'].toLowerCase().contains(keyword.toLowerCase());
      final price = product['price'];

      final priceMatch = (minPrice == null || price >= minPrice) && (maxPrice == null || price <= maxPrice);

      return nameMatch && priceMatch;
    }).toList();

    setState(() {
      filteredProducts = searchResults;
      isLoading = false;
    });
  }
  
  @override
Widget build(BuildContext context) {
  return Scaffold(
    backgroundColor: Colors.white,
    body: RefreshIndicator(
      onRefresh: _refreshData,
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Logo
                            const SizedBox(height: 40),

              Center(
                
                child: Image.asset(
                  'assets/images/logo11.png', // Assurez-vous que l'image est dans le bon dossier
                  height: 60,
                ),
              ),
              // Localisation
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.location_on,
                    color: Colors.black,
                  ),
                  const SizedBox(width: 5),
                  const Text(
                    "Dhaka, Banassre",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Barre de recherche
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  children: [
                    const Icon(
                      Icons.search,
                      color: Colors.grey,
                      size: 30,
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        onChanged: (value) {
                          searchProducts(value, null, null);
                        },
                        decoration: const InputDecoration(
                          hintText: "Search Store",
                          border: InputBorder.none,
                        ),
                      ),
                    ),
                  
                  ],
                ),
              ),
              const SizedBox(height: 20),
              // Titre de la section
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text(
                    "Exlusive Offer",
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        selectedSubCategoryId = null;
                      });
                      fetchProducts(null);
                    },
                    child: const Text(
                      "See all",
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
color: kprimaryColor,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              // Liste des produits
              isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : filteredProducts.isEmpty
                      ? const Center(
                          child: Text(
                            "No products available in this category.",
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        )
                      : GridView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          shrinkWrap: true,
                          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 2,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 10,
                            childAspectRatio: 0.78,
                          ),
                          itemCount: filteredProducts.length,
                          itemBuilder: (context, index) {
                            return ProductCart(product: filteredProducts[index]);
                          },
                        ),
            ],
          ),
        ),
      ),
    ),
  );
}
 }