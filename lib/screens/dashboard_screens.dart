import 'package:flutter/material.dart';
import 'package:scholar_shopping_app/widgets/category_list_view.dart';
import 'package:scholar_shopping_app/widgets/product_list_view.dart';

class DashboardScreens extends StatelessWidget {
  const DashboardScreens({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.blueAccent,
          title: Text("Dashboard", style: TextStyle(color: Colors.white)),
          bottom: TabBar(
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white,
            labelStyle: TextStyle(fontSize: 20),
            tabs: [
              Tab(text: "Categories", icon: Icon(Icons.category)),
              Tab(text: "Products", icon: Icon(Icons.apps)),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: CategoryListView(),
              ),
            ),
            Center(child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: ProductListView(),
            )),
          ],
        ),
      ),
    );
  }
}
