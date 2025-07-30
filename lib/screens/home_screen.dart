import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scholar_shopping_app/cubits/category_cubit/category_cubit.dart';
import 'package:scholar_shopping_app/cubits/product_cubit/product_cubit.dart';
import 'package:scholar_shopping_app/cubits/wishlist_cubit/wishlist_cubit.dart';
import 'package:scholar_shopping_app/models/product_model.dart';
import 'package:scholar_shopping_app/screens/product_details_screen.dart';
import 'package:scholar_shopping_app/services/list_carts.dart';
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
  bool _isSearching = false;
  final TextEditingController _searchController = TextEditingController();
  List<ProductModel> _searchResults = [];

  Future<DocumentSnapshot> getUserData() async {
    return await FirebaseFirestore.instance
        .collection('users')
        .doc(userId)
        .get();
  }

  @override
  void initState() {
    super.initState();
    BlocProvider.of<CategoryCubit>(context).getCategory();
    _loadUserData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      final userId = FirebaseAuth.instance.currentUser!.uid;
      BlocProvider.of<WishlistCubit>(context).loadWishlist(userId);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  Future<void> _loadUserData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      fullName = prefs.getString("fulltname");
      email = prefs.getString("email");
      imagePath = prefs.getString("profileImagePath");
    });
  }

  void _searchProducts(String query) {
    if (query.isEmpty) {
      setState(() {
        _searchResults.clear();
      });
      return;
    }

    final cubit = BlocProvider.of<ProductCubit>(context);
    setState(() {
      _searchResults = cubit.productList.where((product) {
        return product.name.toLowerCase().contains(query.toLowerCase());
      }).toList();
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

  Widget _buildSearchField() {
    return TextField(
      controller: _searchController,
      autofocus: true,
      decoration: InputDecoration(
        hintText: 'Search products...',
        border: InputBorder.none,
        hintStyle: TextStyle(color: Colors.white70),
      ),
      style: TextStyle(color: Colors.white),
      onChanged: _searchProducts,
    );
  }

  Widget _buildProductGrid(List<ProductModel> products) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
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
          },
          childCount: products.length,
        ),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          childAspectRatio: 0.6,
        ),
      ),
    );
  }

  Widget _buildFeaturedProducts(List<ProductModel> products) {
    return SliverToBoxAdapter(
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
    );
  }

  @override
  Widget build(BuildContext context) {
    BlocProvider.of<ProductCubit>(context).getProduct();
    return BlocBuilder<ProductCubit, ProductState>(
      builder: (context, state) {
        final products = _isSearching ? _searchResults : 
                        BlocProvider.of<ProductCubit>(context).productList;

        return Scaffold(
          drawer: CustomDrawer(),
          appBar: AppBar(
            backgroundColor: Colors.blueAccent,
            leading: Builder(
              builder: (context) => IconButton(
                icon: const Icon(Icons.menu, color: Colors.white),
                onPressed: () => Scaffold.of(context).openDrawer(),
              ),
            ),
            title: _isSearching 
                ? _buildSearchField()
                : Row(
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
                        onPressed: () {
                          setState(() {
                            _isSearching = true;
                          });
                        },
                        icon: Icon(Icons.search, color: Colors.white),
                      ),
                    ],
                  ),
            actions: [
              if (_isSearching)
                IconButton(
                  icon: Icon(Icons.close, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      _isSearching = false;
                      _searchController.clear();
                      _searchResults.clear();
                    });
                  },
                ),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                if (!_isSearching) ...[
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
                  _buildFeaturedProducts(products),
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        "New Arrivals",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                ],
                _buildProductGrid(products),
              ],
            ),
          ),
        );
      },
    );
  }
}