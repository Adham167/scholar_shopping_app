import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_shopping_app/screens/product_details_screen.dart';
import 'package:scholar_shopping_app/services/list_carts.dart';
import 'package:scholar_shopping_app/services/products.dart';
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
      drawer: FutureBuilder<DocumentSnapshot>(
        future: getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error fetching user data'));
          }

          if (!snapshot.hasData || !snapshot.data!.exists) {
            return Center(child: Text('User data not found'));
          }

          final userData = snapshot.data!.data() as Map<String, dynamic>;

          return Drawer(
            child: Column(
              children: [
                DrawerHeader(
                  decoration: BoxDecoration(color: Colors.blueAccent),

                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CircleAvatar(
                            radius: 40,
                            backgroundImage:
                                imagePath != null
                                    ? FileImage(File(imagePath!))
                                    : null,
                            child:
                                imagePath == null
                                    ? Icon(
                                      Icons.person,
                                      size: 60,
                                      color: Colors.white,
                                    )
                                    : null,
                          ),
                          SizedBox(height: 8),
                          Text(
                            userData['name'] ?? "Guest User",
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            userData['mail'] ?? "",
                            style: TextStyle(
                              color: Colors.white70,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                ListTile(
                  onTap: () => Navigator.pop(context),
                  leading: Icon(Icons.home, color: Colors.blueAccent),
                  title: Text("Home"),
                ),
                ValueListenableBuilder(
                  valueListenable: cartItemCountNotifier,

                  builder: (context, value, child) {
                    return ListTile(
                      onTap:
                          () => Navigator.pushNamed(context, "/shoppingcart"),
                      leading: Stack(
                        children: [
                          Icon(
                            Icons.shopping_cart_sharp,
                            color: Colors.blueAccent,
                          ),
                          Positioned(
                            right: 0,
                            top: 0,
                            child: Container(
                              padding: EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                color: Colors.red,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              constraints: BoxConstraints(
                                minWidth: 16,
                                minHeight: 16,
                              ),
                              child: Text(
                                "${getTotalCount()}",
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 10,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                        ],
                      ),
                      title: Row(
                        children: [
                          Text("Cart"),
                          Spacer(),
                          Text(
                            ("\$${getTotalPrice()}"),
                            style: TextStyle(color: Colors.green, fontSize: 14),
                          ),
                        ],
                      ),
                    );
                  },
                ),
                ListTile(
                  onTap: () => Navigator.pushNamed(context, "/orderscreen"),
                  leading: Icon(
                    Icons.featured_play_list,
                    color: Colors.blueAccent,
                  ),
                  title: Text("Orders"),
                ),
                Divider(),
                ListTile(
                  onTap: () => Navigator.pop(context),
                  leading: Icon(Icons.settings, color: Colors.blueAccent),
                  title: Text("Settings"),
                ),
                ListTile(
                  onTap: () => Navigator.pop(context),
                  leading: Icon(Icons.help_outline, color: Colors.blueAccent),
                  title: Text("Help & Support"),
                ),
                Spacer(),
                Divider(),
                ListTile(
                  onTap: () {
                    Navigator.pushReplacementNamed(context, "/");
                  },
                  leading: Icon(Icons.logout, color: Colors.red),
                  title: Text("Logout", style: TextStyle(color: Colors.red)),
                ),
                SizedBox(height: 16),
              ],
            ),
          );
        },
      ),
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
