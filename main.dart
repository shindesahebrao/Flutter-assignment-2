import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'Grocery App UI',
      debugShowCheckedModeBanner: false,
      home: GroceryHome(),
    );
  }
}

class GroceryHome extends StatelessWidget {
  const GroceryHome({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[100],
      appBar: AppBar(
        backgroundColor: Colors.green.shade700,
        elevation: 0,
        title: const Text('Fresh Grocery'),
        actions: const [
          Icon(Icons.search, size: 26),
          SizedBox(width: 16),
          Icon(Icons.shopping_cart_outlined, size: 26),
          SizedBox(width: 12),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Popular Products",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            SizedBox(
              height: 240,
              child: ListView(
                scrollDirection: Axis.horizontal,
                children:
                    productList.map((p) => ProductCard(product: p)).toList(),
              ),
            ),
            const SizedBox(height: 24),
            const Text("Categories",
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 12),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                CategoryItem(title: "Fruits", icon: Icons.apple),
                CategoryItem(title: "Veggies", icon: Icons.eco),
                CategoryItem(title: "Drinks", icon: Icons.local_drink),
                CategoryItem(title: "Bakery", icon: Icons.cake),
              ],
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green.shade700,
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: "Categories"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite_border), label: "Favorites"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
        ],
      ),
    );
  }
}

// Product Model
class Product {
  final String name;
  final String imageUrl;
  final double price;
  final double rating;
  final String deliveryTime;

  Product(
      {required this.name,
      required this.imageUrl,
      required this.price,
      required this.rating,
      required this.deliveryTime});
}

List<Product> productList = [
  Product(
    name: 'Fresh Broccoli',
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/2909/2909769.png',
    price: 2.99,
    rating: 4.5,
    deliveryTime: '30 min',
  ),
  Product(
    name: 'Red Apples',
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/415/415682.png',
    price: 3.49,
    rating: 4.8,
    deliveryTime: '25 min',
  ),
  Product(
    name: 'Bananas',
    imageUrl: 'https://cdn-icons-png.flaticon.com/512/590/590685.png',
    price: 1.99,
    rating: 4.2,
    deliveryTime: '20 min',
  ),
];

// Product Card Widget
class ProductCard extends StatelessWidget {
  final Product product;
  const ProductCard({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 160,
      margin: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(color: Colors.black12, blurRadius: 6, offset: Offset(0, 2))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.green.shade50,
              borderRadius:
                  const BorderRadius.vertical(top: Radius.circular(16)),
              image: DecorationImage(
                  image: NetworkImage(product.imageUrl), fit: BoxFit.contain),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(product.name,
                style:
                    const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: Text("\$${product.price}",
                style: const TextStyle(fontSize: 14, color: Colors.grey)),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RatingStars(rating: product.rating),
          ),
        ],
      ),
    );
  }
}

// Rating Stars
class RatingStars extends StatelessWidget {
  final double rating;
  const RatingStars({super.key, required this.rating});

  @override
  Widget build(BuildContext context) {
    int stars = rating.floor();
    return Row(
      children: List.generate(5, (index) {
        return Icon(index < stars ? Icons.star : Icons.star_border,
            color: Colors.orange, size: 16);
      }),
    );
  }
}

// Category Item
class CategoryItem extends StatelessWidget {
  final String title;
  final IconData icon;
  const CategoryItem({super.key, required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CircleAvatar(
          radius: 28,
          backgroundColor: Colors.green.shade100,
          child: Icon(icon, color: Colors.green.shade800, size: 30),
        ),
        const SizedBox(height: 6),
        Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    );
  }
}
