import 'package:flutter/material.dart';

// Assuming this is the structure of your API requests class
class ApiRequests {
  Future<List<Map<String, dynamic>>> getFavBarbers(int customerId) async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));
    return [
      {
        'id': 1,
        'name': 'SK Hair Style',
        'location': 'Satdobato',
        'image': 'assets/stylist2.png'
      },
      {
        'id': 2,
        'name': 'Modern Cuts',
        'location': 'Patan',
        'image': 'assets/stylist1.png'
      },
      {
        'id': 3,
        'name': 'Classy Trims',
        'location': 'Thamel',
        'image': 'assets/stylist3.png'
      },
      {
        'id': 4,
        'name': 'Gents Parlour',
        'location': 'Balaju',
        'image': 'assets/stylist4.png'
      },
      {
        'id': 5,
        'name': 'Hair Masters',
        'location': 'Bhaktapur',
        'image': 'assets/stylist5.png'
      },
    ];
  }

  Future<void> removeFavBarber(int customerId, int barberId) async {
    // Simulate API call
    await Future.delayed(Duration(seconds: 1));
    print('Removed barber $barberId for customer $customerId');
  }
}

class FavouritePage extends StatefulWidget {
  final int customerId;
  FavouritePage({Key? key, required this.customerId}) : super(key: key);

  @override
  State<FavouritePage> createState() => _FavouritePageState();
}

class _FavouritePageState extends State<FavouritePage> {
  final ApiRequests _apiRequests = ApiRequests();
  List<Map<String, dynamic>> favouriteBarbers = [];
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadFavouriteBarbers();
  }

  Future<void> _loadFavouriteBarbers() async {
    setState(() => isLoading = true);
    try {
      final barbers = await _apiRequests.getFavBarbers(widget.customerId);
      setState(() {
        favouriteBarbers = barbers;
        isLoading = false;
      });
    } catch (e) {
      print('Error loading favourite barbers: $e');
      setState(() => isLoading = false);
    }
  }

  Future<void> removeFavorite(int index) async {
    final barber = favouriteBarbers[index];
    setState(() {
      favouriteBarbers.removeAt(index);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('${barber['name']} removed from favourites'),
        backgroundColor: Colors.red,
        duration: Duration(seconds: 2),
        action: SnackBarAction(
          label: 'UNDO',
          onPressed: () {
            setState(() {
              favouriteBarbers.insert(index, barber);
            });
          },
        ),
      ),
    );

    try {
      await _apiRequests.removeFavBarber(widget.customerId, barber['id']);
    } catch (e) {
      print('Error removing favourite barber: $e');
      setState(() {
        favouriteBarbers.insert(index, barber);
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Failed to remove ${barber['name']} from favourites'),
          backgroundColor: Colors.orange,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Favourite Barbers',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Color(0xff323345),
        elevation: 0,
      ),
      body: Container(
        color: Color(0xff323345),
        child: isLoading ? _buildLoadingIndicator() : _buildFavouriteList(),
      ),
    );
  }

  Widget _buildLoadingIndicator() {
    return Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }

  Widget _buildFavouriteList() {
    if (favouriteBarbers.isEmpty) {
      return Center(
        child: Text(
          'No favourite barbers yet',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      );
    }

    return ListView.builder(
      itemCount: favouriteBarbers.length,
      itemBuilder: (context, index) {
        final barber = favouriteBarbers[index];
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 16.0),
          child: Card(
            elevation: 4.0,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.0),
            ),
            color: Color(0xff3E4058),
            child: ListTile(
              contentPadding: EdgeInsets.all(16.0),
              leading: CircleAvatar(
                radius: 30,
                backgroundImage: AssetImage(barber['image']),
              ),
              title: Text(
                barber['name'],
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                  fontSize: 18,
                ),
              ),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 8),
                  Row(
                    children: [
                      Icon(Icons.location_on, color: Colors.white70, size: 16),
                      SizedBox(width: 4),
                      Text(
                        barber['location'],
                        style: TextStyle(color: Colors.white70),
                      ),
                    ],
                  ),
                ],
              ),
              trailing: IconButton(
                icon: Icon(Icons.favorite, color: Colors.red),
                onPressed: () => removeFavorite(index),
              ),
            ),
          ),
        );
      },
    );
  }
}
