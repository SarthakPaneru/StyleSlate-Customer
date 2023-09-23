import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';

class UserSearch extends StatefulWidget {
  const UserSearch({Key? key}) : super(key: key);

  @override
  _UserSearchState createState() => _UserSearchState();
}

class _UserSearchState extends State<UserSearch> {
  late TextEditingController _searchController;
  late Position _currentPosition;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
    _getCurrentLocation();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0, // Remove the AppBar shadow
        title: TextField(
          controller: _searchController,
          style: TextStyle(color: Colors.black, fontSize: 18),
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            hintText: 'Search for users',
            hintStyle: TextStyle(color: Colors.grey),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(8),
              borderSide: BorderSide.none, // Hide the search bar border
            ),
            prefixIcon: Icon(Icons.search, color: Colors.grey),
            suffixIcon: IconButton(
              icon: Icon(Icons.clear, color: Colors.grey),
              onPressed: () {
                _searchController.clear();
              },
            ),
          ),
          onSubmitted: (String value) {
            // Perform search functionality here
            // Implement your search logic based on the entered value and the current location
            print('Search query: $value');
          },
        ),
      ),
      body: Container(
        child: ListView(
          children: [
            // First search result
            Container(
              height: 100,
              width: double.infinity,
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('A'),
                  ),
                  title: Text('User A'),
                  subtitle: Text('A user'),
                ),
              ),
            ),
            // Second search result
            Container(
              height: 100,
              width: double.infinity,
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('B'),
                  ),
                  title: Text('User B'),
                  subtitle: Text('A user'),
                ),
              ),
            ),
            // Third search result
            Container(
              height: 100,
              width: double.infinity,
              child: Card(
                child: ListTile(
                  leading: CircleAvatar(
                    child: Text('C'),
                  ),
                  title: Text('User C'),
                  subtitle: Text('A user'),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _getCurrentLocation() async {
    var currentPosition = await Geolocator.getCurrentPosition();
    setState(() {
      _currentPosition = currentPosition;
    });
  }
}