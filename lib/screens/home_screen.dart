import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_shopping_app/screens/product_details_screen.dart';
import 'package:scholar_shopping_app/services/list_carts.dart';
import 'package:scholar_shopping_app/services/products.dart';
import 'package:scholar_shopping_app/widgets/category_home_list_view.dart';
import 'package:scholar_shopping_app/widgets/custom_drawer.dart';
import 'package:scholar_shopping_app/widgets/horizental_product_list_item.dart';
import 'package:scholar_shopping_app/widgets/vertical_product_list_item.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  String? fullName;
  String? email;
  String? imagePath;
  final userId = FirebaseAuth.instance.currentUser!.uid;

  Future<DocumentSnapshot> getUserData() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();
  }

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString("fulltname");
      email = prefs.getString("email");
      imagePath = prefs.getString("profileImagePath");
    });
  }

  int getTotalCount() {
    int count = 0;
    for (var item in listCarts) {
      count += item.count;
    }
    return count;
  }

  double getTotalPrice() {
    double total = 0.0;
    for (var item in listCarts) {
      total += item.price * item.count;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: CustomDrawer(),
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        leading: Builder(
          builder:
              (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
        ),
        title: Row(
          children: [
            Text(
              "Products",
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
            ),
            Spacer(),
            IconButton(
              onPressed: () {},
              icon: Icon(Icons.search, color: Colors.white),
            ),
          ],
        ),
      ),

      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            SliverToBoxAdapter(
              child: Text(
                "Shop by Category",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(height: 100, child: CategoryHomeListView()),
            ),
            SliverToBoxAdapter(
              child: Text(
                "Featured Products",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            SliverToBoxAdapter(
              child: SizedBox(
                height: 260,
                child: ListView.builder(
                  physics: BouncingScrollPhysics(),
                  scrollDirection: Axis.horizontal,
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) {
                              return ProductDetailsScreen(
                                productModel: products[index],
                              );
                            },
                          ),
                        );
                      },
                      child: HorizentalProductListItem(
                        productModel: products[index],
                      ),
                    );
                  },
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  "New Arrivals",
                  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) {
                            return ProductDetailsScreen(
                              productModel: products[index],
                            );
                          },
                        ),
                      );
                    },
                    child: VerticalProductListItem(
                      productModel: products[index],
                    ),
                  );
                }, childCount: products.length),

                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 8,
                  crossAxisSpacing: 8,
                  childAspectRatio: 0.65,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
