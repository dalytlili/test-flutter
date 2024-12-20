import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:front_flutter/screen/cart_screen.dart';
import 'package:front_flutter/screen/home_screen.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int currentIndex = 1; 
  String? token;
  bool isLoading = true;

  final FlutterSecureStorage secureStorage = const FlutterSecureStorage();

  @override
  void initState() {
    super.initState();
    _loadToken();
  }

  Future<void> _loadToken() async {
    token = await secureStorage.read(key: 'accessToken');
    if (token == null || token!.isEmpty) {
      print("Token is null or empty");
    } else {
      print("Token loaded successfully: $token");
    }
    setState(() {
      isLoading = false; // Token chargé avec succès
    });
  }

  final List<Widget> screens = [
    const Scaffold(), // Ecran de shop
    const Scaffold(), // Ecran explore
    const Scaffold(), // Ecran du panier
    const Scaffold(), // Ecran des favoris
    const CartScreen(), // Ecran du panier
  ];

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: CircularProgressIndicator()) // Affiche l'indicateur de chargement tant que le token n'est pas chargé
        : Scaffold(
            bottomNavigationBar: BottomAppBar(
              height: 70,
              color: Colors.white,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildNavItem(
                    icon: Icons.storefront,
                    label: 'Shop',
                    index: 0,
                  ),
                  _buildNavItem(
                    icon: Icons.manage_search,
                    label: 'Explore',
                    index: 1,
                  ),
                  _buildNavItem(
                    icon: Icons.shopping_cart_outlined,
                    label: 'Cart',
                    index: 2,
                  ),
                  _buildNavItem(
                    icon: Icons.favorite_border,
                    label: 'Favorite',
                    index: 3,
                  ),
                  _buildNavItem(
                    icon: Icons.person_outline,
                    label: 'Account',
                    index: 4,
                    requiresToken: true,
                  ),
                ],
              ),
            ),
            body: IndexedStack(
              index: currentIndex,
               children: [
                // تمرير التوكن المحمل إلى صفحة البروفايل
                    // const OrderHistoryPage(),
          
                      
               
                   
              
                     //const FavoritteScreen(),
                HomeScreen(),
                
            
               // const CartScreen(),
                // Profile(token: token!), // شاشة إضافية فارغة
              ],
            ),
          );
  }

  Widget _buildNavItem({
    required IconData icon,
    required String label,
    required int index,
    bool requiresToken = false,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () {
          if (requiresToken && (token == null || token!.isEmpty)) {
            print("Token is not loaded yet");
            return;
          }
          setState(() {
            currentIndex = index;
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 24), // Réduire la taille de l'icône
            const SizedBox(height: 2), // Espacement plus petit
            Text(
              label,
              style: const TextStyle(fontSize: 10, color: Colors.black), // Réduire la taille du texte
            ),
          ],
        ),
      ),
    );
  }
}
