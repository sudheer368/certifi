import 'package:flutter/material.dart';
import 'package:flutter_application_1/fileuploadin.dart';
import 'package:flutter_application_1/screens/profile_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  bool isSearching = false;
  TextEditingController searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: isSearching
            ? TextField(
                controller: searchController,
                decoration: InputDecoration(
                  hintText: "Search...",
                  border: InputBorder.none,
                ),
                style: TextStyle(color: Colors.white),
              )
            : Text("Certi..."),
        actions: [
          IconButton(
            icon: Icon(Icons.search),
            onPressed: () {
              setState(() {
                isSearching = !isSearching;
                if (!isSearching) {
                  // Handle cancel/close functionality
                  searchController.clear();
                }
              });
            },
          ),
          IconButton(
            icon: Icon(Icons.campaign_sharp),
            onPressed: () {
              // Add your onPressed functionality here
            },
          ),
          IconButton(
            icon: Icon(Icons.account_circle),
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProfileScreen()),
              );
              // Add your onPressed functionality here
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(onPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ImageUploading()),
        );
      }),
    );
  }
}
