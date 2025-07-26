import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:scholar_shopping_app/services/list_carts.dart';

class CustomDrawer extends StatelessWidget {
  CustomDrawer({super.key});

  final userId = FirebaseAuth.instance.currentUser!.uid;

  Future<DocumentSnapshot> getUserData() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();
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
    return FutureBuilder<DocumentSnapshot>(
      future: getUserData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error fetching user data'));
        }

        if (!snapshot.hasData || !snapshot.data!.exists) {
          return const Center(child: Text('User data not found'));
        }

        final userData = snapshot.data!.data() as Map<String, dynamic>;
        final imagePath = userData["imagePath"];

        return Drawer(
          child: Column(
            children: [
              DrawerHeader(
                decoration: const BoxDecoration(color: Colors.blueAccent),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        CircleAvatar(
                          radius: 40,
                          backgroundImage:
                              imagePath != null
                                  ? FileImage(File(imagePath))
                                  : null,
                          child:
                              imagePath == null
                                  ? const Icon(
                                    Icons.person,
                                    size: 60,
                                    color: Colors.white,
                                  )
                                  : null,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          userData['name'] ?? "Guest User",
                          style: const TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Text(
                          userData['mail'] ?? "",
                          style: const TextStyle(
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
                leading: const Icon(Icons.home, color: Colors.blueAccent),
                title: const Text("Home"),
              ),
              ValueListenableBuilder(
                valueListenable: cartItemCountNotifier,
                builder: (context, value, child) {
                  return ListTile(
                    onTap: () => Navigator.pushNamed(context, "/shoppingcart"),
                    leading: Stack(
                      children: [
                        const Icon(
                          Icons.shopping_cart_sharp,
                          color: Colors.blueAccent,
                        ),
                        Positioned(
                          right: 0,
                          top: 0,
                          child: Container(
                            padding: const EdgeInsets.all(2),
                            decoration: BoxDecoration(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            constraints: const BoxConstraints(
                              minWidth: 16,
                              minHeight: 16,
                            ),
                            child: Text(
                              "$value",
                              style: const TextStyle(
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
                        const Text("Cart"),
                        const Spacer(),
                        Text(
                          ("\$${getTotalPrice()}"),
                          style: const TextStyle(
                            color: Colors.green,
                            fontSize: 14,
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
              ListTile(
                onTap: () => Navigator.pushNamed(context, "/orderscreen"),
                leading: const Icon(
                  Icons.featured_play_list,
                  color: Colors.blueAccent,
                ),
                title: const Text("Orders"),
              ),
              const Divider(),
              if (userData["isAdmin"])
                ListTile(
                  onTap: () => Navigator.pushNamed(context, "/dashboard"),
                  leading: const Icon(
                    Icons.dashboard,
                    color: Colors.blueAccent,
                  ),
                  title: const Text("DashBoard"),
                ),
              ListTile(
                onTap: () => Navigator.pop(context),
                leading: const Icon(Icons.settings, color: Colors.blueAccent),
                title: const Text("Settings"),
              ),
              ListTile(
                onTap: () => Navigator.pop(context),
                leading: const Icon(
                  Icons.help_outline,
                  color: Colors.blueAccent,
                ),
                title: const Text("Help & Support"),
              ),
              const Spacer(),
              const Divider(),
              ListTile(
                onTap: () {
                  Navigator.pushReplacementNamed(context, "/");
                },
                leading: const Icon(Icons.logout, color: Colors.red),
                title: const Text(
                  "Logout",
                  style: TextStyle(color: Colors.red),
                ),
              ),
              const SizedBox(height: 16),
            ],
          ),
        );
      },
    );
  }
}
