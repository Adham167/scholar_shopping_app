import 'package:flutter/material.dart';

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
            Center(child: Text("Home Page")),
            Center(child: Text("Profile Page")),
          ],
        ),
      ),
    );
  }
}
