import 'dart:convert';

import 'package:bloombox_mobile/Auth/profilePage.dart';
import 'package:bloombox_mobile/CartPage.dart';
import 'package:bloombox_mobile/OrdersPage.dart';
import 'package:flutter/material.dart';
import 'package:bloombox_mobile/AccompanimentsPage.dart';
import 'package:bloombox_mobile/PopularPage.dart';
import 'package:bloombox_mobile/VendersPage.dart';
import 'package:bloombox_mobile/categories_page.dart';
import 'package:bloombox_mobile/specialoccassions.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  String userName = ' '; // Replace with the logged-in user's name.

 // ignore: unused_element
 _loadUserData() async {
    SharedPreferences localStorage = await SharedPreferences.getInstance();
    var user = jsonDecode(localStorage.getString('user') ?? '{}'); // Null safety check

    if (user != null && user.isNotEmpty) {
      setState(() {
        userName = user['name']; // Assuming 'fname' contains the first name
      });
    }
  }
  @override
  void initState() {
    super.initState();
      _loadUserData();
  }

  // List of pages to navigate to based on the selected index

  // Navigation function based on the selected index
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
    // Navigate to the respective page when an item is tapped
    if (index == 0) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),  
      );
    } else if (index == 1) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => CartPage()), 
      );
    } else if (index == 2) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => Orderspage()),  
      );
    } else if (index == 3) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ProfilePage()),  
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.deepPurple,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Hello, $userName',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            
            Row(
              children: [
                IconButton(
                  icon: Icon(Icons.notifications),
                  onPressed: () {
                    // Handle notifications
                  },
                ),
                const CircleAvatar(
                  backgroundImage: AssetImage('assets/profile.jpg'),
                ),
              ],
            ),
          ],
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 20),
            TextField(
              decoration: InputDecoration(
                hintText: 'Search flowers, vendors...',
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10.0),
                  borderSide: BorderSide.none,
                ),
                filled: true,
                fillColor: Colors.grey[200],
              ),
            ),
            const SizedBox(height: 20),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  buildCategoryButton('Roses', Colors.pink),
                  buildCategoryButton('Tulips', Colors.orange),
                  buildCategoryButton('Orchids', Colors.purple),
                  buildCategoryButton('Lilies', Colors.blue),
                ],
              ),
            ),
            const SizedBox(height: 30),
            Text(
              'Popular',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 10),
            Expanded(
              child: ListView(
                children: [
                  buildCategorySection('Popular Flowers', PopularPage()),
                  buildCategorySection('Categories', CategoriesPage()),
                  buildCategorySection('Special Occasions', SpecialOccasions()),
                  buildCategorySection('Vendors Near You', VendorsPage()),
                  buildCategorySection('Accompaniments', AccompanimentsPage()),
                ],
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: <BottomNavigationBarItem>[
          const BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Home',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_basket),
            label: 'Cart',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.shopping_bag),
            label: 'Orders',
          ),
          BottomNavigationBarItem(
            icon: const Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.deepPurple,
        unselectedItemColor: Colors.grey,
        onTap: _onItemTapped,  // Tapping triggers the routing function
      ),
    );
  }

  Widget buildCategoryButton(String title, Color color) {
    return ElevatedButton(
      onPressed: () {
        // Action for button tap
      },
      child: Text(title),
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        shape: StadiumBorder(),
      ),
    );
  }

  Widget buildCategorySection(String title, Widget page) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => page),
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          SizedBox(
            height: 100,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                buildFlowerCard('Flower 1', 'assets/flower1.jpg'),
                buildFlowerCard('Flower 2', 'assets/flower2.jpg'),
                buildFlowerCard('Flower 3', 'assets/flower3.jpg'),
                buildFlowerCard('Flower 4', 'assets/flower4.jpg'),
              ],
            ),
          ),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  Widget buildFlowerCard(String name, String imagePath) {
    return Container(
      width: 100,
      margin: const EdgeInsets.only(right: 10),
      child: Column(
        children: [
          Expanded(
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.asset(
                imagePath,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 5),
          Text(name, style: TextStyle(fontSize: 14)),
        ],
      ),
    );
  }
}
