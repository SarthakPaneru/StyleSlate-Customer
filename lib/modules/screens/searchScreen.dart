// search_screen.dart
import 'package:flutter/material.dart';
import 'package:hamro_barber_mobile/modules/screens/search_functionality.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final TextEditingController _textController = TextEditingController();
  final SearchService _searchService = SearchService();
  List<Map<String, String>> _searchResults = [];
  bool _isSearching = false;

  void _onSearchSubmitted(String query) async {
    setState(() {
      _isSearching = true;
    });
    try {
      List<Map<String, String>> results =
          await _searchService.fetchBarbers(query);
      setState(() {
        _searchResults = results;
      });
    } catch (e) {
      print(e);
    }
    setState(() {
      _isSearching = false;
    });
  }

  Widget _buildDropdownMenu() {
    if (_isSearching) {
      return const Center(child: CircularProgressIndicator());
    }
    return Column(
      children: [
        ..._searchResults.map((result) => ListTile(
              title: Text(result["name"]!),
              subtitle: Text(result["category"]!),
              onTap: () {
                // Navigator.push(
                //   context,
                //   MaterialPageRoute(
                //     builder: (context) =>
                //         BookingPage(barberName: result["name"]!),
                //   ),
                // );
              },
            )),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xff323345),
      appBar: AppBar(
        backgroundColor: const Color(0xff323345),
        title: TextField(
          controller: _textController,
          decoration: const InputDecoration(
            hintText: 'Find Your Barber',
            hintStyle: TextStyle(color: Colors.white),
            border: InputBorder.none,
          ),
          style: const TextStyle(color: Colors.white),
          onChanged: _onSearchSubmitted,
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.clear, color: Colors.white),
            onPressed: () {
              _textController.clear();
              setState(() {
                _searchResults = [];
              });
            },
          ),
        ],
      ),
      body: _textController.text.isNotEmpty
          ? _buildDropdownMenu()
          : Center(
              child: Text(
                'Type to search for barbers',
                style: TextStyle(color: Colors.white),
              ),
            ),
    );
  }
}
